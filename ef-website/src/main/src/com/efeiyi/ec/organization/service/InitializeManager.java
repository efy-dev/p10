package com.efeiyi.ec.organization.service;


import com.efeiyi.ec.organization.model.BigUser;

/**
 * Created with IntelliJ IDEA.
 * User: ming
 * Date: 13-1-28
 * Time: 下午4:54
 * To change this template use File | Settings | File Templates.
 */
public interface InitializeManager {
    public void init(BigUser bigUser) throws Exception;

    public void initNewUser(BigUser bigUser) throws Exception;
}
