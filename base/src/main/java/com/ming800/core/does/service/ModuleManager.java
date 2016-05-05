package com.ming800.core.does.service;

import com.ming800.core.does.model.Module;
import com.ming800.core.does.model.StatusType;
import com.ming800.core.does.model.StatusTypeItem;
import com.ming800.core.does.model.Xentity;

import java.util.List;
import java.util.Map;

/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 13-4-20
 * Time: 下午4:18
 * To change this template use File | Settings | File Templates.
 */
public interface ModuleManager {


    Map<String, Module> fetchModuleMap();

    Map<String, Xentity> fetchXentityMap();

    Module fetchModule(String moduleName);

    Xentity fetchXentity(String xentityName);

    String convertStatusTypeLabel(String key, String propertyValue);

    StatusType fetchStatusType(String key);

    List<StatusTypeItem> listStatusTypeItem(String key);

    List<StatusType> listStatusType(String key);

}
