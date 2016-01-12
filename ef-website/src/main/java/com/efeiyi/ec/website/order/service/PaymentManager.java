package com.efeiyi.ec.website.order.service;

import com.efeiyi.ec.purchase.model.PurchaseOrder;
import com.efeiyi.ec.purchase.model.PurchaseOrderPaymentDetails;

/**
 * Created by Administrator on 2015/8/3.
 */
public interface PaymentManager {

    String alipay(PurchaseOrderPaymentDetails purchaseOrderPaymentDetails,Float paymentAmount);

    void payCallback(String purchaseOrderPaymentId,String transactionNumber);

    Object wxpay(PurchaseOrderPaymentDetails purchaseOrderPaymentDetails, Float paymentAmount,String openid);

    String wxNativePay(PurchaseOrderPaymentDetails purchaseOrderPaymentDetails, Float paymentAmount);

    PurchaseOrderPaymentDetails initPurchaseOrderPayment(PurchaseOrder purchaseOrder);

    PurchaseOrderPaymentDetails initPurchaseOrderPayment(PurchaseOrder purchaseOrder, String balance);

    String alipayWap(PurchaseOrderPaymentDetails purchaseOrderPaymentDetails, Float paymentAmount);
}
