package com.efeiyi.pal.system.order.dao.hibernate;

import com.efeiyi.pal.label.model.Label;
import com.efeiyi.pal.system.order.dao.LabelDao;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by Administrator on 2015/8/18.
 */

@Repository
public class LabelDaoHibernate implements LabelDao {

    @Autowired
    @Qualifier("sessionFactory")
    private SessionFactory sessionFactory;

    public Session getSession() {
        return sessionFactory.getCurrentSession();
    }

    @Override
    public Long getMinSerial() {
        String hql = "SELECT MIN(serial) FROM Label WHERE status = :status";
        Query query = this.getSession().createQuery(hql).setString("status", "1");
        List<Long> list= query.list();
        if (list != null && list.size() >0){
            return list.get(0);
        }
        return null;
    }

    @Override
    public List<Label> getLabelListByMinSerialAndSumProduct(Long minSerial, Integer sumProduct) {
        String hql = "From Label WHERE status = :status AND serial BETWEEN :minSerial AND :maxSerial";
        Query query = this.getSession().createQuery(hql)
                .setString("status", "1")
                .setLong("minSerial", minSerial)
                .setLong("maxSerial", (minSerial + sumProduct - 1));
        List<Label> list = query.list();
        return list;
    }

}
