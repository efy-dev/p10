package com.efeiyi.association.controller;

import com.efeiyi.ec.association.model.AssMyUser;
import com.efeiyi.ec.tenant.model.Tenant;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.service.DoHandler;
import com.ming800.core.util.ApplicationContextUtil;
import com.ming800.core.util.StringUtil;
import org.springframework.ui.ModelMap;

import javax.servlet.http.HttpServletRequest;

/**
 * Created by Administrator on 2015/7/24.
 */
@Deprecated
public class UserHandler implements DoHandler {

    private BaseManager baseManager = (BaseManager) ApplicationContextUtil.getApplicationContext().getBean("baseManagerImpl");

    @Override
    public ModelMap handle(ModelMap modelMap, HttpServletRequest request) throws Exception {

        AssMyUser assMyUser = new AssMyUser();

        String AssMyUserId = request.getParameter("id");
        String type = "new";
        if (AssMyUserId != null && !AssMyUserId.equals("")) {
            type = "edit";
            assMyUser = (AssMyUser) baseManager.getObject(AssMyUser.class.getName(), AssMyUserId);
        }

        assMyUser = setAssMyUserBaseProperty(assMyUser, request, type);
        assMyUser = getRelationAttributeObject(assMyUser, request);

        modelMap.put("object", assMyUser);
        return modelMap;
    }

    /**
     * 获取关联属性的对象
     * @param assMyUser
     * @param request
     * @return
     */
    private AssMyUser getRelationAttributeObject(AssMyUser assMyUser, HttpServletRequest request){
        String tenantId = request.getParameter("tenant.id");
        Tenant tenant = (Tenant) baseManager.getObject(Tenant.class.getName(), tenantId);
        assMyUser.setTenant(tenant);
        return assMyUser;
    }

    /**
     * 获取AssMyUser的Form表单基本数据
     * @param assMyUser
     * @param request
     * @return
     */
    private AssMyUser setAssMyUserBaseProperty(AssMyUser assMyUser, HttpServletRequest request, String type) {
        String name = request.getParameter("name");
        String status = request.getParameter("status");
        String pwd = request.getParameter("password");
        String password = StringUtil.encodePassword(pwd, "SHA1");
        assMyUser.setName(name);
        assMyUser.setPassword(password);
        assMyUser.setStatus(status);

        if (type.equals("new")){
            assMyUser.setEnabled(true);
            assMyUser.setAccountExpired(false);
            assMyUser.setAccountLocked(false);
            assMyUser.setCredentialsExpired(false);
        }

        return assMyUser;
    }

}