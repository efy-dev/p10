package com.efeiyi.ec.system.purchaseOrder.service;

import com.efeiyi.ec.purchase.model.PurchaseOrder;
import jxl.write.WriteException;

/**
 * Created by IntelliJ IDEA.
 * User: ming
 * Date: 12-10-15
 * Time: ����5:01
 * To change this template use File | Settings | File Templates.
 */
public interface PurchaseOrderManager {

    /**
     * 后台订单发货使用
     * 记录该订单的物流公司和物流单号*/
    String updateOrderStatus(PurchaseOrder purchaseOrder,String serial,String logisticsCompany);

    String updateOrderStatus(PurchaseOrder purchaseOrder);

    String outExcel(String path,String[] homes,String startTime,String endTime,String selectTenant) throws WriteException;

}
