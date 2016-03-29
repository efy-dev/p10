package com.efeiyi.ec.website.organization.model;

import com.efeiyi.ec.organization.model.Manager;
import com.efeiyi.ec.organization.model.Professional;
import com.efeiyi.ec.organization.model.User;
import com.efeiyi.ec.website.base.authentication.ContextUtils;
import com.efeiyi.ec.website.organization.service.AdminManager;
import com.efeiyi.ec.website.organization.service.ProfessionalManager;
import com.ming800.core.base.util.ReflectUtil;
import com.ming800.core.does.model.WebServiceHandler;

/**
 * Created by Administrator on 2016/3/23 0023.
 */
public class ManagerServiceHandler implements WebServiceHandler {


    @Override
    public void setValue(Object object, String propertyName) {
        try {
            AdminManager adminManager = (AdminManager) ContextUtils.getBean("managerServiceProxy");
            Object objTemp = ReflectUtil.invokeGetterMethod(object, propertyName);
            String id = ReflectUtil.invokeGetterMethod(objTemp, "id").toString();
            Manager user = adminManager.getManagerByUserId(id);
            ReflectUtil.invokeSetterMethod(object, propertyName, user, Manager.class);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
