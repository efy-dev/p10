package com.efeiyi.ec.system.purchaseOrder.service;

import com.efeiyi.ec.purchase.model.PurchaseOrder;

/**
 * Created by IntelliJ IDEA.
 * User: ming
 * Date: 12-10-15
 * Time: ����5:01
 * To change this template use File | Settings | File Templates.
 */
public interface PurchaseOrderManager {

    /**
     * �ı䶩��״̬
     * @param purchaseOrder
     * @return
     */
    String updateOrderStatus(PurchaseOrder purchaseOrder);

}
