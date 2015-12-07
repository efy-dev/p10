package com.efeiyi.ec.website.interceptor;

import com.efeiyi.ec.organization.model.User;
import com.efeiyi.ec.website.organization.util.AuthorizationUtil;
import com.efeiyi.jh.advertisement.model.PromotionPlan;
import com.efeiyi.jh.advertisement.model.PromotionUserRecord;
import com.ming800.core.base.service.BaseManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.Calendar;
import java.util.Date;
import java.util.LinkedHashMap;

/**
 * Created by Administrator on 2015/12/3.
 * 任意页面点击营销返利链接进入时拦截，营销标记存入Session
 */
public class PromotionMarkInterceptor extends HandlerInterceptorAdapter {

    @Autowired
    private BaseManager baseManager;

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        String promotionChannel = request.getParameter("pch");
        if (promotionChannel != null) {
            HttpSession session = request.getSession();
            String previousPChannel = (String) session.getAttribute("pch");

            if (!promotionChannel.equals(previousPChannel)) {
                if (AuthorizationUtil.isAuthenticated()) {
                    User user = AuthorizationUtil.getUser();
                    LinkedHashMap<String, Object> queryParamMap = new LinkedHashMap<>();
                    queryParamMap.put("user", user);
                    //找出过去标记用户点击营销返利链接的来源，如果null，新建
                    PromotionUserRecord promotionUserRecord = (PromotionUserRecord) baseManager.getUniqueObjectByConditions("from PromotionUserRecord x where x.user=:user", queryParamMap);
                    if (promotionUserRecord == null) {
                        promotionUserRecord = new PromotionUserRecord();
                    }
                    promotionUserRecord.setUser(user);
                    PromotionPlan promotionPlan = (PromotionPlan) baseManager.getObject(PromotionPlan.class.getName(), promotionChannel);
                    //保存的点击新的营销返利链接
                    promotionUserRecord.setLatestPromotionPlan(promotionPlan);
                    //刷新营销返利链接有效期
                    Calendar calendar = Calendar.getInstance();
                    calendar.add(Calendar.DATE,promotionPlan.getRdDays());
                    promotionUserRecord.setRdEndDate(calendar.getTime());
                    baseManager.saveOrUpdate(PromotionUserRecord.class.getName(), promotionUserRecord);
                }
                //只以最后一次点击的返利链接为准
                session.setAttribute("pch", promotionChannel);
            }
        }
        return super.preHandle(request, response, handler);
    }
}
