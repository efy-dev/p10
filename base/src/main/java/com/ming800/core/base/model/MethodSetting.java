package com.ming800.core.base.model;

import java.lang.reflect.Method;

/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 13-4-7
 * Time: 上午10:53
 * To change this template use File | Settings | File Templates.
 */
public class MethodSetting {

    private Method method;
    private String properties;


    public Method getMethod() {
        return method;
    }

    public void setMethod(Method method) {
        this.method = method;
    }

    public String getProperties() {
        return properties;
    }

    public void setProperties(String properties) {
        this.properties = properties;
    }
}
