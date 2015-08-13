package com.efeiyi.ec.website.order.service;

import com.efeiyi.ec.purchase.model.PurchaseOrder;

/**
 * Created by Administrator on 2015/8/3.
 */
public interface PaymentManager {

    String alipay(PurchaseOrder purchaseOrder,Float paymentAmount);

    void payCallback(String purchaseOrderPaymentId,String transactionNumber);

//    void wxpayCallback(String purchaseOrderPaymentId,String transactionNumber);

    Object wxpay(PurchaseOrder purchaseOrder, Float paymentAmount,String openid);

    String wxNativePay(PurchaseOrder purchaseOrder, Float paymentAmount);
}
