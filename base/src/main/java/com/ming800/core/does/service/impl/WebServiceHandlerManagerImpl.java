package com.ming800.core.does.service.impl;

import com.ming800.core.does.model.WebServiceHandler;
import com.ming800.core.does.service.ModuleManager;
import com.ming800.core.does.service.WebServiceHandlerManager;
import com.ming800.core.util.ApplicationContextUtil;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Set;

/**
 * Created by Administrator on 2016/3/14 0014.
 */
public class WebServiceHandlerManagerImpl implements WebServiceHandlerManager {

    private static ModuleManager moduleManager = (ModuleManager) ApplicationContextUtil.getApplicationContext().getBean("moduleManagerImpl");

    public static void dealObject(Object object, String handlerConfig) throws Exception {
        if (handlerConfig != null) {
            String[] handlerGroup = handlerConfig.split(":");
            if (handlerGroup.length != 2) {
                throw new Exception();
            } else {
                String propertyName = handlerGroup[0];
                String propertyHandler = handlerGroup[1];
                WebServiceHandler webServiceHandler = (WebServiceHandler) Class.forName(propertyHandler).newInstance();
                webServiceHandler.setValue(object, propertyName);
            }
        }
    }

    public static void dealObject(Object object) throws Exception {
        //先通过 object获取Handler的信息再调用主要方法
        String classSimpleName = object.getClass().getSimpleName();
        LinkedHashMap<String, com.ming800.core.does.model.Field> fieldMap = moduleManager.fetchXentity(classSimpleName).getFieldMap();
        Set<String> keySet = fieldMap.keySet();
        for (String key : keySet) {
            com.ming800.core.does.model.Field field = fieldMap.get(key);
            if (field.getInputType().equals("remoteObject")) {
                String handlerConfig = field.getName() + ":" + field.getSource();
                dealObject(object, handlerConfig);
            }
        }

    }

    public static void dealObject(Object object, List<String> handlerConfigs) throws Exception {
        for (String handlerConfig : handlerConfigs) {
            dealObject(object, handlerConfig);
        }
    }


    //@TODO 需要做缓存处理
    public static void dealList(List<Object> objectList) throws Exception {
        for (Object object : objectList) {
            dealObject(object);
        }
    }

    //@TODO 需要做缓存处理
    public static void dealList(List<Object> objectList, List<String> handlerConfigs) throws Exception {
        if (handlerConfigs != null && !handlerConfigs.isEmpty()) {
            for (Object object : objectList) {
                dealObject(object, handlerConfigs);
            }
        }
    }


}