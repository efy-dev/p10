package com.ming800.organization.service;

import com.ming800.organization.model.BigUser;

/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 12-11-16
 * Time: 下午5:14
 * To change this template use File | Settings | File Templates.
 */
public interface RegisterManager {

    void saveOrUpdateBigUser(BigUser bigUser);

    void saveEnrollMessage(BigUser bigUser) throws Exception;

}
