package com.efeiyi.ec.website.order.service.impl;

import cn.beecloud.BCEumeration;
import cn.beecloud.BCPay;
import cn.beecloud.BCPayResult;
import cn.beecloud.BeeCloud;
import com.efeiyi.ec.organization.model.User;
import com.efeiyi.ec.purchase.model.PurchaseOrder;
import com.efeiyi.ec.purchase.model.PurchaseOrderPayment;
import com.efeiyi.ec.purchase.model.PurchaseOrderPaymentDetails;
import com.efeiyi.ec.website.order.service.PaymentManager;
import com.efeiyi.ec.website.organization.util.AuthorizationUtil;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.p.service.AutoSerialManager;
import net.sf.json.JSONObject;
import org.omg.PortableInterceptor.SYSTEM_EXCEPTION;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.Date;

/**
 * Created by Administrator on 2015/8/3.
 */
@Service
public class PaymentManagerImpl implements PaymentManager {

    @Autowired
    private BaseManager baseManager;

    @Autowired
    private AutoSerialManager autoSerialManager;

    static {
        BeeCloud.registerApp("130498c1-8928-433b-a01d-c26420f41818", "49fc6d9c-fd5d-4e9c-9ff6-f2d5ef1a1a3e");
    }

    @Override
    public String alipay(PurchaseOrderPaymentDetails purchaseOrderPaymentDetails, Float paymentAmount) {

//        BCPayResult bcPayResult = BCPay.startBCPay(BCEumeration.PAY_CHANNEL.ALI_WEB, purchaseOrderPaymentDetails.getMoney().intValue() * 100, purchaseOrderPaymentDetails.getId(), "非遗产品", null, "http://www2.efeiyi.com/order/paysuccess/" + purchaseOrderPaymentDetails.getId(), null, null, null);
        BCPayResult bcPayResult = BCPay.startBCPay(BCEumeration.PAY_CHANNEL.ALI_WEB, 1, purchaseOrderPaymentDetails.getId(), "非遗产品", null, "http://www2.efeiyi.com/order/paysuccess/" + purchaseOrderPaymentDetails.getId(), null, null, null);
        if (bcPayResult.getType().ordinal() == 0) {
            System.out.println(bcPayResult.getHtml());
            return bcPayResult.getHtml();
        } else {
            //handle the error message as you wish！
            System.out.println(bcPayResult.getErrMsg());
            return "error";
        }
    }

    @Override
    public void payCallback(String purchaseOrderPaymentDetailsId, String transactionNumber) {

        //更新支付记录的交易号
        PurchaseOrderPaymentDetails purchaseOrderPaymentDetails = (PurchaseOrderPaymentDetails) baseManager.getObject(PurchaseOrderPayment.class.getName(), purchaseOrderPaymentDetailsId);
        purchaseOrderPaymentDetails.setTransactionNumber(transactionNumber);
        //@TODO 修改订单状态
        PurchaseOrder purchaseOrder = (PurchaseOrder) baseManager.getObject(PurchaseOrder.class.getName(), purchaseOrderPaymentDetails.getPurchaseOrderPayment().getPurchaseOrder().getId());

        if (purchaseOrder.getSubPurchaseOrder() != null && purchaseOrder.getSubPurchaseOrder().size() > 0) {
            //同时修改子订单状态
            for (PurchaseOrder purchaseOrderTemp : purchaseOrder.getSubPurchaseOrder()) {
                purchaseOrderTemp.setOrderStatus(PurchaseOrder.ORDER_STATUS_WRECEIVE);
                baseManager.saveOrUpdate(PurchaseOrder.class.getName(), purchaseOrderTemp);
            }
        }

        purchaseOrder.setOrderStatus(PurchaseOrder.ORDER_STATUS_WRECEIVE); //改变订单状态为待收货状态
        baseManager.saveOrUpdate(PurchaseOrderPaymentDetails.class.getName(), purchaseOrderPaymentDetails);
        baseManager.saveOrUpdate(PurchaseOrder.class.getName(), purchaseOrder);
    }


    @Override
    public Object wxpay(PurchaseOrderPaymentDetails purchaseOrderPaymentDetails, Float paymentAmount, String openid) {


        BCPayResult bcPayResult = BCPay.startBCPay(BCEumeration.PAY_CHANNEL.WX_JSAPI, purchaseOrderPaymentDetails.getMoney().intValue() * 100, purchaseOrderPaymentDetails.getId() + "", "非遗产品", null, null, openid, null, null);
        if (bcPayResult.getType().ordinal() == 0) {
            JSONObject jsonObject = JSONObject.fromObject(bcPayResult.getWxJSAPIMap());
            return jsonObject;
        } else {
            return null;
        }
    }

    @Override
    public String wxNativePay(PurchaseOrderPaymentDetails purchaseOrderPaymentDetails, Float paymentAmount) {

        BCPayResult bcPayResult = BCPay.startBCPay(BCEumeration.PAY_CHANNEL.WX_NATIVE, purchaseOrderPaymentDetails.getMoney().intValue() * 100, purchaseOrderPaymentDetails.getId() + "", "非遗产品", null, null, null, null, null);
        if (bcPayResult.getType().ordinal() == 0) {
            String codeUrl = bcPayResult.getCodeUrl();
            return codeUrl;
        } else {
            return bcPayResult.getErrMsg();
        }
    }
}
