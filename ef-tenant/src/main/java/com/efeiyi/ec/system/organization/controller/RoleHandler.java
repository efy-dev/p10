package com.efeiyi.ec.system.organization.controller;

import com.efeiyi.ec.organization.model.Permission;
import com.efeiyi.ec.organization.model.Role;
import com.ming800.core.base.dao.XdoDao;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.base.service.XdoManager;
import com.ming800.core.base.util.XDoUtil;
import com.ming800.core.does.model.Do;
import com.ming800.core.does.service.DoHandler;
import com.ming800.core.util.ApplicationContextUtil;
import org.springframework.ui.ModelMap;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: ming
 * Date: 12-10-30
 * Time: 上午10:30
 * To change this template use File | Settings | File Templates.
 */

public class RoleHandler implements DoHandler {

    private BaseManager baseManager = (BaseManager) ApplicationContextUtil.getApplicationContext().getBean("baseManagerImpl");
    private XdoManager xdoManager = (XdoManager) ApplicationContextUtil.getApplicationContext().getBean("xdoManagerImpl");
    private XdoDao xdoDao = (XdoDao) ApplicationContextUtil.getApplicationContext().getBean("xdoDaoSupport");

    @Override
    public ModelMap handle(ModelMap modelMap, HttpServletRequest request) throws Exception {


        Role role = new Role();
        String type = "new";

        String id = request.getParameter("id");
        if (id != null && !id.equals("")) {
            type = "edit";
            role = (Role) baseManager.getObject(Role.class.getName(), id);
            if (role.getPermissionsList() != null && role.getPermissionsList().size() > 0) {
                String[] deletePermissionIdArray = new String[role.getPermissionsList().size()];
                for (int i = 0; i < role.getPermissionsList().size(); i++) {
                    deletePermissionIdArray[i] = role.getPermissionsList().get(i).getId();
                }
                baseManager.batchDelete(Permission.class.getName(), deletePermissionIdArray);
            }
        }
        Do tempDo = (Do) modelMap.get("tempDo");
        role = (Role) XDoUtil.processSaveOrUpdateTempObject(tempDo, role, role.getClass(), request, type,xdoDao);

        //建立新的权限
        List<Permission> permissionList = new ArrayList<>();
        String[] entityNames = request.getParameterValues("entityName");
        String[] entityLabels = request.getParameterValues("entityLabel");
        for (int i = 0; i < entityNames.length; i++) {
            Permission permission = new Permission();
            permission.setRole(role);
            String entityName = entityNames[i];
            permission.setEntityName(entityName);
            permission.setEntityLabel(entityLabels[i]);
            if (request.getParameter(entityName + "_all") != null) {
                permission.setAll(true);
                permission.setBasic("all");
                permissionList.add(permission);
            } else {
                permission.setAll(false);
                String[] basicArray = request.getParameterValues(entityName + "_basic");
                if (basicArray != null) {
                    StringBuilder basicBuilder = new StringBuilder();
                    for (String basic : basicArray) {
                        basicBuilder.append(basic).append(",");
                    }
                    basicBuilder.deleteCharAt(basicBuilder.length() - 1);
                    permission.setBasic(basicBuilder.toString());
                }
                String[] othersArray = request.getParameterValues(entityName + "_others");
                if (othersArray != null) {
                    StringBuilder othersBuilder = new StringBuilder();
                    for (String others : othersArray) {
                        othersBuilder.append(others).append(",");
                    }
                    othersBuilder.deleteCharAt((othersBuilder.length() - 1));
                    permission.setOthers(othersBuilder.toString());
                }
                if (basicArray != null || othersArray != null) {
                    permissionList.add(permission);
                }
            }
        }
        role.setPermissionsList(permissionList);
        modelMap.put("object", role);
        return modelMap;  //To change body of implemented methods use File | Settings | File Templates.
    }
}
