package com.efeiyi.ec.website.organization.service.impl;

import com.efeiyi.ec.organization.model.Consumer;
import com.efeiyi.ec.website.organization.service.ConsumerManager;
import com.ming800.core.base.service.BaseManager;
import org.springframework.beans.factory.annotation.Autowired;

/**
 * Created by Administrator on 2016/3/23 0023.
 */
public class ConsumerManagerImpl implements ConsumerManager {

    @Autowired
    private BaseManager baseManager;

    @Override
    public Consumer getConsumerByUserId(String id) {
        Consumer consumer = (Consumer) baseManager.getObject(Consumer.class.getName(), id);
        return consumer;
    }
}
