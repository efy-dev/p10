package com.efeiyi.ec.system.purchaseOrder.dao.hibernate;


import com.efeiyi.ec.organization.model.BigUser;
import com.efeiyi.ec.organization.model.MyUser;
import com.efeiyi.ec.purchase.model.PurchaseOrder;
import com.efeiyi.ec.system.organization.dao.UserDao;
import com.efeiyi.ec.system.purchaseOrder.dao.PurchaseOrderDao;
import com.ming800.core.base.dao.hibernate.BaseDaoSupport;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.envers.Audited;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import java.util.LinkedHashMap;

@Repository
public class PurchaseOrderDaoHibernate  implements PurchaseOrderDao {

    @Autowired
    @Qualifier("sessionFactory")
    private SessionFactory sessionFactory;

    public Session getSession() {
//        sessionFactory
        return sessionFactory.getCurrentSession();
    }



    /**
     * 改变订单状态
     * @param purchaseOrder
     * @return
     */
     @Override
     public String updateOrderStatus(PurchaseOrder purchaseOrder){

         Session session = this.getSession();
         String hql = "update PurchaseOrder set orderStatus = :orderStatus where id=:id";
         Query query =  session.createQuery(hql)
                 .setString("orderStatus", purchaseOrder.getOrderStatus())
                 .setString("id", purchaseOrder.getId());
         query.executeUpdate();
         return  purchaseOrder.getId();

     }


}
