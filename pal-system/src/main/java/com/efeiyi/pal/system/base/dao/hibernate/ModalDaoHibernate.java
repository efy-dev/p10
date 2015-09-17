package com.efeiyi.pal.system.base.dao.hibernate;

import com.efeiyi.pal.organization.model.Tenant;
import com.efeiyi.pal.system.base.dao.ModalDao;
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
@Repository
public class ModalDaoHibernate implements ModalDao {

    @Autowired
    @Qualifier("sessionFactory")
    private SessionFactory sessionFactory;

    public Session getSession() {
        return sessionFactory.getCurrentSession();
    }

    @Override
    public Set<Object> getListLikesName(String name, String type) {
        String hql = "From " + type + " as t WHERE t.name like :name AND t.status = '1' order by t.id desc";
        Query query = this.getSession().createQuery(hql)
                .setString("name", "%"+name+"%");
        List<Object> list = query.list();
        return new HashSet<>(list);
    }

    @Override
    public Set<Object> getObjectByTenantLikesName(String name, Tenant tenant, String type) {
        String hql = "From "+ type +" as t WHERE t.name like :name AND t.status = '1' AND t.tenant=:tenant order by t.id desc";
        Query query = this.getSession().createQuery(hql)
                .setString("name", "%"+name+"%")
                .setParameter("tenant", tenant);
        List<Object> list = query.list();
        return new HashSet<>(list);
    }

    @Override
    public Set<Object> getTypeFromTenantProductSeriesLikesName(String name, String type) {
        String hql = "select tps."+ type +" From TenantProductSeries as tps WHERE tps."+ type +".name like :name AND tps.status = '1' order by tps.id desc";
        Query query = this.getSession().createQuery(hql)
                .setString("name", "%" + name + "%");
        List<Object> list = query.list();
        return new HashSet<>(list);
    }

    @Override
    public Set<Object> getTypeFromTenantProductSeriesByObjectLikesName(String name, String type, String type2, Object object) {
        String hql = "select tps."+ type +" From TenantProductSeries as tps WHERE tps."+ type +".name like :name AND tps.status = '1' AND tps."+type2+" =:obj  order by tps.id desc";
        Query query = this.getSession().createQuery(hql)
                .setString("name", "%" + name + "%")
                .setParameter("obj", object);
        List<Object> list = query.list();
        return new HashSet<>(list);
    }

}
