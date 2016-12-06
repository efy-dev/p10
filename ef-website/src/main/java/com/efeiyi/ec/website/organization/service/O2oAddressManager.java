package com.efeiyi.ec.website.organization.service;

import com.efeiyi.ec.organization.model.ConsumerAddress;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * Created by Administrator on 2016/12/5.
 */
public interface O2oAddressManager {
    List<ConsumerAddress> getConsumerAddressList(String userId) throws Exception;

    void saveConsumerAddress(ConsumerAddress consumerAddress) throws Exception;
}
