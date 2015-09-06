package com.efeiyi.ec.base.filter;

/**
 * Created by Administrator on 2015/9/1.
 *
 */
import org.apache.log4j.Logger;

import java.io.IOException;
import java.util.Date;
import java.util.Enumeration;
import java.util.HashMap;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.annotation.WebInitParam;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebFilter(filterName="StaticCacheFilter",urlPatterns={"*.js","*.css"},asyncSupported = true,initParams={@WebInitParam(name="js", value="600"),@WebInitParam(name="css", value="600"),@WebInitParam(name="gif", value="120960000"),@WebInitParam(name="jpg", value="120960000"),@WebInitParam(name="png", value="120960000")})
public class StaticCacheFilter implements Filter {
    private static Logger logger = Logger.getLogger(StaticCacheFilter.class);
    private static FilterConfig filterConfig = null;
    private static HashMap expiresMap = new HashMap();
    @Override
    public void destroy() {

    }
    @Override
    public void doFilter(ServletRequest request, ServletResponse response,FilterChain chain) throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        String uri = req.getRequestURI();
        String ext = null;
        int dot =  uri.lastIndexOf(".");
        if( dot != -1 )
        {
            ext = uri.substring( dot+1 );
        }

        setResponseHeader( res, uri, ext );

        chain.doFilter(request, response);

    }

    public static void init2(FilterConfig config) throws ServletException {
        filterConfig = config;
        expiresMap.clear();
        Enumeration names = config.getInitParameterNames();
        while( names.hasMoreElements() )
        {
            try
            {
                String name = (String)names.nextElement();
                String value = config.getInitParameter( name );
                Integer expire = Integer.valueOf( value );
                expiresMap.put( name, expire );
            }
            catch( Exception ex)
            {
                logger.info(ex);
            }
        }
    }
    @Override
    public  void init(FilterConfig config) throws ServletException {
        this.filterConfig = config;
        expiresMap.clear();
        Enumeration names = config.getInitParameterNames();
        while( names.hasMoreElements() )
        {
            try
            {
                String name = (String)names.nextElement();
                String value = config.getInitParameter( name );
                Integer expire = Integer.valueOf( value );
                expiresMap.put( name, expire );
            }
            catch( Exception ex)
            {
                logger.info(ex);
            }
        }
    }
    private void setResponseHeader( HttpServletResponse response, String uri, String ext )
    {
        if( ext!= null && ext.length() > 0 )
        {
            Integer expires = (Integer)expiresMap.get(ext);
            if( expires != null )
            {
                logger.info( uri + ".Expires: "+ expires.intValue());
                if( expires.intValue() > 0 )
                {
                    response.setHeader("Cache-Control","max-age="+expires.intValue()); //HTTP 1.1
                    response.setDateHeader ("Expires", new Date().getTime()*2);
                    response.setHeader("Pragma","public");
                }
                else
                {
                    response.setHeader("Cache-Control","no-cache");
                    response.setHeader("Pragma","no-cache"); //HTTP 1.0
                    response.setDateHeader("Expires", 0);
                }
            }
        }
    }

}
