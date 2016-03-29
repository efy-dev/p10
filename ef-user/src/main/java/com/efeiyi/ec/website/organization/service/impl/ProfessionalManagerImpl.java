package com.efeiyi.ec.website.organization.service.impl;

import com.efeiyi.ec.organization.model.Professional;
import com.efeiyi.ec.website.organization.service.ProfessionalManager;
import com.ming800.core.base.service.BaseManager;
import org.springframework.beans.factory.annotation.Autowired;

/**
 * Created by Administrator on 2016/3/23 0023.
 */
public class ProfessionalManagerImpl implements ProfessionalManager {

    @Autowired
    private BaseManager baseManager;

    @Override
    public Professional getProfessionalByUserId(String id) {
        Professional professional = (Professional) baseManager.getObject(Professional.class.getName(), id);
        return professional;
    }
}
