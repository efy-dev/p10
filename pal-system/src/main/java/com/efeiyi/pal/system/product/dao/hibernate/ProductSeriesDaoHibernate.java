package com.efeiyi.pal.system.product.dao.hibernate;

import com.efeiyi.pal.product.model.ProductSeriesPropertyName;
import com.efeiyi.pal.product.model.TenantProductSeries;
import com.efeiyi.pal.system.product.dao.ProductSeriesDao;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

/**
 * Created by Administrator on 2015/8/27.
 */

@Repository
public class ProductSeriesDaoHibernate implements ProductSeriesDao {

    @Autowired
    @Qualifier("sessionFactory")
    private SessionFactory sessionFactory;

    public Session getSession() {
        return sessionFactory.getCurrentSession();
    }

    @Override
    public Integer deletePropertyValueByPropertyName(ProductSeriesPropertyName propertyName) {
        Session session = this.getSession();
        String hql = "DELETE ProductPropertyValue as ppv WHERE ppv.productSeriesPropertyName = :propertyName";
        Query query = session.createQuery(hql).setParameter("propertyName", propertyName);
        Integer count = query.executeUpdate();
        return count;
    }

    @Override
    public void saveOrUpdate(String modelType, Object object) {
        getSession().saveOrUpdate(modelType, object);
    }

}
