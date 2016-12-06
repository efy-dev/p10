package com.efeiyi.ec.website.organization.service.impl;

import com.efeiyi.ec.organization.model.ConsumerAddress;
import com.efeiyi.ec.website.organization.service.AddressManager;
import com.ming800.core.base.service.BaseManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.LinkedHashMap;
import java.util.List;

/**
 * Created by Administrator on 2016/12/5.
 */
@Service
public class AddressManagerImpl implements AddressManager {
    private String ADDRESS_LIST = "select s from com.efeiyi.ec.organization.model.ConsumerAddress s where s.consumer.id = :userId and s.status <> 0";

    @Autowired
    BaseManager baseManager;

    @Override
    public List<ConsumerAddress> getConsumerAddressList(String userId) throws Exception {
        LinkedHashMap<String, Object> params = new LinkedHashMap<>();
        params.put("userId", userId);

        List<ConsumerAddress> consumerAddressList = baseManager.listObject(ADDRESS_LIST, params);

        return consumerAddressList;
    }

    @Override
    public void saveConsumerAddress(ConsumerAddress consumerAddress) throws Exception {
        baseManager.saveOrUpdate(ConsumerAddress.class.getName(), consumerAddress);
    }

}
