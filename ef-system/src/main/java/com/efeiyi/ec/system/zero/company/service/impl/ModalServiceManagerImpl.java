package com.efeiyi.ec.system.zero.company.service.impl;

import com.efeiyi.ec.system.zero.company.dao.ModalDao;
import com.efeiyi.ec.system.zero.company.service.ModalServiceManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import java.util.List;
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
    public Set<Object> getListLikesName(String name, String type, String status) throws Exception {
        return modalDao.getListLikesName(name, type, status);
    }

    @Override
    public Set<Object> getListLikesProductName(String name, String type, String status) throws Exception {
        return modalDao.getListLikesProductName(name, type, status);
    }

    @Override
    public List getListProductModel() throws Exception {
        return modalDao.getListProductModel();
    }

}
