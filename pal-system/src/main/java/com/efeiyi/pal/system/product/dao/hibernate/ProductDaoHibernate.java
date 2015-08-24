package com.efeiyi.pal.system.product.dao.hibernate;

import com.efeiyi.pal.label.model.Label;
import com.efeiyi.pal.organization.model.Tenant;
import com.efeiyi.pal.product.model.Product;
import com.efeiyi.pal.product.model.ProductSeries;
import com.efeiyi.pal.product.model.TenantProductSeries;
import com.efeiyi.pal.system.product.dao.ProductDao;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by Administrator on 2015/8/22.
 */

@Repository
public class ProductDaoHibernate implements ProductDao {

    @Autowired
    @Qualifier("sessionFactory")
    private SessionFactory sessionFactory;

    public Session getSession() {
        return sessionFactory.getCurrentSession();
    }

    @Override
    public boolean getDeliverLabelByProduct(Product product) {
        String sql = "select l.* from label as l, purchase_order_label as pol, product as p " +
                     "where l.purchase_order_label_id = pol.id and " +
                            "pol.product_id = p.id and " +
                            "p.id = :productId";
        Query query = this.getSession().createSQLQuery(sql)
                .setString("productId", product.getId());
        List<Label> list = query.list();
        if (list != null && list.size() > 0){
            return true;
        }
        return false;
    }

    @Override
    public Object getTenantProductSeriesByTenantAndProductSeries(Tenant tenant, ProductSeries productSeries) {
        String hql = "From TenantProductSeries as tps WHERE tps.tenant.id = :tenantId AND tps.productSeries.id = :productSeriesId";
        Query query = this.getSession().createQuery(hql)
                .setString("tenantId", tenant.getId())
                .setString("productSeriesId", productSeries.getId());
        List<Object> list = query.list();
        if (list != null && list.size() > 0){
            return list.get(0);
        }
        return null;
    }

}
