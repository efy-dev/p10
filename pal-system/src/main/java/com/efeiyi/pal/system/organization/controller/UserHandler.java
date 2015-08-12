package com.efeiyi.pal.system.organization.controller;

import com.efeiyi.pal.organization.model.Tenant;
import com.efeiyi.pal.organization.model.User;
import com.ming800.core.base.dao.XdoDao;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.base.service.XdoManager;
import com.ming800.core.base.util.XDoUtil;
import com.ming800.core.does.model.Do;
import com.ming800.core.does.service.DoHandler;
import com.ming800.core.util.ApplicationContextUtil;
import com.ming800.core.util.StringUtil;
import org.springframework.ui.ModelMap;

import javax.servlet.http.HttpServletRequest;

/**
 * Created by Administrator on 2015/7/24.
 */

public class UserHandler implements DoHandler {

    private BaseManager baseManager = (BaseManager) ApplicationContextUtil.getApplicationContext().getBean("baseManagerImpl");
    private XdoManager xdoManager = (XdoManager) ApplicationContextUtil.getApplicationContext().getBean("xdoManagerImpl");
    private XdoDao xdoDao = (XdoDao) ApplicationContextUtil.getApplicationContext().getBean("xdoDaoSupport");

    @Override
    public ModelMap handle(ModelMap modelMap, HttpServletRequest request) throws Exception {

        User user = new User();

        String userId = request.getParameter("id");
        String type = "new";
        if (userId != null && !userId.equals("")) {
            type = "edit";
            user = (User) baseManager.getObject(User.class.getName(), userId);
        }
//        Do tempDo = (Do) modelMap.get("tempDo");
//        user = (User) XDoUtil.processSaveOrUpdateTempObject(tempDo, user, user.getClass(), request, type, xdoDao);

        user = setUserBaseProperty(user, request, type);
        user = getRelationAttributeObject(user, request);

        modelMap.put("object", user);
        return modelMap;
    }

    /**
     * 获取关联属性的对象
     * @param user
     * @param request
     * @return
     */
    private User getRelationAttributeObject(User user, HttpServletRequest request){
        String tenantId = request.getParameter("tenant.id");
        Tenant tenant = (Tenant) baseManager.getObject(Tenant.class.getName(), tenantId);
        user.setTenant(tenant);
        return user;
    }

    /**
     * 获取user的Form表单基本数据
     * @param user
     * @param request
     * @return
     */
    private User setUserBaseProperty(User user, HttpServletRequest request, String type) {
        String name = request.getParameter("name");
        String status = request.getParameter("status");
        String pwd = request.getParameter("password");
        String password = StringUtil.encodePassword(pwd, "SHA1");
        user.setName(name);
        user.setPassword(password);
        user.setStatus(status);

        if (type.equals("new")){
            user.setEnabled(true);
            user.setAccountExpired(false);
            user.setAccountLocked(false);
            user.setCredentialsExpired(false);
        }

        return user;
    }

}