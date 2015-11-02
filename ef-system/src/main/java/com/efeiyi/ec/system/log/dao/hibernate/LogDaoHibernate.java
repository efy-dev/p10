package com.efeiyi.ec.system.log.dao.hibernate;

import com.efeiyi.ec.system.log.dao.LogDao;
import com.ming800.core.p.model.Log;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;


/**
 * Created by IntelliJ IDEA.
 * User: brightpower
 * Date: 2010-1-9
 * Time: 11:51:17
 * To change this template use File | Settings | File Templates.
 */
@Repository
public class LogDaoHibernate implements LogDao {


    @Autowired
    @Qualifier("sessionFactory")
    private SessionFactory sessionFactory;

    public Session getSession() {
//        sessionFactory
        return sessionFactory.getCurrentSession();
    }


    @Override
    public void saveLog(Log log) {

        this.getSession().saveOrUpdate(log);
    }
}
