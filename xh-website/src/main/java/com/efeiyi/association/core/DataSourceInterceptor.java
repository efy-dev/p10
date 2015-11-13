package com.efeiyi.association.core;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Created by Administrator on 2015/7/20.
 * 多数据源切换拦截器
 */
public class DataSourceInterceptor extends HandlerInterceptorAdapter {




//    /**
//     * 拦截后处理，当前策略为恢复默认数据源
//     *
//     * @param request
//     * @param response
//     * @param o
//     * @param mav
//     * @throws Exception
//     */
//    public void postHandle(HttpServletRequest request,
//                           HttpServletResponse response, Object o, ModelAndView mav)
//            throws Exception {
//
//            DatabaseContextHolder.setDataSource(null);
//
//    }

    /**
     * 拦截前处理，当前策略为直接选择第二数据源
     *
     * @param request
     * @param response
     * @param handler
     * @return
     * @throws Exception
     */
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
            throws Exception {

//        DatabaseContextHolder.getDataSourceLock(request).lock();

        DatabaseContextHolder.setDataSource("dataSource");

        return true;
    }

    /**
     * 拦截最后解锁
     * @param request
     * @param response
     * @param handler
     * @throws Exception
     */
    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {

        DatabaseContextHolder.setDataSource("null");

    }
}
