package com.efeiyi.ec.system.product.dao.hibernate;

import com.efeiyi.ec.system.product.dao.ProductDao;
import com.ming800.core.base.dao.XdoDao;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

/**
 * Created by Administrator on 2015/8/17.
 */
@Repository
public class ProductDaoHibernate implements ProductDao{

    @Autowired
    private  XdoDao xdoDao ;

    @Autowired
    @Qualifier("sessionFactory")
    private SessionFactory sessionFactory;

    public Session getSession() {
        return sessionFactory.getCurrentSession();
    }

    @Override
    public int getMaxRecommendedIndex(String categoryId) {
        Integer maxValue = (Integer) this.getSession().createSQLQuery("select max(p.recommended_index) from product p where p.category_id='"+categoryId+"'").uniqueResult();

        return maxValue;
    }
}
