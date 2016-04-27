package com.efeiyi.ec.gift.organization.model;

import com.efeiyi.ec.gift.base.authentication.ContextUtils;
import com.efeiyi.ec.gift.organization.service.AdminManager;
import com.efeiyi.ec.organization.model.Manager;
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
