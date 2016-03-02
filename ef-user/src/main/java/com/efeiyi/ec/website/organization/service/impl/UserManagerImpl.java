package com.efeiyi.ec.website.organization.service.impl;

import com.efeiyi.ec.organization.model.BigUser;
import com.efeiyi.ec.organization.model.Consumer;
import com.efeiyi.ec.organization.model.ConsumerAddress;
import com.efeiyi.ec.organization.model.MyUser;
import com.efeiyi.ec.website.organization.service.UserManager;
import com.ming800.core.base.service.BaseManager;
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
public class UserManagerImpl implements UserManager ,UserDetailsService {

    @Autowired
    private BaseManager baseManager;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        return null;
    }

    @Override
    public MyUser getUserByUsername(String username) {
        return null;
    }

    @Override
    public MyUser getUserByUserId(String userId) {
        MyUser myUser = (MyUser) baseManager.getObject(MyUser.class.getName(), userId);
        return myUser;
    }

    @Override
    public Consumer getConsumerByUserId(String userId) {
        return null;
    }

    @Override
    public BigUser getBigUserByUserId(String userId) {
        return null;
    }

    @Override
    public List<ConsumerAddress> listConsumerAddressByUserId(String userId) {
        return null;
    }

    @Override
    public void saveOrUpdateConsumer(Consumer consumer) {

    }

    @Override
    public void removeUser(String userId) {

    }

    @Override
    public List<Consumer> listConsumer(XQuery xQuery) {
        return null;
    }

    @Override
    public List<Consumer> listConsumer(String hql, LinkedHashMap<String, Object> param) {
        return null;
    }

    @Override
    public List<Consumer> plistConsumer(String queryHql, PageEntity pageEntity, LinkedHashMap<String, Object> queryParamMap) {
        return null;
    }

    @Override
    public List<Consumer> plistConsumer(XQuery xQuery) {
        return null;
    }

}
