package com.ming800.organization.dao.hibernate;


import com.ming800.core.base.dao.hibernate.BaseDaoSupport;
import com.ming800.core.base.model.SpObserver;
import com.ming800.organization.dao.UserDao;
import com.ming800.organization.model.BigUser;
import com.ming800.organization.model.MyUser;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.stereotype.Repository;

import java.util.LinkedHashMap;

@Repository
public class UserDaoHibernate extends BaseDaoSupport<BigUser> implements UserDao {


    @Override
    public MyUser getUniqueMyUserByConditions(String branchName, String queryHql, LinkedHashMap<String, Object> queryParamMap) {

        /*if (branchName.contains("_")) {
            SpObserver.putSp(branchName.split("_")[0]);
        } else {
            SpObserver.putSp("dataSource");
        }*/

        Session tempSession = super.getSessionFactory().openSession();

        Query listQuery = tempSession.createQuery(queryHql);
        setQueryParams(listQuery, queryParamMap);
        MyUser myUser = (MyUser) listQuery.uniqueResult();
        tempSession.close();

        return myUser; //To change body of implemented methods use File | Settings | File Templates.
    }

}
