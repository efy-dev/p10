package com.efeiyi.ec.system.interceptor;

import com.ming800.core.util.HttpUtil;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Created by Administrator on 2015/7/20.
 */
public class DriverInterceptor extends HandlerInterceptorAdapter {

    public void postHandle(HttpServletRequest request,
                           HttpServletResponse response, Object o, ModelAndView mav)
            throws Exception {
        String userAgent = request.getHeader("User-Agent");
//        if (!request.getRequestURI().startsWith("/batchUpdateObject") && !request.getRequestURI().startsWith("/index") && !request.getRequestURI().startsWith("/xdos/") && !request.getRequestURI().startsWith("/role/") && !request.getRequestURI().startsWith("/manage/") && !request.getRequestURI().startsWith("/main") && !request.getRequestURI().startsWith("/basic/") && !request.getRequestURI().startsWith("/WEB-INF/") && !request.getRequestURI().startsWith("/do/")) {
        if (!HttpUtil.isPhone(userAgent)) {
            mav.setViewName("/pc" + mav.getViewName());
        } else {
            mav.setViewName("/wep" + mav.getViewName());
        }
//        }
    }


}
