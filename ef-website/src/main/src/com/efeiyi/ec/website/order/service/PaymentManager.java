package com.efeiyi.ec.website.order.service;

import com.efeiyi.ec.purchase.model.PurchaseOrder;

/**
 * Created by Administrator on 2015/8/3.
 */
public interface PaymentManager {

    String alipay(PurchaseOrder purchaseOrder,Float paymentAmount);

    void alipayCallback(String purchaseOrderPaymentId,String transactionNumber);

    Object wxpay(PurchaseOrder purchaseOrder, Float paymentAmount,String openid);
}
