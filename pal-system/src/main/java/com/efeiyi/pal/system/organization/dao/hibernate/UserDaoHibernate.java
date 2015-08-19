package com.efeiyi.pal.system.organization.dao.hibernate;

import com.efeiyi.pal.organization.model.User;
import com.efeiyi.pal.system.organization.dao.UserDao;
import com.ming800.core.base.dao.hibernate.BaseDaoSupport;
import org.hibernate.Query;
import org.hibernate.Session;

import java.util.LinkedHashMap;

/**
 * Created by Administrator on 2015/8/10.
 */
public class UserDaoHibernate extends BaseDaoSupport<User> implements UserDao {

    @Override
    public User getUniqueMyUserByConditions(String branchName, String queryHql, LinkedHashMap<String, Object> queryParamMap) {

        Session tempSession = super.getSessionFactory().openSession();

        User myUser = null;
        try {
            Query listQuery = tempSession.createQuery(queryHql);
            setQueryParams(listQuery, queryParamMap);
            myUser = (User) listQuery.uniqueResult();
        }catch (Exception e){
            e.printStackTrace();
        }finally {
            tempSession.close();
        }

        return myUser;
    }

}
