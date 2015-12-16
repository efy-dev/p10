//package com.efeiyi.ec.website.interceptor;
//
//import com.efeiyi.ec.organization.model.User;
//import com.efeiyi.jh.advertisement.model.PromotionPlan;
//import com.efeiyi.jh.advertisement.model.PromotionUserRecord;
//import com.ming800.core.base.service.BaseManager;
//import com.ming800.core.util.CookieTool;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.web.servlet.ModelAndView;
//import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
//
//import javax.servlet.http.Cookie;
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//import java.util.Calendar;
//import java.util.LinkedHashMap;
//
///**
// * Created by Administrator on 2015/12/7.
// */
//public class PromotionRegisterSuccessPersistenceInterceptor extends HandlerInterceptorAdapter {
//    @Autowired
//    private BaseManager baseManager;
//
//    @Override
//    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
//        String promotionChannel = (String) request.getSession().getAttribute("pch");
//
//        if(promotionChannel == null){
//            Cookie cookie = CookieTool.getCookieByName(request, "pch");
//            if(cookie != null){
//                promotionChannel = CookieTool.getCookieByName(request,"pch").getValue();
//            }
//        }
//        if (promotionChannel != null) {
//            PromotionPlan promotionPlan = (PromotionPlan) baseManager.getObject(PromotionPlan.class.getName(), promotionChannel);
//            //营销返利有效时记录在注册来源
//            if (promotionPlan != null && !"0".equals(promotionPlan.getStatus())) {
//                User user = (User) baseManager.getObject(User.class.getName(), request.getParameter("userId"));
//                LinkedHashMap<String, Object> queryParamMap = new LinkedHashMap<>();
//                queryParamMap.put("user", user);
//                PromotionUserRecord promotionUserRecord = new PromotionUserRecord();
//                promotionUserRecord.setPromotionPlan(promotionPlan);
//                promotionUserRecord.setUser(user);
//                Calendar calendar = Calendar.getInstance();
//                calendar.add(Calendar.DATE,promotionPlan.getRdDays());
//                promotionUserRecord.setRdEndDate(calendar.getTime());
//                baseManager.saveOrUpdate(PromotionUserRecord.class.getName(), promotionUserRecord);
//                request.getSession().removeAttribute("pch");
//            }
//        }
//    }
//}
