package com.efeiyi.ec.personal.dao.hibernate;


import com.efeiyi.ec.organization.model.BigUser;
import com.efeiyi.ec.organization.model.MyUser;
import com.efeiyi.ec.personal.dao.UserDao;
import com.ming800.core.base.dao.hibernate.BaseDaoSupport;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.stereotype.Repository;

import java.util.LinkedHashMap;

@Repository
public class UserDaoHibernate extends BaseDaoSupport<BigUser> implements UserDao {


    @Override
    public MyUser getUniqueMyUserByConditions(String branchName, String queryHql, LinkedHashMap<String, Object> queryParamMap) {

        Session tempSession = super.getSessionFactory().openSession();

        Query listQuery = tempSession.createQuery(queryHql);
        setQueryParams(listQuery, queryParamMap);
        MyUser myUser = (MyUser) listQuery.uniqueResult();
        tempSession.close();

        return myUser;
    }

}
