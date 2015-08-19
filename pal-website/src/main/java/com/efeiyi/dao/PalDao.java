package com.efeiyi.dao;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.orm.hibernate4.support.HibernateDaoSupport;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;

/**
 * Created by Administrator on 2015/8/19.
 */

@Component
public class PalDao extends HibernateDaoSupport implements IPalDao {

    @Autowired
    @Qualifier("sessionFactory")
    private SessionFactory sessionFactory;

    public Session getSession() {
        return sessionFactory.getCurrentSession();
    }

    @Resource
    public void setSessionFactory0(SessionFactory sessionFactory){
        super.setSessionFactory(sessionFactory);
    }

    public Query createQuery(String queryString){
        return getSession().createQuery(queryString);
    }

    public void saveOrUpdate(String modelType, Object object){
        getSession().saveOrUpdate(modelType, object);
    }

}
