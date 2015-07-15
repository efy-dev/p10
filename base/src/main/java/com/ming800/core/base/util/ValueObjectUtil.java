package com.ming800.core.base.util;

import java.lang.reflect.Method;

/**
 * @author WuYingbo
 */
public class ValueObjectUtil {

    @SuppressWarnings("unchecked")
    public static String getValueObject(String str, Object object) {
        Class c = object.getClass();
        Object obj = null;
        Method m = null;
        String fieldName = str.split("\\.")[0];
        String methodName = "get" + fieldName.substring(0, 1).toUpperCase() + fieldName.substring(1);
        try {
            m = c.getDeclaredMethod(methodName);
            obj = m.invoke(object);
        } catch (Exception e) {
            e.printStackTrace();
        }
        if (obj != null) {
            if (str.split("\\.").length > 1) {
                return getValueObject(str.substring(str.indexOf(".") + 1), obj);
            } else {
                return obj.toString();
            }
        }
        return null;
    }

}