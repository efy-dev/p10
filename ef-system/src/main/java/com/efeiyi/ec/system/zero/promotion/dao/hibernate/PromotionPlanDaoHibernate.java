package com.efeiyi.ec.system.zero.promotion.dao.hibernate;

import com.efeiyi.ec.organization.model.MyUser;
import com.efeiyi.ec.purchase.model.PurchaseOrder;
import com.efeiyi.ec.system.zero.promotion.dao.PromotionPlanDao;
import com.efeiyi.ec.zero.promotion.model.PromotionPlan;
import com.ming800.core.taglib.PageEntity;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by Administrator on 2015/12/7.
 * PromotionPlanDao 实现类
 */

@SuppressWarnings("JpaQlInspection")
@Repository
public class PromotionPlanDaoHibernate implements PromotionPlanDao {

    @Autowired
    @Qualifier("sessionFactory")
    private SessionFactory sessionFactory;

    public Session getSession() {
        return sessionFactory.getCurrentSession();
    }

    @Override
    public String getDDL(PromotionPlan promotionPlan) throws Exception {
        String hql = "select count(po.id) from PurchaseOrder po where po.source=:source";
        Query query = this.getSession().createQuery(hql)
                .setParameter("source", promotionPlan.getIdentifier());
        List list = query.list();
        if (!list.isEmpty()){
            return list.get(0).toString();
        }
        return null;
    }

    @Override
    public String getZFE(PromotionPlan promotionPlan) throws Exception {
        /*String hql = "select sum(po.total) from PurchaseOrder po, PromotionPurchaseRecord ppr where ppr.purchaseOrder = po and ppr.promotionPlan = :promotionPlan and po.status = :status";
        Query query = this.getSession().createQuery(hql)
                .setParameter("promotionPlan", promotionPlan)
                .setString("status", PurchaseOrder.ORDER_STATUS_FINISHED);*/
        String hql = "select sum(po.total) from PurchaseOrder po where po.source=:source";
        Query query = this.getSession().createQuery(hql)
                .setParameter("source", promotionPlan.getIdentifier());
        List list = query.list();
        if (!list.isEmpty()){
            return list.get(0).toString();
        }
        return null;
    }

    @Override
    public String getSFE(PromotionPlan promotionPlan) throws Exception {
        String hql = "select sum(popd.money) from PurchaseOrderPaymentDetails popd where popd.purchaseOrderPayment.purchaseOrder.source =: source and popd.coupon = null and popd.transactionNumber <> null";
        Query query = this.getSession().createQuery(hql)
                .setParameter("source", promotionPlan.getIdentifier());
        List list = query.list();
        if (!list.isEmpty()){
            return String.valueOf(list.get(0));
        }
        return null;
    }

    @Override
    public List<MyUser> getZCLInformation(PromotionPlan promotionPlan, PageEntity pageEntity) throws Exception {
        String hql = "from MyUser u where u.source=:source";
        Query query = this.getSession().createQuery(hql)
                .setParameter("source", promotionPlan.getIdentifier())
                .setFirstResult(pageEntity.getrIndex())
                .setMaxResults(pageEntity.getSize());
        return query.list();
    }

    @Override
    public List<PurchaseOrder> getDDLInformation(PromotionPlan promotionPlan, PageEntity pageEntity) throws Exception {
        String hql = "select po from PurchaseOrder po where po.source=:source";
        Query query = this.getSession().createQuery(hql)
                .setParameter("source", promotionPlan.getIdentifier())
                .setFirstResult(pageEntity.getrIndex())
                .setMaxResults(pageEntity.getSize());
        return query.list();
    }

}
