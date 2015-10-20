package com.efeiyi.association.dao.hibernate;

import com.efeiyi.association.dao.ProtectionDao;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by Administrator on 2015/10/8.
 * 申报查询 Dao Impl
 */

@Repository
public class ProtectionDaoHibernate implements ProtectionDao {

    @Autowired
    @Qualifier("sessionFactory")
    private SessionFactory sessionFactory;

    public Session getSession() {
        return sessionFactory.getCurrentSession();
    }

    @SuppressWarnings("JpaQlInspection")
    @Override
    public Object CheckDeclareState(String name, String sub_group) {
        String hql = "From ApplicationMaterial as am WHERE am.subGroup = :subGroup AND am.name = :name and status <> '0'";
        Query query = this.getSession().createQuery(hql)
                .setString("name", name)
                .setString("subGroup", sub_group);
        List<Object> list = query.list();
        if (list != null && list.size() > 0){
            return list.get(0);
        }
        return null;
    }

}
