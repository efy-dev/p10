/*
package com.ming800.core.p.controller;

import com.ming800.core.does.model.Do;
import com.ming800.core.does.service.DoHandler;
import com.ming800.core.does.service.impl.DoManagerImpl;
import com.ming800.core.does.model.Xentity;
import com.ming800.core.util.ApplicationContextUtil;
import com.ming800.core.util.AuthorizationUtil;
import com.ming800.core.util.ComparatorDo;
import com.ming800.organization.OrganizationConst;
import com.ming800.organization.model.Role;
import com.ming800.organization.service.PermissionManager;
import org.springframework.ui.ModelMap;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

*/
/**
 * Created by IntelliJ IDEA.
 * User: ming
 * Date: 12-10-30
 * Time: 上午10:30
 * To change this template use File | Settings | File Templates.
 *//*


public class RoleDefinedPortletHandler implements DoHandler {

    private PermissionManager permissionManager = (PermissionManager)ApplicationContextUtil.getApplicationContext().getBean("permissionManagerImpl");

    @Override
    public ModelMap handle(ModelMap modelMap, HttpServletRequest request) throws Exception {

        List<Do> doList = new ArrayList<>();
//        Role role = AuthorizationUtil.getMyUser().getRole();
        String role = AuthorizationUtil.getMyUser().getRole().getBasicType();
        for(Do queryModelDo: DoManagerImpl.getQueryModelMap().values()){
            if(queryModelDo.getType().equals("portlet")){
                if (role.equals("system")) {//role.getSuperPermission().intValue() == OrganizationConst.ROLE_SUPER_PERMISSION_TRUE
                    doList.add(queryModelDo);
                }else{
                    Xentity xentity = queryModelDo.getXentity();
                    if ((xentity.getBasic() == null || xentity.getBasic().equals("")) && (xentity.getOthers() == null || xentity.getOthers().equals(""))) {
                        doList.add(queryModelDo);
                    }else{
                        String queryModelDoName = queryModelDo.getName();
                        String url = "/basic/xm.do?qm=" + queryModelDoName + "_default";
                        String entityName = xentity.getName();
                        String tempOperations = permissionManager.convertUrlToOperation(url);
                        if (permissionManager.processAccess(entityName + ":" + tempOperations, null)) {
                            doList.add(queryModelDo);
                        }
                    }
                }
            }
        }
        ComparatorDo comparatorDo = new ComparatorDo();
        Collections.sort(doList, comparatorDo);
        modelMap.put("doList", doList);

        return modelMap;  //To change body of implemented methods use File | Settings | File Templates.
    }
}
*/
