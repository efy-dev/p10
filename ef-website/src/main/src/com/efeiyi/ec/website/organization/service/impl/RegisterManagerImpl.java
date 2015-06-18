package com.efeiyi.ec.website.organization.service.impl;

import com.efeiyi.ec.website.organization.model.BigUser;
import com.efeiyi.ec.website.organization.service.InitializeManager;
import com.efeiyi.ec.website.organization.service.RegisterManager;
import com.ming800.core.base.dao.XdoDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;



/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 12-11-16
 * Time: ����4:43
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

        //ΪʲôҪ������ʼ����
        InitializeManager initializeManager = (InitializeManager) Class.forName("com.ming800.organization.service.impl.InitializeManagerImpl").newInstance();

        try {
            initializeManager.initNewUser(bigUser);        //���ݳ�ʼ��
        } catch (Exception e) {
            throw new Exception("����������Ӧ");
        }

        System.err.println("��ʼ�����");
    }

}
