package com.efeiyi.ec.system.master.service.impl;

import com.efeiyi.ec.master.model.Master;
import com.efeiyi.ec.master.model.MasterMessage;
import com.efeiyi.ec.master.model.MasterProject;
import com.efeiyi.ec.master.model.MasterWorkPicture;
import com.efeiyi.ec.product.model.Product;
import com.efeiyi.ec.system.master.service.MasterManager;
import com.efeiyi.ec.system.master.service.MasterWorkManager;
import com.efeiyi.ec.tenant.model.BigTenant;
import com.efeiyi.ec.tenant.model.TenantMaster;
import com.efeiyi.ec.tenant.model.TenantProject;
import com.ming800.core.base.dao.XdoDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: ming
 * Date: 12-8-6
 * Time: 上午11:04
 * To change this template use File | Settings | File Templates.
 */
@Service
public class MasterWorkManagerImpl implements MasterWorkManager {

    @Autowired
    private XdoDao xdoDao;

    @Override
    public void changePictureSort(String sourceId, String sourceSort, String targetId, String targetSort) {
        MasterWorkPicture source = (MasterWorkPicture) xdoDao.getObject(MasterWorkPicture.class.getName(), sourceId);
        MasterWorkPicture target = (MasterWorkPicture) xdoDao.getObject(MasterWorkPicture.class.getName(), targetId);
        source.setSort(Integer.parseInt(targetSort));
        target.setSort(Integer.parseInt(sourceSort));
        xdoDao.saveOrUpdateObject(source);
        xdoDao.saveOrUpdateObject(target);
    }
}
