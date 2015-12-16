package com.efeiyi.ec.website.interceptor;

import com.efeiyi.ec.organization.model.MyUser;
import com.efeiyi.ec.organization.model.User;
import com.efeiyi.ec.zero.promotion.model.PromotionPlan;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.util.CookieTool;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Calendar;
import java.util.LinkedHashMap;

/**
 * Created by Administrator on 2015/12/7.
 */
public class PromotionRegisterSuccessPersistenceInterceptor extends HandlerInterceptorAdapter {
    @Autowired
    private BaseManager baseManager;

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
        String promotionSource = (String) request.getSession().getAttribute("source");

        if(promotionSource == null){
            Cookie cookie = CookieTool.getCookieByName(request, "source");
            if(cookie != null){
                promotionSource = CookieTool.getCookieByName(request,"source").getValue();
            }
        }
        if (promotionSource != null) {
            LinkedHashMap<String, Object> queryParamMap = new LinkedHashMap<>();
            queryParamMap.put("identifier", promotionSource);
            PromotionPlan promotionPlan = (PromotionPlan) baseManager.getUniqueObjectByConditions("from PromotionPlan x where x.identifier=:identifier", queryParamMap);

            //营销返利有效时记录在注册来源
            if (promotionPlan != null && !"0".equals(promotionPlan.getStatus())) {
                MyUser user = (MyUser) baseManager.getObject(User.class.getName(), request.getParameter("userId"));
                user.setSource(promotionSource);
                Calendar calendar = Calendar.getInstance();
                calendar.add(Calendar.DATE,promotionPlan.getRdDays());
                user.setRdEndDay(calendar.getTime());
                baseManager.saveOrUpdate(User.class.getName(), user);
                request.getSession().removeAttribute("promotionSource");
            }
        }
    }
}
