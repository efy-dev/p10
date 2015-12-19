package com.efeiyi.ec.system.zero.virtual.dao.hibernate;

import com.efeiyi.ec.purchase.model.PurchaseOrderProduct;
import com.efeiyi.ec.system.zero.virtual.dao.VirtualPlanDao;
import com.efeiyi.ec.zero.virtual.model.VirtualOrderPlan;
import com.efeiyi.ec.zero.virtual.model.VirtualUser;
import com.efeiyi.ec.zero.virtual.model.VirtualUserPlan;
import com.ming800.core.taglib.PageEntity;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;

import java.util.List;

/**
 * Created by Administrator on 2015/12/9.
 * 虚拟计划 Dao 实现类
 */
@SuppressWarnings("JpaQlInspection")
public class VirtualPlanDaoHibernate implements VirtualPlanDao {

    @Autowired
    @Qualifier("sessionFactory")
    private SessionFactory sessionFactory;

    public Session getSession() {
        return sessionFactory.getCurrentSession();
    }

    @Override
    public Integer getOrderRelation(VirtualOrderPlan virtualOrderPlan) throws Exception {
        String hql = "select sum(vpm.randomAmount) from VirtualProductModel vpm where vpm.virtualOrderPlan = :virtualOrderPlan";
        Query query = this.getSession().createQuery(hql)
                .setParameter("virtualOrderPlan", virtualOrderPlan);
        List list = query.list();
        if (list != null || !list.isEmpty()){
            return Integer.parseInt(list.get(0).toString());
        }
        return null;
    }

    @Override
    public List<PurchaseOrderProduct> getOrderProductList(VirtualOrderPlan virtualOrderPlan, PageEntity pageEntity) throws Exception {
        String hql = "select pop from PurchaseOrderProduct pop, VirtualPurchaseOrder vpo where vpo.virtualOrderPlan = :virtualOrderPlan";
        Query query = this.getSession().createQuery(hql)
                .setParameter("virtualOrderPlan", virtualOrderPlan)
                .setFirstResult(pageEntity.getrIndex())
                .setMaxResults(pageEntity.getSize());
        return query.list();
    }

    @Override
    public List<VirtualUser> getVirtualUserList(VirtualUserPlan virtualUserPlan, PageEntity pageEntity) throws Exception {
        String hql = "select vu from VirtualUser vu where vu.virtualUserPlan = :virtualUserPlan";
        Query query = this.getSession().createQuery(hql)
                .setParameter("virtualUserPlan", virtualUserPlan)
                .setFirstResult(pageEntity.getrIndex())
                .setMaxResults(pageEntity.getSize());
        return query.list();
    }


    /*@Override
    public List<User> getZCLInfomation(PromotionPlan promotionPlan, PageEntity pageEntity) throws Exception {
        String hql = "select u from User u, PromotionUserRecord pur where pur.user = u and pur.promotionPlan = :promotionPlan";
        Query query = this.getSession().createQuery(hql)
                .setParameter("promotionPlan", promotionPlan)
                .setFirstResult(pageEntity.getrIndex())
                .setMaxResults(pageEntity.getSize());
        return query.list();
    }

    @Override
    public List<PurchaseOrder> getDDLInfomation(PromotionPlan promotionPlan, PageEntity pageEntity) throws Exception {
        String hql = "select po from PurchaseOrder po, PromotionPurchaseRecord ppr where ppr.purchaseOrder = po and ppr.promotionPlan = :promotionPlan";
        Query query = this.getSession().createQuery(hql)
                .setParameter("promotionPlan", promotionPlan)
                .setFirstResult(pageEntity.getrIndex())
                .setMaxResults(pageEntity.getSize());
        return query.list();
    }*/


}
