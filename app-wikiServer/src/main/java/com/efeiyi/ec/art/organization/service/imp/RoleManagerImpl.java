package com.efeiyi.ec.art.organization.service.imp;

import com.efeiyi.ec.organization.model.Role;
import com.efeiyi.ec.art.organization.service.RoleManager;
import com.efeiyi.ec.art.organization.util.AuthorizationUtil;
import com.ming800.core.base.dao.XdoDao;
import com.ming800.core.does.model.ConfigProperty;
import com.ming800.core.does.model.Module;
import com.ming800.core.does.service.ModuleManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;

/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 12-11-16
 * Time: 下午4:58
 * To change this template use File | Settings | File Templates.
 */
@Service
public class RoleManagerImpl implements RoleManager {
    @Autowired
    private XdoDao xdoDao;
    @Autowired
    private ModuleManager moduleManager;

    @Override
    public boolean processSetting(String name) {


        if (name == null || name.equals("")) {
            return true;
        }
        Map<String, String> settingMap = AuthorizationUtil.getMyUser().getSettingMap();
        for (String s : name.split(";")) {
            String key = s.split(":")[0];
            String value = s.split(":")[1];


            if (value.startsWith("*")) {  //星号开头的值 配置了反而不显示
                if ((settingMap.containsKey(key) && settingMap.get(key).equals(value.substring(1, value.length()))) || (!settingMap.containsKey(key) && getDefaultValueByName(key).equals(value))) {
                    return false;
                } else {
                    return true;
                }
            } else {
                if ((settingMap.containsKey(key) && settingMap.get(key).equals(value)) || (!settingMap.containsKey(key) && getDefaultValueByName(key).equals(value))) {
                    return true;
                } else {
                    return false;
                }
            }
        }
        return false;
    }


    private String getDefaultValueByName(String keyName) {
        Map<String, Module> moduleMap = moduleManager.fetchModuleMap();

        Iterator iterator = moduleMap.keySet().iterator();
        while (iterator.hasNext()) {
            String key = (String) iterator.next();

            Module tempModule = moduleMap.get(key);

            for (ConfigProperty configProperty : tempModule.getConfigPropertyList()) {

                if (configProperty.getName().equals(keyName)) {
                    return configProperty.getDefaultValue();
                }

            }

        }

        return "";
    }

    @Override
    public Role getRole(String basicType) {
        String hql = "select s from com.ming800.organization.model.Role s where s.basicType=:basicType and s.theStatus=1";
        LinkedHashMap<String, Object> linkedHashMap = new LinkedHashMap<>();
        linkedHashMap.put("basicType", basicType);
        List<Role> roleList = new ArrayList<>();
        roleList = xdoDao.getObjectList(hql, linkedHashMap);
        if (roleList != null && roleList.size() > 0) {
            return roleList.get(0);
        }
        return null;

    }
}
