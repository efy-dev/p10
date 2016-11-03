package com.efeiyi.ec.website.organization.service;

import com.efeiyi.ec.exception.NonUniqueConsumerException;
import com.efeiyi.ec.organization.model.Consumer;
import com.efeiyi.ec.organization.model.MyUser;

import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2016/11/2 0002.
 */
public interface IConsumerService {

    Consumer getConsumerByUnionid(String unionid) throws NonUniqueConsumerException;

    Consumer getConsumerOrNullByUnionid(String unionid);

    Consumer getConsumerById(String id);

    Consumer getConsumerByUsername(String username) throws NonUniqueConsumerException;

    void saveOrUpdateConsumer(Consumer consumer);

    void saveOrUpdateConsumer(String username, String password);

    Consumer saveOrUpdateConsumer(String nickname, String unionid, String city, String headUrl, int sex);

    void removeConsumer(Consumer consumer);

    List<Consumer> listConsumerByUsername(String username);

    List<Consumer> listConsumerByParam(Map<String, Object> param);

    List<Consumer> listConsumerByUnionid(String unionid);

    MyUser getMyUserOrNullByConsumer(Consumer consumer);


}
