package com.efeiyi.ec.system.listener.controller;

import com.ming800.core.does.service.DoManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Created by AC丶man on 2015/8/31.
 */

public class RoleListener implements HandlerInterceptor{
    @Autowired
    private DoManager doManager;
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
//        boolean  f = false;
//        String qm = request.getParameter("qm");
//        if(qm!=null&&!"".equals(qm)) {
//            Do tempDo = doManager.getDoByQueryModel(qm.split("_")[0]);
//            System.out.println(AuthorizationUtil.getUser().getRole().getName());
//            if (tempDo.getAccess().indexOf(AuthorizationUtil.getUser().getRole().getName()) == -1) {
//                response.sendRedirect("/role.jsp");
//            } else {
//                f =  true;
//            }
//        }
       return  true;
    }

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {

    }

    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {

    }
}
