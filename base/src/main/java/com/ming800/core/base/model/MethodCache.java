package com.ming800.core.base.model;

import com.ming800.core.does.model.*;
import com.ming800.core.base.util.ReflectUtil;

import java.lang.reflect.Method;
import java.lang.reflect.ParameterizedType;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 13-4-7
 * Time: 上午10:49
 * To change this template use File | Settings | File Templates.
 */
public class MethodCache {


    private MethodSetting methodSetting;
    private Map<String, MethodSetting> methodSettingMap;


    public void init(Do tempDo, Page tempPage) throws Exception {
        methodSettingMap = new HashMap<>();
//        Page tempPage = tempDo.getPageList().get(0);

        Class objectClass = Class.forName(tempDo.getXentity().getModel());

        for (PageField pageField : tempPage.getFieldList()) {
            String field = pageField.getName();

            methodSettingMap = generateGetMethodSettingMap(methodSettingMap, objectClass, field.split("\\."), pageField.getDataType());

        }

    }

    public void init(Xentity xentity) throws Exception {
        methodSettingMap = new HashMap<>();
        for (Field field : xentity.getFieldMap().values()) {
            methodSettingMap = generateSetMethodSettingMap(methodSettingMap, Class.forName(xentity.getModel()), field.getName().split("\\."), field.getDataType());
        }
    }

    private Map<String, MethodSetting> generateGetMethodSettingMap(Map<String, MethodSetting> methodSettingMap, Class objectClass, String[] tags, String dataType) {

        StringBuilder methodName = new StringBuilder(32);
        String[] subTags = null;
        if (tags.length > 0) {
            methodName.append(tags[0]);
            if (tags.length > 1) {
                subTags = Arrays.copyOfRange(tags, 1, tags.length);
            }
        }

        methodName.setCharAt(0, Character.toUpperCase(methodName.charAt(0)));
        methodName.insert(0, "get");

        String methodNameStr = methodName.toString();
        Method method = ReflectUtil.getM8DeclaredMethod(objectClass, methodNameStr);

        MethodSetting methodSetting = new MethodSetting();
        methodSetting.setMethod(method);

        if (tags.length == 1) {
            methodSetting.setProperties(dataType);
        }

        methodSettingMap.put(objectClass.getSimpleName() + "_" + tags[0], methodSetting);

        if (tags.length > 1) {
            Class returnType = method.getReturnType();
            if (methodNameStr.endsWith("List")) {
                ParameterizedType pt = (ParameterizedType) method.getGenericReturnType();
                returnType = (Class) pt.getActualTypeArguments()[0];
            }
            methodSettingMap = generateGetMethodSettingMap(methodSettingMap, returnType, subTags, dataType);
        }

        return methodSettingMap;
    }

    private Map<String, MethodSetting> generateSetMethodSettingMap(Map<String, MethodSetting> methodSettingMap, Class objectClass, String[] tags, String dataType) {

        if (tags != null || tags.length == 1) {

            String methodName = tags[0];

            StringBuilder stringBuilder = new StringBuilder();
            stringBuilder.append("set").append(methodName.substring(0, 1).toUpperCase()).append(methodName.substring(1, methodName.length()));
            Class[] parameterTypes = new Class[1];
            try {
                java.lang.reflect.Field field = objectClass.getDeclaredField(methodName);
                parameterTypes[0] = field.getType();
            } catch (NoSuchFieldException e) {
                e.printStackTrace();
            }
            Method method = ReflectUtil.getM8DeclaredMethod(objectClass, stringBuilder.toString(), parameterTypes);

            MethodSetting methodSetting = new MethodSetting();
            methodSetting.setMethod(method);

            if (tags.length == 1) {
                methodSetting.setProperties(dataType);
            }

            methodSettingMap.put(objectClass.getSimpleName() + "_" + methodName, methodSetting);

        }
        return methodSettingMap;
    }


    public Map<String, MethodSetting> getMethodSettingMap() {
        return methodSettingMap;
    }

    public void setMethodSettingMap(Map<String, MethodSetting> methodSettingMap) {
        this.methodSettingMap = methodSettingMap;
    }

    public MethodSetting getMethodSetting(Class objectClass, String method) {

        if (methodSettingMap != null) {
            methodSetting = methodSettingMap.get(objectClass.getSimpleName().split("_")[0] + "_" + method);
            if (methodSetting == null && objectClass != Object.class) {
                methodSetting = getMethodSetting(objectClass.getSuperclass(), method);
            }
        }

        return methodSetting;
    }

    public void setMethodSetting(MethodSetting methodSetting) {
        this.methodSetting = methodSetting;
    }

}
