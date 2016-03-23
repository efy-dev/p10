package com.efeiyi.ec.website.organization.model;

import com.efeiyi.ec.organization.model.Consumer;
import com.efeiyi.ec.organization.model.User;
import com.efeiyi.ec.website.base.authentication.ContextUtils;
import com.efeiyi.ec.website.organization.service.ConsumerManager;
import com.efeiyi.ec.website.organization.service.UserManager;
import com.ming800.core.base.util.ReflectUtil;
import com.ming800.core.does.model.WebServiceHandler;

/**
 * Created by Administrator on 2016/3/23 0023.
 */
public class ConsumerServiceHandler implements WebServiceHandler {

    @Override
    public void setValue(Object object, String propertyName) {
        try {
            ConsumerManager consumerManager = (ConsumerManager) ContextUtils.getBean("consumerServiceProxy");
            Object objTemp = ReflectUtil.invokeGetterMethod(object, propertyName);
            String id = ReflectUtil.invokeGetterMethod(objTemp, "id").toString();
            Consumer user = consumerManager.getConsumerByUserId(id);
            ReflectUtil.invokeSetterMethod(object, propertyName, user, Consumer.class);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
