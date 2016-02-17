package com.efeiyi.ec.consumer.base.interceptor;

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
        if (mav != null && mav.getViewName() != null && !mav.getViewName().startsWith("redirect") && !mav.getViewName().startsWith("forward")) {

            if (!HttpUtil.isPhone(request.getHeader("User-Agent"))) {
                mav.setViewName("/pc" + mav.getViewName());
            } else {
                mav.setViewName("/wap" + mav.getViewName());
            }
        }
        response.setHeader("X-Frame-Options","");
    }


    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception{

        response.setCharacterEncoding("utf-8");
        response.setContentType("text/html;charset=utf-8");
        request.setCharacterEncoding("utf-8");

        return true;
    }


}
