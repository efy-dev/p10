package com.efeiyi.ec.gift.organization.model;

import com.efeiyi.ec.gift.base.authentication.ContextUtils;
import com.efeiyi.ec.gift.organization.service.UserManager;
import com.efeiyi.ec.organization.model.User;
import com.ming800.core.base.util.ReflectUtil;
import com.ming800.core.does.model.WebServiceHandler;

/**
 * Created by Administrator on 2016/3/18 0018.
 */
public class UserServiceHandler implements WebServiceHandler {

    @Override
    public void setValue(Object object, String propertyName) {
        try {
            UserManager userManager = (UserManager) ContextUtils.getBean("userServiceProxy");
            Object objTemp = ReflectUtil.invokeGetterMethod(object, propertyName);
            String id = ReflectUtil.invokeGetterMethod(objTemp, "id").toString();
            User user = userManager.getUserByUserId(id);
            ReflectUtil.invokeSetterMethod(object, propertyName, user, User.class);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
