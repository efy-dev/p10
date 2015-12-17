package com.efeiyi.ec.system.purchaseOrder.dao;


import com.efeiyi.ec.purchase.model.PurchaseOrder;
import com.ming800.core.base.dao.BaseDao;

/**
 * Created by IntelliJ IDEA.
 * User: ming
 * Date: 12-10-16
 * Time: 下午4:18
 * To change this template use File | Settings | File Templates.
 */
public interface PurchaseOrderDao extends BaseDao<PurchaseOrder>{

    /**
     * 改变订单状态
     * @param purchaseOrder
     * @return
     */
    String updateOrderStatus(PurchaseOrder purchaseOrder);


}
