package com.efeiyi.ec.system.purchaseOrder.service;

import com.efeiyi.ec.organization.model.BigUser;
import com.efeiyi.ec.purchase.model.PurchaseOrder;
import com.ming800.core.does.model.PageInfo;
import com.ming800.core.taglib.PageEntity;

import java.util.List;

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
