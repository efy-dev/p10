package com.efeiyi.ec.website.organization.service.impl;

import com.efeiyi.ec.organization.model.*;
import com.efeiyi.ec.website.organization.service.UserManager;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.PageInfo;
import com.ming800.core.does.model.XQuery;
import com.ming800.core.taglib.PageEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import java.util.LinkedHashMap;
import java.util.List;

/**
 * Created by Administrator on 2016/2/29 0029.
 */
public class UserManagerImpl implements UserManager, UserDetailsService {

    @Autowired
    private BaseManager baseManager;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        return null;
    }


    @Override
    public User getUserByUserId(String userId) {
        User myUser = (User) baseManager.getObject(User.class.getName(), userId);
        return myUser;
    }


    @Override
    public MyUser queryMyUser(String hql, LinkedHashMap<String, Object> param) {
        Object object = baseManager.getUniqueObjectByConditions(hql, param);
        return (MyUser) object;
    }

    @Override
    public MyUser getMyUserByUserId(String userId) {
        return (MyUser) baseManager.getObject(MyUser.class.getName(), userId);
    }

    @Override
    public Consumer getConsumerByUserId(String userId) {
        return (Consumer) baseManager.getObject(Consumer.class.getName(), userId);
    }

    @Override
    public BigUser getBigUserByUserId(String userId) {
        return (BigUser) baseManager.getObject(BigUser.class.getName(), userId);
    }


    @Override
    public void saveOrUpdateConsumer(Consumer consumer) {
        baseManager.saveOrUpdate(Consumer.class.getName(), consumer);
    }

    @Override
    public void removeUser(String userId) {
        baseManager.remove(User.class.getName(), userId);
    }

    @Override
    public List<Consumer> listConsumer(XQuery xQuery) {
        return baseManager.listObject(xQuery);
    }

    @Override
    public List<Consumer> listConsumer(String hql, LinkedHashMap<String, Object> param) {
        return baseManager.listObject(hql, param);
    }

    @Override
    public PageInfo plistConsumer(String queryHql, PageEntity pageEntity, LinkedHashMap<String, Object> queryParamMap) {
        return baseManager.listPageInfo(queryHql, pageEntity, queryParamMap);
    }

    @Override
    public PageInfo plistConsumer(XQuery xQuery) {
        return baseManager.listPageInfo(xQuery);
    }

}
