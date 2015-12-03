package com.efeiyi.ec.system.product.dao.hibernate;

import com.efeiyi.ec.system.product.dao.ProductModelDao;
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
public class ProductModelDaoHibernate implements ProductModelDao {

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
        String hql = "select max(p.recommendIndex) from ProductModel p where p.product.project.projectCategory.id=?";
        Integer maxValue = (Integer) this.getSession().createQuery(hql).setParameter(0,categoryId).uniqueResult();
        if(maxValue == null){
            return 0;
        }
        return maxValue;
    }
}
