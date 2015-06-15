package com.ming800.organization.dao;

import com.ming800.core.base.dao.BaseDao;
import com.ming800.organization.model.BigUser;
import com.ming800.organization.model.MyUser;

import java.util.LinkedHashMap;

/**
 * Created by IntelliJ IDEA.
 * User: ming
 * Date: 12-10-16
 * Time: 下午4:18
 * To change this template use File | Settings | File Templates.
 */
public interface UserDao extends BaseDao<BigUser> {


    public MyUser getUniqueMyUserByConditions(String branchName, String queryHql, LinkedHashMap<String, Object> queryParamMap);

}
