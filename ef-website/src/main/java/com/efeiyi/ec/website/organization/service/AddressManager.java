package com.efeiyi.ec.website.organization.service;

import com.efeiyi.ec.organization.model.ConsumerAddress;
import com.efeiyi.ec.website.base.util.ApplicationException;

import java.util.List;

/**
 * Created by Administrator on 2016/12/5.
 */
public interface AddressManager {

    List<ConsumerAddress> getConsumerAddressList(String userId) throws Exception;

    void saveConsumerAddress(ConsumerAddress consumerAddress) throws Exception;

    ConsumerAddress getConsumerAddressById(String id) throws ApplicationException;
}
