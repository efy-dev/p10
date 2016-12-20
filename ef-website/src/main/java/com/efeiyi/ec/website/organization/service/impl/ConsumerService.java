package com.efeiyi.ec.website.organization.service.impl;

import com.efeiyi.ec.exception.NonUniqueConsumerException;
import com.efeiyi.ec.organization.model.Consumer;
import com.efeiyi.ec.organization.model.MyUser;
import com.efeiyi.ec.website.organization.service.IConsumerService;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.util.StringUtil;
import org.hibernate.NonUniqueResultException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by WangTao on 2016/11/2 0002.
 */
@Service
public class ConsumerService implements IConsumerService {

    private final String HQL_GET_CONSUMER_BY_UNIONID = "SELECT consumer FROM Consumer consumer WHERE consumer.status='1' AND consumer.unionid=:unionid";
    private final String HQL_GET_CONSUMER_BY_USERNAME = "SELECT consumer FROM Consumer consumer WHERE consumer.status='1' AND consumer.username=:username";

    @Autowired
    private BaseManager baseManager;

    @Override
    public Consumer getConsumerByUnionid(String unionid) throws NonUniqueConsumerException {
        Consumer consumer;
        LinkedHashMap<String, Object> param = new LinkedHashMap<>();
        param.put("unionid", unionid);
        try {
            consumer = (Consumer) baseManager.getUniqueObjectByConditions(HQL_GET_CONSUMER_BY_UNIONID, param);
        } catch (NonUniqueResultException e) {
            throw new NonUniqueConsumerException(unionid);
        }
        return consumer;

    }

    @Override
    public Consumer getConsumerOrNullByUnionid(String unionid) {
        Consumer consumer = null;
        LinkedHashMap<String, Object> param = new LinkedHashMap<>();
        param.put("unionid", unionid);
        List<Consumer> consumerList = baseManager.listObject(HQL_GET_CONSUMER_BY_UNIONID, param);
        if (!consumerList.isEmpty() && consumerList.size() > 1) {
            for (Consumer ct : consumerList) {
                ct.setStatus("0");
                baseManager.saveOrUpdate(Consumer.class.getName(), ct);
            }
        } else if (consumerList.size() == 1) {
            consumer = consumerList.get(0);
        }
        return consumer;
    }

    @Override
    public Consumer getConsumerById(String id) {
        Consumer consumer;
        try {
            consumer = (Consumer) baseManager.getObject(Consumer.class.getName(), id);
        } catch (Exception e) {
            consumer = null;
        }
        return consumer;
    }

    @Override
    public Consumer getConsumerByUsername(String username) throws NonUniqueConsumerException {
        Consumer consumer;
        LinkedHashMap<String, Object> param = new LinkedHashMap<>();
        param.put("username", username);
        try {
            consumer = (Consumer) baseManager.getUniqueObjectByConditions(HQL_GET_CONSUMER_BY_USERNAME, param);
        } catch (NonUniqueResultException e) {
            throw new NonUniqueConsumerException(username);
        }
        return consumer;
    }

    @Override
    public void saveOrUpdateConsumer(Consumer consumer) {
        baseManager.saveOrUpdate(Consumer.class.getName(), consumer);
    }

    @Override
    public void saveOrUpdateConsumer(String username, String password) {
        Consumer consumer = new Consumer();
        password = StringUtil.encodePassword(password, "sha");
        consumer.setUsername(username);
        consumer.setPassword(password);
        consumer.setCreateDatetime(new Date());
        baseManager.saveOrUpdate(Consumer.class.getName(), consumer);
    }

    @Override
    public Consumer saveOrUpdateConsumer(String nickname, String unionid, String city, String headUrl, int sex) {
        Consumer consumer = new Consumer();
        consumer.setUnionid(unionid);
        consumer.setName(nickname);
        consumer.setUsername(unionid);
        consumer.setPassword(StringUtil.encodePassword(nickname, "sha"));
        consumer.setCreateDatetime(new Date(System.currentTimeMillis()));
        consumer.setBalance(new BigDecimal(0));
        consumer.setCityName(city);
        consumer.setPictureUrl(headUrl);
        consumer.setSex(sex);
        consumer.setStatus("1");
        consumer.setAccountExpired(false);
        consumer.setAccountLocked(false);
        consumer.setCredentialsExpired(false);
        consumer.setEnabled(true);
        baseManager.saveOrUpdate(Consumer.class.getName(), consumer);
        return consumer;
    }


    @Override
    public void removeConsumer(Consumer consumer) {
        if (!consumer.getStatus().endsWith("0")) {
            consumer.setStatus("0");
            saveOrUpdateConsumer(consumer);
        }
    }

    @Override
    public List<Consumer> listConsumerByUsername(String username) {
        LinkedHashMap<String, Object> param = new LinkedHashMap<>();
        param.put("username", username);
        return baseManager.listObject(HQL_GET_CONSUMER_BY_USERNAME, param);
    }

    //@TODO
    @Override
    public List<Consumer> listConsumerByParam(Map<String, Object> param) {
        return null;
    }

    @Override
    public List<Consumer> listConsumerByUnionid(String unionid) {
        LinkedHashMap<String, Object> param = new LinkedHashMap<>();
        param.put("unionid", unionid);
        return baseManager.listObject(HQL_GET_CONSUMER_BY_UNIONID, param);
    }

    @Override
    public MyUser getMyUserOrNullByConsumer(Consumer consumer) {
        MyUser myUser;
        try {
            myUser = (MyUser) baseManager.getObject(MyUser.class.getName(), consumer.getId());
        } catch (Exception e) {
            myUser = null;
        }
        return myUser;
    }
}
