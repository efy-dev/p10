package com.ming800.core.base.model;


import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;

/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 13-12-11
 * Time: 下午3:26
 * To change this template use File | Settings | File Templates.
 */
public class MultiDataSourceFilter implements Filter {

    public MultiDataSourceFilter() {
    }

    public void init(FilterConfig filterConfig) throws ServletException {
    }

    public void doFilter(ServletRequest request, ServletResponse response,
                         FilterChain chain) throws IOException, ServletException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        String dataSource = httpRequest.getParameter("dataSource");


        SpObserver.putSp(dataSource);
        chain.doFilter(request, response);
    }

    public void destroy() {

    }

}
