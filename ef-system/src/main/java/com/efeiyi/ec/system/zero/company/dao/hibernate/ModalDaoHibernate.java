package com.efeiyi.ec.system.zero.company.dao.hibernate;

import com.efeiyi.ec.system.zero.company.dao.ModalDao;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

/**
 * Created by Administrator on 2015/9/8.
 *
 */
@SuppressWarnings("JpaQlInspection")
@Repository
public class ModalDaoHibernate implements ModalDao {

    @Autowired
    @Qualifier("sessionFactory")
    private SessionFactory sessionFactory;

    public Session getSession() {
        return sessionFactory.getCurrentSession();
    }

    @Override
    public Set<Object> getListLikesName(String name, String type, String status) throws Exception {
        String hql = "From " + type + " as t WHERE t.name like :name AND t.status = :status order by t.id desc";
        Query query = this.getSession().createQuery(hql)
                .setString("name", "%"+name+"%")
                .setString("status", status);
        List<Object> list = query.list();
        return new HashSet<>(list);
    }

    @Override
    public Set<Object> getListLikesProductName(String name, String type, String status) throws Exception {
        String hql = "From " + type + " as t WHERE t.product.name like :name AND t.product.status = :status order by t.id desc";
        Query query = this.getSession().createQuery(hql)
                .setString("name", "%"+name+"%")
                .setString("status", status);
        List<Object> list = query.list();
        return new HashSet<>(list);
    }

    @Override
    public List getListProductModel() throws Exception {
        String hql = "From ProductModel as t WHERE t.product.status = '1' order by t.id desc";
        Query query = this.getSession().createQuery(hql);
        return query.list();
    }

}
