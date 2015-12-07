package com.efeiyi.ec.website.interceptor;

import com.efeiyi.ec.organization.model.User;
import com.efeiyi.ec.website.organization.util.AuthorizationUtil;
import com.efeiyi.jh.advertisement.model.PromotionPlan;
import com.efeiyi.jh.advertisement.model.PromotionUserRecord;
import com.ming800.core.base.service.BaseManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Calendar;
import java.util.Date;
import java.util.LinkedHashMap;

/**
 * Created by Administrator on 2015/12/4.
 */
public class PromotionPersistenceInterceptor extends HandlerInterceptorAdapter {
    @Autowired
    private BaseManager baseManager;

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
        String promotionChannel = (String) request.getSession().getAttribute("pch");
        if (promotionChannel != null) {
            if (AuthorizationUtil.isAuthenticated()) {
                PromotionPlan promotionPlan = (PromotionPlan) baseManager.getObject(PromotionPlan.class.getName(), promotionChannel);
                if (promotionPlan != null) {
                    User user = AuthorizationUtil.getUser();
                    LinkedHashMap<String, Object> queryParamMap = new LinkedHashMap<>();
                    queryParamMap.put("user", user);
                    PromotionUserRecord promotionUserRecord = (PromotionUserRecord) baseManager.getUniqueObjectByConditions("from PromotionUserRecord x where x.user=:user", queryParamMap);
                    if (promotionUserRecord == null) {
                        promotionUserRecord = new PromotionUserRecord();
                    }
                    promotionUserRecord.setPromotionPlan(promotionPlan);
                    promotionUserRecord.setUser(user);
                    Calendar calendar = Calendar.getInstance();
                    calendar.add(Calendar.DATE,promotionPlan.getRdDays());
                    promotionUserRecord.setRdEndDate(calendar.getTime());
                    baseManager.saveOrUpdate(PromotionUserRecord.class.getName(), promotionUserRecord);
                    request.getSession().removeAttribute("pch");
                }
            }
        }
    }
    public static void main(String[]args){
        Calendar calendar = Calendar.getInstance();
        calendar.add(Calendar.DATE,30);
        System.out.println(calendar.getTime());
    }
}
