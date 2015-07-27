package com.efeiyi.ec.personal.tenant.interceptor;

import org.apache.log4j.Logger;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Created by kayson on 2015/7/25.
 *
 */
public class BaseTenantInterceptor implements HandlerInterceptor {
    private static Logger logger = Logger.getLogger(BaseTenantInterceptor.class);
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        logger.info("解析泛域名 begin...");
        String DOMAIN ="efeiyi.com";
        String domainName;

        // 获取域名
        String serverName = request.getServerName();
        // 判断是否是三级域名
        int end = serverName.indexOf(DOMAIN);
        // 获取domain
        if (end != -1 && end != 0) {
            domainName = serverName.substring(0, end - 1);
        } else {
            domainName = "master";
        }
        request.setAttribute("domainName",domainName);
        logger.info("解析泛域名 end...");
        return true;
    }

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {

    }

    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {

    }
}
