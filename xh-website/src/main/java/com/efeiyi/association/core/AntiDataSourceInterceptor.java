package com.efeiyi.association.core;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Created by Administrator on 2015/10/30.
 */
@Deprecated
public class AntiDataSourceInterceptor extends HandlerInterceptorAdapter {

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
    public void afterConcurrentHandlingStarted(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

//        DatabaseContextHolder.getDataSourceLock(request).unlock();

    }
}
