package com.efeiyi.ec.website.interceptor;

import com.efeiyi.ec.organization.model.User;
import com.efeiyi.jh.advertisement.model.PromotionPlan;
import com.efeiyi.jh.advertisement.model.PromotionUserRecord;
import com.ming800.core.base.service.BaseManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Calendar;
import java.util.LinkedHashMap;

/**
 * Created by Administrator on 2015/12/7.
 * 拦截注册成功，记录用户来源的营销返利渠道
 */
public class PromotionRegisterSuccessPersistenceInterceptor extends HandlerInterceptorAdapter {
    @Autowired
    private BaseManager baseManager;

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
        String promotionChannel = (String) request.getSession().getAttribute("pch");
        if (promotionChannel != null) {
            PromotionPlan promotionPlan = (PromotionPlan) baseManager.getObject(PromotionPlan.class.getName(), promotionChannel);
            if (promotionPlan != null) {
                User user = (User) baseManager.getObject(User.class.getName(), request.getParameter("userId"));
                LinkedHashMap<String, Object> queryParamMap = new LinkedHashMap<>();
                queryParamMap.put("user", user);
                //标记用户点击营销返利链接的来源
                PromotionUserRecord promotionUserRecord = new PromotionUserRecord();
                promotionUserRecord.setPromotionPlan(promotionPlan);
                promotionUserRecord.setLatestPromotionPlan(promotionPlan);
                promotionUserRecord.setUser(user);
                //记录营销返利链接有效期
                Calendar calendar = Calendar.getInstance();
                calendar.add(Calendar.DATE,promotionPlan.getRdDays());
                promotionUserRecord.setRdEndDate(calendar.getTime());
                baseManager.saveOrUpdate(PromotionUserRecord.class.getName(), promotionUserRecord);
                request.getSession().removeAttribute("pch");
            }
        }
    }
}
