package com.efeiyi.association.listener;

import org.apache.commons.beanutils.ConvertUtils;
import org.apache.commons.beanutils.converters.DateConverter;
import org.springframework.web.context.ContextLoader;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

/**
 * Created by Administrator on 2015/9/9.
 */
public class InitListener extends ContextLoader implements ServletContextListener {
    @Override
    public void contextInitialized(ServletContextEvent sce) {
        ConvertUtils.register(new DateConverter(null), java.util.Date.class);
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {

    }
}
