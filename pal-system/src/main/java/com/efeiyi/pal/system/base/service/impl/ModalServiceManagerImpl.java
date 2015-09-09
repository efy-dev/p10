package com.efeiyi.pal.system.base.service.impl;

import com.efeiyi.pal.organization.model.Tenant;
import com.efeiyi.pal.product.model.ProductSeries;
import com.efeiyi.pal.system.base.dao.ModalDao;
import com.efeiyi.pal.system.base.service.ModalServiceManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import java.util.Set;

/**
 * Created by Administrator on 2015/9/8.
 *
 */
@Service
public class ModalServiceManagerImpl implements ModalServiceManager {

    @Autowired
    @Qualifier("modalDaoHibernate")
    private ModalDao modalDao;

    @Override
    public Set<Object> getListLikesName(String name, String type) {
        return modalDao.getListLikesName(name, type);
    }

    @Override
    public Set<Object> getObjectByTenantLikesName(String name, Tenant tenant, String type) {
        return modalDao.getObjectByTenantLikesName(name, tenant, type);
    }

    @Override
    public Set<Object> getTypeFromTenantProductSeriesLikesName(String name, String type) {
        return modalDao.getTypeFromTenantProductSeriesLikesName(name, type);
    }

    @Override
    public Set<Object> getTypeFromTenantProductSeriesByObjectLikesName(String name, String type, String type2, Object object) {
        return modalDao.getTypeFromTenantProductSeriesByObjectLikesName(name, type, type2, object);
    }

}
