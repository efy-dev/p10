package com.efeiyi.ec.system.purchaseOrder.dao.hibernate;


import com.efeiyi.ec.purchase.model.PurchaseOrder;
import com.efeiyi.ec.system.purchaseOrder.dao.PurchaseOrderDao;
import com.ming800.core.base.dao.hibernate.BaseDaoSupport;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class PurchaseOrderDaoHibernate extends BaseDaoSupport<PurchaseOrder> implements PurchaseOrderDao{

    @Autowired
    @Qualifier("sessionFactory")
    private SessionFactory sessionFactory;

    public Session getSession() {
//        sessionFactory
        return sessionFactory.getCurrentSession();
    }


    @Override
    public String updateOrderStatus(PurchaseOrder purchaseOrder) {

//        Session session = this.getSession();
//        String hql = "update PurchaseOrder set orderStatus = :orderStatus where id=:id";
//        Query query = session.createQuery(hql)
//                .setString("orderStatus", purchaseOrder.getOrderStatus())
//                .setString("id", purchaseOrder.getId());
//        query.executeUpdate();

        super.saveOrUpdateObject(purchaseOrder);
        return purchaseOrder.getId();

    }

    @Override
    public List getResult() {
        String sql = "SELECT po.serial as 订单号,case po.payway when 1 then '支付宝' when 2 then '银行卡' when 3 then '微信支付' when 4 then '优惠券' end as 支付方式,po.total as 订单总价,case po.order_status when 1 then '等待付款' WHEN  3 THEN  '等待成团'  when 5 then '已付款' WHEN 6 then '待收礼' when 7 then '已发货' when 9 then '未评价' when 13 then '已完成' when 15 then '已退款' when 17 then '已取消' end as 订单状态,po.original_price as 订单原价,po.purchase_order_address as 收货人地址,po.receiver_name as 收货人姓名,po.receiver_phone as 收货人联系方式,po.create_datetime as 下单时间, " +
                "       pm.name as 商品名称,pm.serial as 商品编号, " +
                "       os.username as 下单人, " +
                "       case pc.status when 1 then '未使用' when 2 then '已使用' end as 优惠券,pc.serial as 优惠券号, " +
                "       pcb.name as 优惠券名称,pcb.price as 优惠价格,pcb.price_limit as 优惠条件, " +
                "       t.name as 店铺\n" +
                "  FROM purchase_order po  " +
                "  left join purchase_order_product pop " +
                "  on po.id = pop.purchase_order_id " +
                "  right join product_model pm " +
                "  on pm.id = pop.product_id " +
                "  left join tenant t " +
                "  on t.id = po.tenant_id " +
                "  left join organization_user os " +
                "  on po.user_id = os.id " +
                "  left join purchase_coupon pc  " +
                "  on po.coupon_id = pc.id " +
                "  left join purchase_coupon_batch pcb " +
                "  on pc.coupon_batch_id = pcb.id " +
                "  where po.status != '0' " +
                "  order by po.create_datetime desc";
        List objectList = this.getSession().createSQLQuery(sql).list();
        return objectList;
    }


}
