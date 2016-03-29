package com.ming800.core.does.service.impl;

import com.ming800.core.base.util.ReflectUtil;
import com.ming800.core.does.model.WebServiceHandler;
import com.ming800.core.does.service.ModuleManager;
import com.ming800.core.does.service.WebServiceHandlerManager;
import com.ming800.core.util.ApplicationContextUtil;
import org.apache.solr.common.util.Hash;

import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Set;

/**
 * Created by Administrator on 2016/3/14 0014.
 */
public class WebServiceHandlerManagerImpl implements WebServiceHandlerManager {

    private static ModuleManager moduleManager = (ModuleManager) ApplicationContextUtil.getApplicationContext().getBean("moduleManagerImpl");

    public static void dealObject(Object object, String handlerConfig) throws Exception {
        ObjectProcessor objectProcessor = new ObjectProcessor();
        objectProcessor.dealNoCatch(object, handlerConfig);
    }


    public static void dealObject(Object object) throws Exception {
        ObjectProcessor objectProcessor = new ObjectProcessor();
        objectProcessor.dealNoCatch(object);
    }

    public static void dealObject(Object object, List<String> handlerConfigs) throws Exception {
        ObjectProcessor objectProcessor = new ObjectProcessor();
        objectProcessor.dealNoCatch(object, handlerConfigs);
    }


    //@TODO 需要做缓存处理
    public static void dealList(List<Object> objectList) throws Exception {
        ObjectProcessor objectProcessor = new ObjectProcessor();
        for (Object object : objectList) {
            objectProcessor.deal(object);
        }
    }

    //@TODO 需要做缓存处理
    public static void dealList(List<Object> objectList, List<String> handlerConfigs) throws Exception {
        ObjectProcessor objectProcessor = new ObjectProcessor();
        if (handlerConfigs != null && !handlerConfigs.isEmpty()) {
            for (Object object : objectList) {
                objectProcessor.deal(object, handlerConfigs);
            }
        }
    }


    private static class ObjectProcessor {

        private RemoteObjectCatch remoteObjectCatch;

        public ObjectProcessor() {
            remoteObjectCatch = new RemoteObjectCatch();
        }

        public void deal(Object object, String handlerConfig) throws Exception {
            if (handlerConfig != null) {
                String[] handlerGroup = handlerConfig.split(":");
                if (handlerGroup.length != 2) {
                    throw new Exception();
                } else {
                    String propertyName = handlerGroup[0];
                    String propertyHandler = handlerGroup[1];
                    if (!remoteObjectCatch.setValueFromCatch(object, propertyName)) {
                        WebServiceHandler webServiceHandler = (WebServiceHandler) Class.forName(propertyHandler).newInstance();
                        webServiceHandler.setValue(object, propertyName);
                        remoteObjectCatch.setCatch(object, propertyName);
                    }
                }
            }
        }

        public void dealNoCatch(Object object, String handlerConfig) throws Exception {
            if (handlerConfig != null) {
                String[] handlerGroup = handlerConfig.split(":");
                if (handlerGroup.length != 2) {
                    throw new Exception("配置文件错误 : source = propertyName:webServiceHandler");
                } else {
                    String propertyName = handlerGroup[0];
                    String propertyHandler = handlerGroup[1];
                    WebServiceHandler webServiceHandler = (WebServiceHandler) Class.forName(propertyHandler).newInstance();
                    webServiceHandler.setValue(object, propertyName);
                }
            }
        }


        public void deal(Object object) throws Exception {
            String classSimpleName = object.getClass().getSimpleName();
            if (moduleManager.fetchXentity(classSimpleName) != null) {
                LinkedHashMap<String, com.ming800.core.does.model.Field> fieldMap = moduleManager.fetchXentity(classSimpleName).getFieldMap();
                Set<String> keySet = fieldMap.keySet();
                for (String key : keySet) {
                    com.ming800.core.does.model.Field field = fieldMap.get(key);
                    if (field.getInputType().equals("remoteObject")) {
                        String handlerConfig = field.getName() + ":" + field.getSource();
                        deal(object, handlerConfig);
                    }
                }
            }
        }

        public void dealNoCatch(Object object) throws Exception {
            String classSimpleName = object.getClass().getSimpleName();
            if (moduleManager.fetchXentity(classSimpleName) != null) {
                LinkedHashMap<String, com.ming800.core.does.model.Field> fieldMap = moduleManager.fetchXentity(classSimpleName).getFieldMap();
                Set<String> keySet = fieldMap.keySet();
                for (String key : keySet) {
                    com.ming800.core.does.model.Field field = fieldMap.get(key);
                    if (field.getInputType().equals("remoteObject")) {
                        String handlerConfig = field.getName() + ":" + field.getSource();
                        dealNoCatch(object, handlerConfig);
                    }
                }
            }
        }


        public void deal(Object object, List<String> handlerConfigs) throws Exception {
            for (String handlerConfig : handlerConfigs) {
                deal(object, handlerConfig);
            }
        }

        public void dealNoCatch(Object object, List<String> handlerConfigs) throws Exception {
            for (String handlerConfig : handlerConfigs) {
                dealNoCatch(object, handlerConfig);
            }
        }


    }


    private static class RemoteObjectCatch {

        private HashMap<String, Object> remoteObjectStore;

        public RemoteObjectCatch() {
            remoteObjectStore = new HashMap<>();
        }

        //将数据存储到缓存当中
        public void setCatch(Object object, String propertyName) {
            try {
                Object remoteObject = ReflectUtil.invokeGetterMethod(object, propertyName);
                String remoteObjectId = ReflectUtil.invokeGetterMethod(remoteObject, "id").toString();
                remoteObjectStore.put(remoteObjectId, remoteObject);
            } catch (Exception e) {
                e.printStackTrace();
            }

        }

        //从缓存当中得到制定的object对象的的值，然后setValue 返回true 如果缓存当中没有相应的数据，就返回false
        public boolean setValueFromCatch(Object object, String propertyName) {
            try {
                Object remoteObjectTemp = ReflectUtil.invokeGetterMethod(object, propertyName);
                String remoteObjectId = ReflectUtil.invokeGetterMethod(remoteObjectTemp, "id").toString();
                Object remoteObject = remoteObjectStore.get(remoteObjectId);
                if (remoteObject != null) {
                    Class remoteObjectClass = remoteObject.getClass();
                    ReflectUtil.invokeSetterMethod(object, propertyName, remoteObject, remoteObjectClass);
                    return true;
                } else {
                    return false;
                }
            } catch (Exception e) {
                e.printStackTrace();
                return false;
            }
        }

    }


}