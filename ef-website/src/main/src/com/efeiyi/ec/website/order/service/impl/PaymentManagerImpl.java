package com.efeiyi.ec.website.order.service.impl;

import cn.beecloud.BCEumeration;
import cn.beecloud.BCPay;
import cn.beecloud.BCPayResult;
import cn.beecloud.BeeCloud;
import com.efeiyi.ec.organization.model.User;
import com.efeiyi.ec.purchase.model.PurchaseOrder;
import com.efeiyi.ec.purchase.model.PurchaseOrderPayment;
import com.efeiyi.ec.website.order.service.PaymentManager;
import com.efeiyi.ec.website.organization.util.AuthorizationUtil;
import com.ming800.core.base.service.BaseManager;
import net.sf.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.Date;

/**
 * Created by Administrator on 2015/8/3.
 */
@Service
public class PaymentManagerImpl implements PaymentManager {

//    @Autowired
//    private BaseManager baseManager;

    @Override
    public String alipay(PurchaseOrder purchaseOrder, Float paymentAmount) {

        PurchaseOrderPayment purchaseOrderPayment = new PurchaseOrderPayment();
        purchaseOrderPayment.setStatus("1");
        purchaseOrderPayment.setCreateDateTime(new Date());
        purchaseOrderPayment.setPaymentAmount(new BigDecimal(paymentAmount));
        purchaseOrderPayment.setPurchaseOrder(purchaseOrder);
        purchaseOrderPayment.setPayWay("1");
        User user = new User();
        user.setId(AuthorizationUtil.getMyUser().getId());
        purchaseOrderPayment.setUser(user);

        BeeCloud.registerApp("130498c1-8928-433b-a01d-c26420f41818", "49fc6d9c-fd5d-4e9c-9ff6-f2d5ef1a1a3e");

        BCPayResult bcPayResult = BCPay.startBCPay(BCEumeration.PAY_CHANNEL.ALI_WEB, purchaseOrder.getTotal().intValue()*100, purchaseOrder.getSerial(), "非遗产品", null, "http://www.efeiyi.com", null, null, null);
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
    public void alipayCallback(String purchaseOrderPaymentId, String transactionNumber) {
//        //更新支付记录的交易号
//        PurchaseOrderPayment purchaseOrderPayment = (PurchaseOrderPayment) baseManager.getObject(PurchaseOrderPayment.class.getName(), purchaseOrderPaymentId);
//        purchaseOrderPayment.setTransactionNumber(transactionNumber);
//        //@TODO 修改订单状态
//        baseManager.saveOrUpdate(PurchaseOrderPayment.class.getName(), purchaseOrderPayment);
    }


    @Override
    public String wxpay(PurchaseOrder purchaseOrder, Float paymentAmount,String openid) {

//        PurchaseOrderPayment purchaseOrderPayment = new PurchaseOrderPayment();
//        purchaseOrderPayment.setStatus("1");
//        purchaseOrderPayment.setCreateDateTime(new Date());
//        purchaseOrderPayment.setPaymentAmount(new BigDecimal(paymentAmount));
//        purchaseOrderPayment.setPurchaseOrder(purchaseOrder);
//        purchaseOrderPayment.setPayWay("1");
//        User user = new User();
//        user.setId(AuthorizationUtil.getMyUser().getId());
//        purchaseOrderPayment.setUser(user);

        BeeCloud.registerApp("130498c1-8928-433b-a01d-c26420f41818", "49fc6d9c-fd5d-4e9c-9ff6-f2d5ef1a1a3e");

//        BCPayResult bcPayResult = BCPay.startBCPay(BCEumeration.PAY_CHANNEL.WX_JSAPI, purchaseOrder.getTotal().intValue() * 100, purchaseOrder.getSerial(), "非遗产品", null, "http://www.efeiyi.com", null, null, null);
        BCPayResult bcPayResult = BCPay.startBCPay(BCEumeration.PAY_CHANNEL.WX_JSAPI, 1, "123456", "非遗产品", null, "http://www.efeiyi.com", openid, null, null);
        if (bcPayResult.getType().ordinal() == 0) {
//            System.out.println(bcPayResult.getWxJSAPIMap());
            JSONObject jsonObject = JSONObject.fromObject(bcPayResult.getWxJSAPIMap());
            return jsonObject.toString();
        } else {
            //handle the error message as you wish！
            System.out.println(bcPayResult.getErrMsg());
            return bcPayResult.getErrMsg();
        }
    }
}
