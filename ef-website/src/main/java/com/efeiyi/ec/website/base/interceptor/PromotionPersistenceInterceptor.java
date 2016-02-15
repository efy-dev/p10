package com.efeiyi.ec.website.base.interceptor;

import com.efeiyi.ec.organization.model.MyUser;
import com.efeiyi.ec.website.organization.util.AuthorizationUtil;
import com.efeiyi.ec.zero.promotion.model.PromotionUserRecord;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.util.CookieTool;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Date;

/**
 * 拦截登录，判断用户是否点击过营销返利链接，并记录
 * Created by Administrator on 2015/12/4.
 */
public class PromotionPersistenceInterceptor extends HandlerInterceptorAdapter {
    @Autowired
    private BaseManager baseManager;

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
        //先Session后cookie找返利计划
        String promotionSource = (String) request.getSession().getAttribute("source");
        if (promotionSource == null) {
            Cookie cookie = CookieTool.getCookieByName(request, "source");
            if (cookie != null) {
                promotionSource = cookie.getValue();
            }
        }
        if (promotionSource != null) {
            if (AuthorizationUtil.isAuthenticated()) {
                //营销计划有效
                MyUser user = (MyUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();

                //生成一条返利有关的登录日志
                PromotionUserRecord promotionUserRecord = new PromotionUserRecord();
                promotionUserRecord.setCreateDatetime(new Date());
                promotionUserRecord.setIdentifier(promotionSource);
                promotionUserRecord.setUser(user);
                baseManager.saveOrUpdate(PromotionUserRecord.class.getName(), promotionUserRecord);

            }
        }
    }
}
