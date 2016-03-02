package com.efeiyi.ec.website.organization.service.impl;

import com.efeiyi.ec.organization.model.Consumer;
import com.efeiyi.ec.organization.model.ConsumerAddress;
import com.efeiyi.ec.website.organization.service.AddressManager;
import com.ming800.core.base.service.BaseManager;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.LinkedHashMap;
import java.util.List;

/**
 * Created by Administrator on 2016/3/1 0001.
 */
public class AddressManagerImpl implements AddressManager {

    @Autowired
    private BaseManager baseManager;

    @Override
    public List<ConsumerAddress> listConsumerAddressByUserId(String userId) {
        String hql = "select obj from ConsumerAddress obj where obj.consumer.id=:userid";
        LinkedHashMap<String, Object> param = new LinkedHashMap<>();
        param.put("userid", userId);
        List<ConsumerAddress> consumerAddressList = baseManager.listObject(hql, param);
        return consumerAddressList;
    }
}
