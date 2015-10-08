package com.efeiyi.association.service.impl;

import com.efeiyi.association.dao.ProtectionDao;
import com.efeiyi.association.service.ProtectionServiceManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

/**
 * Created by Administrator on 2015/10/8.
 * 申报查询 Service Impl
 */

@Service
public class ProtectionServiceManagerImpl implements ProtectionServiceManager {

    @Autowired
    @Qualifier("protectionDaoHibernate")
    private ProtectionDao protectionDao;

    @Override
    public Object CheckDeclareState(String name, String sub_group) {
        return protectionDao.CheckDeclareState(name, sub_group);
    }

}
