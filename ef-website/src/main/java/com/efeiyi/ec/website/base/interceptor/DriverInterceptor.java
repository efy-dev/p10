package com.efeiyi.ec.website.base.interceptor;

import com.ming800.core.p.PConst;
import com.ming800.core.util.CookieTool;
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

            if (response.getStatus() >= 200 && response.getStatus() < 300) {
                String url = request.getRequestURL().toString();
                if (url.startsWith("http://" + PConst.WEBSITE_WIKI_HOST + "/".toLowerCase()) && !url.endsWith("login")) {
                    mav.setViewName("/wiki/jsp" + mav.getViewName());
                } else if (url.startsWith("http://" + PConst.WEBSITE_CONSUMER_HOST + "/".toLowerCase()) && !url.endsWith("login")) {
                    mav.setViewName("/consumer/jsp" + mav.getViewName());
                }
            }

        }
        response.setHeader("X-Frame-Options", "");
    }


    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        //获取当前请求的路径
        CookieTool.addCookie(response, "JSESSIONID", request.getRequestedSessionId(), 100000, "efeiyi.com");
        response.setCharacterEncoding("utf-8");
        response.setContentType("text/html;charset=utf-8");
        request.setCharacterEncoding("utf-8");

//        response.setHeader("Access-Control-Allow-Origin", "*");

        String url = request.getRequestURL().toString();

        if (url.endsWith("404") || url.endsWith("500") || url.endsWith("404")) {
            return true;
        } else if (url.startsWith("http://" + PConst.WEBSITE_WIKI_HOST + "/".toLowerCase()) && url.endsWith("login")) {
            return true;
        } else if (url.startsWith("http://" + PConst.WEBSITE_CONSUMER_HOST + "/".toLowerCase()) && url.endsWith("login")) {
            return true;
        } else if (url.equalsIgnoreCase("http://" + PConst.WEBSITE_WIKI_HOST + "/")) {
            response.sendRedirect("http://" + PConst.WEBSITE_WIKI_HOST + "/minglu");
            return false;
        } else if (url.equalsIgnoreCase("http://" + PConst.WEBSITE_CONSUMER_HOST + "/")) {
            response.sendRedirect("http://" + PConst.WEBSITE_CONSUMER_HOST + "/order/myEfeiyi/list.do");
            return false;
        }
        return true;
    }


}
