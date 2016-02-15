package com.efeiyi.ec.website.base.authentication;

import org.apache.log4j.Logger;
import org.springframework.context.ApplicationContext;

/**
 * Created by Administrator on 2015/12/3.
 *
 */
public class ContextUtils {
    private static ApplicationContext applicationContext;

    private static Logger log = Logger.getLogger(ContextUtils.class);

    public static void setApplicationContext(ApplicationContext applicationContext) {
        synchronized (ContextUtils.class) {
            log.debug("setApplicationContext, notifyAll");
            ContextUtils.applicationContext = applicationContext;
            ContextUtils.class.notifyAll();
        }
    }

    public static ApplicationContext getApplicationContext() {
        synchronized (ContextUtils.class) {
            while (applicationContext == null) {
                try {
                    log.debug("getApplicationContext, wait...");
                    ContextUtils.class.wait(60000);
                    if (applicationContext == null) {
                        log.warn("Have been waiting for ApplicationContext to be set for 1 minute", new Exception());
                    }
                } catch (InterruptedException ex) {
                    log.debug("getApplicationContext, wait interrupted");
                }
            }
            return applicationContext;
        }
    }

    public static Object getBean(String name) throws  Exception{
        return getApplicationContext().getBean(name);
    }
}
