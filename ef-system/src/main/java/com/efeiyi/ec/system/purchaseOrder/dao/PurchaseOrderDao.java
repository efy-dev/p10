package com.efeiyi.ec.system.purchaseOrder.dao;



import com.efeiyi.ec.purchase.model.PurchaseOrder;

/**
 * Created by IntelliJ IDEA.
 * User: ming
 * Date: 12-10-16
 * Time: ����4:18
 * To change this template use File | Settings | File Templates.
 */
public interface PurchaseOrderDao {

    String updateOrderStatus(PurchaseOrder purchaseOrder);


}
