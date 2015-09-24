package com.efeiyi.association.core;

import com.ming800.core.util.HttpUtil;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Created by Administrator on 2015/7/20.
 */
public class DataSourceInterceptor extends HandlerInterceptorAdapter {

    public void postHandle(HttpServletRequest request,
                           HttpServletResponse response, Object o, ModelAndView mav)
            throws Exception {
        DatabaseContextHolder.setDataSource(null);
    }

    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
            throws Exception {
        DatabaseContextHolder.setDataSource("dataSource");
        return true;
    }
}
