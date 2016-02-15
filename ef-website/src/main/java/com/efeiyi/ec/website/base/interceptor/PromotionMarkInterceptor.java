package com.efeiyi.ec.website.base.interceptor;

import com.efeiyi.ec.zero.promotion.model.PromotionPlan;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.util.CookieTool;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
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
        String promotionSource = request.getParameter("source");
        if (promotionSource != null) {
            if (!promotionSource.equals(request.getSession().getAttribute("source"))) {
                LinkedHashMap<String, Object> queryParamMap = new LinkedHashMap<>();
                queryParamMap.put("identifier", promotionSource);
                PromotionPlan promotionPlan = (PromotionPlan) baseManager.getUniqueObjectByConditions("from PromotionPlan x where x.identifier=:identifier", queryParamMap);

                //返利计划是有效的
                if (promotionPlan != null && !"0".equals(promotionPlan.getStatus())) {
                    //只以最后一次点击的返利链接为准,存入Session和Cookie
                    CookieTool.addCookie(response, "source", promotionSource, promotionPlan.getRdDays() * 86400,"www.efeiyi.com");
                }else{
                    CookieTool.addCookie(response, "source", promotionSource, 86400 * 30,"www.efeiyi.com");
                }
                HttpSession session = request.getSession();
                session.setAttribute("source", promotionSource);
            }
        }
        return super.preHandle(request, response, handler);
    }
}
