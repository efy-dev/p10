package com.efeiyi.ec.website.organization.service.impl;

import com.efeiyi.ec.organization.model.Manager;
import com.efeiyi.ec.website.organization.service.AdminManager;
import com.ming800.core.base.service.BaseManager;
import org.springframework.beans.factory.annotation.Autowired;

/**
 * Created by Administrator on 2016/3/23 0023.
 */

public class AdminManagerImpl implements AdminManager {

    @Autowired
    private BaseManager baseManager;

    @Override
    public Manager getManagerByUserId(String id) {
        Manager manager = (Manager) baseManager.getObject(Manager.class.getName(), id);
        return manager;
    }
}
