package com.efeiyi.ec.website.interceptor;

import com.efeiyi.ec.organization.model.MyUser;
import com.efeiyi.ec.organization.model.User;
import com.efeiyi.ec.website.organization.util.AuthorizationUtil;
import com.efeiyi.ec.zero.promotion.model.PromotionPlan;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.util.CookieTool;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Calendar;
import java.util.LinkedHashMap;

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
        if(promotionSource == null){
            Cookie cookie = CookieTool.getCookieByName(request, "source");
            if(cookie != null){
                promotionSource = CookieTool.getCookieByName(request,"source").getValue();
            }
        }
        if (promotionSource != null) {
            if (AuthorizationUtil.isAuthenticated()) {
                LinkedHashMap<String, Object> queryParamMap = new LinkedHashMap<>();
                queryParamMap.put("identifier", promotionSource);
                PromotionPlan promotionPlan = (PromotionPlan) baseManager.getUniqueObjectByConditions("from PromotionPlan x where x.identifier=:identifier", queryParamMap);

                //营销计划有效
                if (promotionPlan != null && !"0".equals(promotionPlan.getStatus())) {
                    MyUser user = (MyUser)SecurityContextHolder.getContext().getAuthentication().getPrincipal();

                    //和旧的返利标识不同时，记录
                    if(!promotionSource.equals(user.getSource())){
                        user.setSource(promotionSource);
                        //刷新营销返利链接有效期
                        Calendar calendar = Calendar.getInstance();
                        calendar.add(Calendar.DATE,promotionPlan.getRdDays());
                        user.setRdEndDay(calendar.getTime());
                        baseManager.saveOrUpdate(MyUser.class.getName(), user);
                        request.getSession().removeAttribute("source");
                    }
                }
            }
        }
    }
}
