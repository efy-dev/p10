package com.ming800.organization.service.impl;

import com.ming800.core.base.dao.XdoDao;
import com.ming800.organization.model.BigUser;
import com.ming800.organization.service.InitializeManager;
import com.ming800.organization.service.RegisterManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 12-11-16
 * Time: 下午4:43
 * To change this template use File | Settings | File Templates.
 */
@Service
public class RegisterManagerImpl implements RegisterManager {

    @Autowired
    private XdoDao basicDao;

    @Override
    public void saveOrUpdateBigUser(BigUser bigUser) {
        basicDao.saveOrUpdateObject(BigUser.class.getName(), bigUser);
    }

    @Override
    public void saveEnrollMessage(BigUser bigUser) throws Exception {

        //为什么要这样初始化？
        InitializeManager initializeManager = (InitializeManager) Class.forName("com.ming800.organization.service.impl.InitializeManagerImpl").newInstance();

        try {
            initializeManager.initNewUser(bigUser);        //数据初始化
        } catch (Exception e) {
            throw new Exception("服务器无响应");
        }

        System.err.println("初始化完成");
    }

}
