package com.efeiyi.ec.website.organization.service.impl;

import com.efeiyi.ec.website.organization.model.User;
import com.efeiyi.ec.website.organization.service.BranchManager;
import com.efeiyi.ec.website.organization.service.SmsCheckManager;
import com.ming800.core.base.dao.XdoDao;
import com.ming800.core.base.service.BaseManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 13-7-2
 * Time: 下午3:14
 * To change this template use File | Settings | File Templates.
 */
@Service
public class SmsCheckManagerImpl implements SmsCheckManager {

    @Autowired
    private XdoDao basicDao;
    @Autowired
    private BranchManager branchManager;

    @Autowired
    private BaseManager baseManager;

    @Override
    public String createCheckCode() {

        return String.valueOf(Math.random()).substring(2, 8);
    }

    private int calLastedTime(Date startDate) {
        long a = new Date().getTime();
        long b = startDate.getTime();
        int c = (int) ((a - b) / 1000);
        return c;
    }


    @Override
    public Boolean checkPhoneRegistered(String phone) {
        String hql = "from User b where b.username=:phone";
        LinkedHashMap<String, Object> queryParamMap = new LinkedHashMap<>();
        queryParamMap.put("phone", phone);
        List<User> bigUserList = basicDao.getObjectList(hql, queryParamMap);
        if (bigUserList.size() < 1) {
            return true;
        } else {
            return false;
        }
    }
}
