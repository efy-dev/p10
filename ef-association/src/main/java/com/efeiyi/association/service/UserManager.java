package com.efeiyi.association.service;

import com.efeiyi.ec.organization.model.BigUser;
import com.ming800.core.does.model.PageInfo;
import com.ming800.core.taglib.PageEntity;

import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: ming
 * Date: 12-10-15
 * Time: 下午5:01
 * To change this template use File | Settings | File Templates.
 */
public interface UserManager {

     List<BigUser> listBigUser(String teachAreaId);

     void saveOrUpdateBigUser(BigUser bigUser);

     PageInfo pageBigUser(String teachAreaId, PageEntity pageEntity);
}
