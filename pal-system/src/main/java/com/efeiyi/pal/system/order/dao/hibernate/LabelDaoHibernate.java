package com.efeiyi.pal.system.order.dao.hibernate;

import com.efeiyi.pal.label.model.Label;
import com.efeiyi.pal.purchase.model.PurchaseOrder;
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
    public List<Label> getLabelListByMinSerialAndSumProduct(Integer sumProduct, String type) {
        String hql = "From Label as lab WHERE lab.status = :status AND lab.labelBatch.type = :labelType order by serial";
        Query query = this.getSession().createQuery(hql)
                .setString("status", "1")
                .setString("labelType", type);
        query.setMaxResults(sumProduct);
        List<Label> list = query.list();
        return list;
    }

    @Override
    public void saveOrUpdate(String modelType, Object object) {
        getSession().saveOrUpdate(modelType, object);
    }

    @Override
    public List<Label> getLabelListByOrder(PurchaseOrder purchaseOrder) {
        String hql = "FROM Label WHERE status =:status AND purchaseOrderLabel in (:purchaseOrderLabelList)";
        Query query = this.getSession().createQuery(hql)
                .setString("status", "2")
                .setParameterList("purchaseOrderLabelList", purchaseOrder.getPurchaseOrderLabelList().toArray());
        List<Label> labelList = query.list();
        return labelList;
    }

}
