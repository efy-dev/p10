package com.efeiyi.ec.website.organization.service;

import com.efeiyi.ec.organization.model.ConsumerAddress;

import java.util.List;

/**
 * Created by Administrator on 2016/3/1 0001.
 */
public interface AddressManager {

    List<ConsumerAddress> listConsumerAddressByUserId(String userId);

}
