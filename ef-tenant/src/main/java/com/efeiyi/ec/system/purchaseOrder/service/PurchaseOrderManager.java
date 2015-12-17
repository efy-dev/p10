package com.efeiyi.ec.system.purchaseOrder.service;

import com.efeiyi.ec.purchase.model.PurchaseOrder;

/**
 * Created by IntelliJ IDEA.
 * User: ming
 * Date: 12-10-15
 * Time: 下午5:01
 * To change this template use File | Settings | File Templates.
 */
public interface PurchaseOrderManager {

    /**
     * 改变订单状态
     * @param purchaseOrder
     * @return
     */
    String updateOrderStatus(PurchaseOrder purchaseOrder,String serial,String logisticsCompany);

    String updateOrderStatus(PurchaseOrder purchaseOrder);

}
