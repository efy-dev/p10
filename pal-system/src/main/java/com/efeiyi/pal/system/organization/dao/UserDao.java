package com.efeiyi.pal.system.organization.dao;

import com.efeiyi.pal.organization.model.User;
import com.ming800.core.base.dao.BaseDao;

import java.util.LinkedHashMap;

/**
 * Created by Administrator on 2015/8/10.
 */
public interface UserDao extends BaseDao<User> {

    User getUniqueMyUserByConditions(String branchName, String queryHql, LinkedHashMap<String, Object> queryParamMap);

}
