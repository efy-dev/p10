package com.efeiyi.ec.website.organization.service;

import com.efeiyi.ec.organization.model.*;
import com.ming800.core.does.model.PageInfo;
import com.ming800.core.does.model.XQuery;
import com.ming800.core.taglib.PageEntity;

import java.util.LinkedHashMap;
import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: ming
 * Date: 12-10-15
 * Time: 下午5:01
 * To change this template use File | Settings | File Templates.
 */
public interface UserManager {


    User getUserByUsername(String username);

    MyUser getMyUserByUsername(String username);

    List<ConsumerAddress> listConsumerAddressByUserId(String userId);

    void saveOrUpdateConsumer(BigUser bigUser);

    void saveOrUpdateMyUser(MyUser myUser);

    User getUserByUserId(String userId);

    MyUser queryMyUser(String hql, LinkedHashMap<String, Object> param);

    MyUser getMyUserByUserId(String userId);

    Consumer getConsumerByUserId(String userId);

    BigUser getBigUserByUserId(String userId);

    void saveOrUpdateConsumer(Consumer consumer);

    void removeUser(String userId);

    List<Consumer> listConsumer(XQuery xQuery); //需要服务端客户端有相同的配置

    List<Consumer> listConsumer(String hql, LinkedHashMap<String, Object> param);

    PageInfo plistConsumer(String queryHql, PageEntity pageEntity, LinkedHashMap<String, Object> queryParamMap);

    PageInfo plistConsumer(XQuery xQuery);

}
