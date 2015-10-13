package com.efeiyi.association.dao.hibernate;

import com.efeiyi.ec.association.model.AssMyUser;
import com.efeiyi.association.dao.UserDao;
import com.efeiyi.ec.association.model.AssUser;
import com.ming800.core.base.dao.hibernate.BaseDaoSupport;
import org.hibernate.Query;
import org.hibernate.Session;

import java.util.LinkedHashMap;

/**
 * Created by Administrator on 2015/8/10.
 */
@Deprecated
public class UserDaoHibernate extends BaseDaoSupport<AssUser> implements UserDao {

    @Override
    public AssUser getUniqueMyUserByConditions(String branchName, String queryHql, LinkedHashMap<String, Object> queryParamMap) {

        Session tempSession = super.getSessionFactory().openSession();

        AssUser user = null;
        try {
            Query listQuery = tempSession.createQuery(queryHql);
            setQueryParams(listQuery, queryParamMap);
            user = (AssUser) listQuery.uniqueResult();
        }catch (Exception e){
            e.printStackTrace();
        }finally {
            tempSession.close();
        }

        return user;
    }

}
