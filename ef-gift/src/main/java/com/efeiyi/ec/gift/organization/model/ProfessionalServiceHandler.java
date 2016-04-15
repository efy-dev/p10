package com.efeiyi.ec.gift.organization.model;

import com.efeiyi.ec.gift.base.authentication.ContextUtils;
import com.efeiyi.ec.gift.organization.service.ProfessionalManager;
import com.efeiyi.ec.organization.model.Professional;
import com.ming800.core.base.util.ReflectUtil;
import com.ming800.core.does.model.WebServiceHandler;

/**
 * Created by Administrator on 2016/3/23 0023.
 */
public class ProfessionalServiceHandler implements WebServiceHandler {

    @Override
    public void setValue(Object object, String propertyName) {
        try {
            ProfessionalManager professionalManager = (ProfessionalManager) ContextUtils.getBean("professionalServiceProxy");
            Object objTemp = ReflectUtil.invokeGetterMethod(object, propertyName);
            String id = ReflectUtil.invokeGetterMethod(objTemp, "id").toString();
            Professional user = professionalManager.getProfessionalByUserId(id);
            ReflectUtil.invokeSetterMethod(object, propertyName, user, Professional.class);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
