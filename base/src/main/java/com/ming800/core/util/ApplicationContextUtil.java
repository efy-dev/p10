package com.ming800.core.util;

import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;

import java.util.Locale;

/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 12-11-9
 * Time: 上午9:40
 * To change this template use File | Settings | File Templates.
 */
public class ApplicationContextUtil implements ApplicationContextAware {
    public static ApplicationContext applicationContext;              //spring上下文

    @Override
    public void setApplicationContext(ApplicationContext applicationContext) throws BeansException {
        this.applicationContext = applicationContext;
    }

    public static ApplicationContext getApplicationContext() {
        return applicationContext;
    }

    /**
     * 获取国际化资源文件内容 地区默认为本地
     *
     * @param key 资源文件的键值
     * @return
     */
    public static String getLocalMessage(String key) {
        return applicationContext.getMessage(key, null, null);
    }

    /**
     * 获取国际化资源文件内容
     *
     * @param key     资源文件的键值；
     * @param objects 资源文件字符串的参数 ；
     * @param locale  ava.util. Locale 类型的参数。参数为 null ，则表示根据使用者的语言环境来选择 Locale
     * @return
     */
    public static String getMessage(String key, Object[] objects, Locale locale) {
        return applicationContext.getMessage(key, objects, locale);
    }
}
