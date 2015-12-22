package com.efeiyi.ec.website.order.service.impl;

import cn.beecloud.BCEumeration;
import cn.beecloud.BCPay;
import cn.beecloud.BCPayResult;
import cn.beecloud.BeeCloud;
import cn.beecloud.bean.BCPayParameter;
import com.efeiyi.ec.organization.model.User;
import com.efeiyi.ec.purchase.model.Coupon;
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
        BeeCloud.registerApp("130498c1-8928-433b-a01d-c26420f41818", "49fc6d9c-fd5d-4e9c-9ff6-f2d5ef1a1a3e"); //正式环境
  //      BeeCloud.registerApp("e7004ae3-5634-4b9f-998d-c4319fbea7b0", "24511f9a-0b63-4fa0-82c6-6a6ffe38371d");//测试环境
    }

    @Override
    public String alipay(PurchaseOrderPaymentDetails purchaseOrderPaymentDetails, Float paymentAmount) {
        BigDecimal price = new BigDecimal(purchaseOrderPaymentDetails.getMoney().floatValue()* 100);
        BCPayParameter param = new BCPayParameter(BCEumeration.PAY_CHANNEL.ALI_WEB, price.intValue(), purchaseOrderPaymentDetails.getId(), getTitle(purchaseOrderPaymentDetails));
        param.setReturnUrl("http://www.efeiyi.com/order/paysuccess/" + purchaseOrderPaymentDetails.getId());
//        param.setBillTimeout(120);
//        param.setOptional(optional);

        BCPayResult bcPayResult = BCPay.startBCPay(param);
//        BCPayResult bcPayResult = BCPay.startBCPay(BCEumeration.PAY_CHANNEL.ALI_WEB, 1, purchaseOrderPaymentDetails.getId(), "非遗产品", null, "http://www2.efeiyi.com/order/paysuccess/" + purchaseOrderPaymentDetails.getId(), null, null, null);
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
    public String alipayWap(PurchaseOrderPaymentDetails purchaseOrderPaymentDetails, Float paymentAmount) {
        BigDecimal price = new BigDecimal(purchaseOrderPaymentDetails.getMoney().floatValue()* 100);
        BCPayParameter param = new BCPayParameter(BCEumeration.PAY_CHANNEL.ALI_WAP, price.intValue(), purchaseOrderPaymentDetails.getId(), getTitle(purchaseOrderPaymentDetails));
        param.setReturnUrl("http://www.efeiyi.com/order/paysuccess/" + purchaseOrderPaymentDetails.getId());
//        param.setBillTimeout(120);
//        param.setOptional(optional);

        BCPayResult bcPayResult = BCPay.startBCPay(param);
//        BCPayResult bcPayResult = BCPay.startBCPay(BCEumeration.PAY_CHANNEL.ALI_WEB, 1, purchaseOrderPaymentDetails.getId(), "非遗产品", null, "http://www2.efeiyi.com/order/paysuccess/" + purchaseOrderPaymentDetails.getId(), null, null, null);
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
        BigDecimal price = new BigDecimal(purchaseOrderPaymentDetails.getMoney().floatValue()* 100);
        BCPayParameter param = new BCPayParameter(BCEumeration.PAY_CHANNEL.WX_JSAPI, price.intValue(), purchaseOrderPaymentDetails.getId(), getTitle(purchaseOrderPaymentDetails));
        param.setOpenId(openid);
        BCPayResult bcPayResult = BCPay.startBCPay(param);
        if (bcPayResult.getType().ordinal() == 0) {
            JSONObject jsonObject = JSONObject.fromObject(bcPayResult.getWxJSAPIMap());
            return jsonObject;
        } else {
            return null;
        }
    }

    @Override
    public String wxNativePay(PurchaseOrderPaymentDetails purchaseOrderPaymentDetails, Float paymentAmount) {
        BigDecimal price = new BigDecimal(purchaseOrderPaymentDetails.getMoney().floatValue()* 100);
        BCPayParameter param = new BCPayParameter(BCEumeration.PAY_CHANNEL.WX_NATIVE, price.intValue(), purchaseOrderPaymentDetails.getId(), getTitle(purchaseOrderPaymentDetails));
        param.setBillTimeout(120);
        BCPayResult bcPayResult = BCPay.startBCPay(param);
        if (bcPayResult.getType().ordinal() == 0) {
            String codeUrl = bcPayResult.getCodeUrl();
            return codeUrl;
        } else {
            return bcPayResult.getErrMsg();
        }
    }

    private String getTitle(PurchaseOrderPaymentDetails purchaseOrderPaymentDetails){
        String title = "";
        if(purchaseOrderPaymentDetails.getPurchaseOrderPayment().getPurchaseOrder().getPurchaseOrderProductList().size()>1){
            title = "e飞蚁-"+purchaseOrderPaymentDetails.getPurchaseOrderPayment().getPurchaseOrder().getPurchaseOrderProductList().get(0).getProductModel().getName()+" "+"等多件";
        }else if(purchaseOrderPaymentDetails.getPurchaseOrderPayment().getPurchaseOrder().getPurchaseOrderProductList().size() == 1){
            title = "e飞蚁-"+purchaseOrderPaymentDetails.getPurchaseOrderPayment().getPurchaseOrder().getPurchaseOrderProductList().get(0).getProductModel().getName();
        }
        if(title.length()>16){
            title = title.substring(0,13)+"...";
        }
        return title;
    }

    @Override
    public PurchaseOrderPaymentDetails initPurchaseOrderPayment(PurchaseOrder purchaseOrder) {
        PurchaseOrderPayment purchaseOrderPayment = new PurchaseOrderPayment();
        purchaseOrderPayment.setStatus("1");
        purchaseOrderPayment.setCreateDateTime(new Date());
        purchaseOrderPayment.setPaymentAmount(purchaseOrder.getTotal());
        purchaseOrderPayment.setPurchaseOrder(purchaseOrder);
        purchaseOrderPayment.setPayWay("1");
        try {
            purchaseOrderPayment.setSerial(autoSerialManager.nextSerial("payment"));
        } catch (Exception e) {
            e.printStackTrace();
        }
        String userid = AuthorizationUtil.getMyUser().getId();
        User user = (User) baseManager.getObject(User.class.getName(), userid);
        purchaseOrderPayment.setUser(user);
        baseManager.saveOrUpdate(PurchaseOrderPayment.class.getName(), purchaseOrderPayment);
        //支付详情
        if (purchaseOrder.getCoupon() != null) {
            Coupon coupon = purchaseOrder.getCoupon();
            coupon.setStatus("2");
            baseManager.saveOrUpdate(Coupon.class.getName(), coupon);
            PurchaseOrderPaymentDetails purchaseOrderPaymentDetails = new PurchaseOrderPaymentDetails();
            purchaseOrderPaymentDetails.setCoupon(coupon);
            purchaseOrderPaymentDetails.setMoney(new BigDecimal(coupon.getCouponBatch().getPrice()));
            purchaseOrderPaymentDetails.setPayWay("4");
            purchaseOrderPaymentDetails.setPurchaseOrderPayment(purchaseOrderPayment);
            baseManager.saveOrUpdate(PurchaseOrderPaymentDetails.class.getName(), purchaseOrderPaymentDetails);
        }
        PurchaseOrderPaymentDetails purchaseOrderPaymentDetails = new PurchaseOrderPaymentDetails();
        if (purchaseOrder.getCoupon() != null) {
            purchaseOrderPaymentDetails.setMoney(purchaseOrder.getTotal().subtract(new BigDecimal(purchaseOrder.getCoupon().getCouponBatch().getPrice())));
        } else {
            purchaseOrderPaymentDetails.setMoney(purchaseOrder.getTotal());
        }
        purchaseOrderPaymentDetails.setPayWay(purchaseOrder.getPayWay());
        purchaseOrderPaymentDetails.setPurchaseOrderPayment(purchaseOrderPayment);
        baseManager.saveOrUpdate(PurchaseOrderPaymentDetails.class.getName(), purchaseOrderPaymentDetails);
        return purchaseOrderPaymentDetails;
    }
}
