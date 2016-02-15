package com.efeiyi.ec.website.order.controller;

import com.efeiyi.ec.organization.model.Consumer;
import com.efeiyi.ec.product.model.ProductModel;
import com.efeiyi.ec.purchase.model.*;
import com.efeiyi.ec.website.order.service.PaymentManager;
import com.efeiyi.ec.website.order.model.WxPayConfig;
import com.efeiyi.ec.website.organization.service.SmsCheckManager;
import com.efeiyi.ec.website.organization.util.AuthorizationUtil;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.util.HttpUtil;
import net.sf.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.ServletInputStream;
import javax.servlet.http.HttpServletRequest;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.math.BigDecimal;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.HashMap;

/**
 * Created by Administrator on 2015/10/10 0010.
 */
@Controller
@RequestMapping({"/order"})
public class PurchaseOrderPaymentController {

    @Autowired
    private SmsCheckManager smsCheckManager;

    @Autowired
    private BaseManager baseManager;

    @Autowired
    private PaymentManager paymentManager;

    @RequestMapping({"/pay/alipay/{orderId}"})
    public String aliPay(HttpServletRequest request, Model model, @PathVariable String orderId) {
        String resultHtml;
        PurchaseOrderPaymentDetails purchaseOrderPaymentDetails = (PurchaseOrderPaymentDetails) baseManager.getObject(PurchaseOrderPaymentDetails.class.getName(), orderId);
        if (HttpUtil.isPhone(request)) {
            resultHtml = paymentManager.alipayWap(purchaseOrderPaymentDetails, purchaseOrderPaymentDetails.getMoney().floatValue());
        } else {
            resultHtml = paymentManager.alipay(purchaseOrderPaymentDetails, purchaseOrderPaymentDetails.getMoney().floatValue());
        }
        model.addAttribute("resultHtml", resultHtml);
        return "/order/alipay";
    }


    @RequestMapping({"/pay/alipay/callback"})
    @ResponseBody
    public String aliPayCallback(HttpServletRequest request) throws IOException {
        try {
            ServletInputStream servletInputStream = request.getInputStream();
            InputStreamReader inputStreamReader = new InputStreamReader(servletInputStream, "UTF-8");
            BufferedReader bufferedReader = new BufferedReader(inputStreamReader);
            String resultJson = bufferedReader.readLine();
            String transactionNumber = "";
            String purchaseOrderPaymentId = "";
            JSONObject jsonObject = JSONObject.fromObject(resultJson);
            String isTradeSuccess = jsonObject.getString("tradeSuccess");
            //只有支付成功的时候才会保存支付记录
            if ("true".equals(isTradeSuccess)) {
                JSONObject messageDetailJson = jsonObject.getJSONObject("messageDetail");
                String channelType = jsonObject.getString("channelType");
                if (channelType.equals("WX")) {
                    transactionNumber = messageDetailJson.getString("transaction_id");
                    purchaseOrderPaymentId = messageDetailJson.getString("out_trade_no");

                } else if (channelType.equals("ALI")) {
                    transactionNumber = messageDetailJson.getString("trade_no");
                    purchaseOrderPaymentId = messageDetailJson.getString("out_trade_no");
                }
                PurchaseOrderPaymentDetails purchaseOrderPaymentDetails = (PurchaseOrderPaymentDetails) baseManager.getObject(PurchaseOrderPaymentDetails.class.getName(), purchaseOrderPaymentId);
                String orderStatus = "";
                PurchaseOrder purchaseOrder = purchaseOrderPaymentDetails.getPurchaseOrderPayment().getPurchaseOrder();
                if (purchaseOrder.getOrderType() != null && purchaseOrder.getOrderType().equals("3")) {  //礼品卷
                    orderStatus = PurchaseOrder.ORDER_STATUS_WRGIFT;
                } else if (purchaseOrder.getOrderType() != null && purchaseOrder.getOrderType().equals("4")) {  //团购
                    orderStatus = PurchaseOrder.ORDER_STATUS_WAIT_GROUP;
                } else {
                    orderStatus = PurchaseOrder.ORDER_STATUS_WRECEIVE;
                }
                if (purchaseOrderPaymentDetails.getPurchaseOrderPayment().getPurchaseOrder().getOrderStatus().equals("1")) {
                    purchaseOrderPaymentDetails.setTransactionNumber(transactionNumber);
                    PurchaseOrderPayment purchaseOrderPayment = purchaseOrderPaymentDetails.getPurchaseOrderPayment();
                    purchaseOrderPayment.setStatus("2");
                    baseManager.saveOrUpdate(PurchaseOrderPayment.class.getName(), purchaseOrderPayment);
                    // 修改订单状态
                    if (purchaseOrder == null) {
                        purchaseOrder = ((PurchaseOrderPayment) baseManager.getObject(PurchaseOrderPayment.class.getName(), purchaseOrderPaymentDetails.getPurchaseOrderPayment().getId())).getPurchaseOrder();
                    }
                    if (purchaseOrder.getSubPurchaseOrder() != null && purchaseOrder.getSubPurchaseOrder().size() > 0) {
                        //同时修改子订单状态
                        for (PurchaseOrder purchaseOrderTemp : purchaseOrder.getSubPurchaseOrder()) {
                            purchaseOrderTemp.setOrderStatus(orderStatus);
                            baseManager.saveOrUpdate(PurchaseOrder.class.getName(), purchaseOrderTemp);
                        }
                    }
                    for (PurchaseOrderProduct purchaseOrderProduct : purchaseOrder.getPurchaseOrderProductList()) {
                        purchaseOrderProduct.getProductModel().setAmount(purchaseOrderProduct.getProductModel().getAmount() - purchaseOrderProduct.getPurchaseAmount());
                        baseManager.saveOrUpdate(ProductModel.class.getName(), purchaseOrderProduct.getProductModel());
                    }
                    purchaseOrder.setOrderStatus(orderStatus); //改变订单状态为待收货状态
                    baseManager.saveOrUpdate(PurchaseOrderPaymentDetails.class.getName(), purchaseOrderPaymentDetails);
                    baseManager.saveOrUpdate(PurchaseOrder.class.getName(), purchaseOrder);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "success";
    }


    @RequestMapping({"/payOrder/{orderId}"})
    public String payPurchaseOrder(HttpServletRequest request, Model model) {
        String orderId = request.getParameter("orderId");
        PurchaseOrder purchaseOrder = (PurchaseOrder) baseManager.getObject(PurchaseOrder.class.getName(), orderId);
        model.addAttribute("order", purchaseOrder);
        return "/purchaseOrder/orderList";
    }

    @RequestMapping({"/pay/weixin/{orderId}"})
    public String wxPay(HttpServletRequest request, @PathVariable String orderId) throws Exception {
        //@TODO 添加订单数据部分
        String redirect_uri = "http://www.efeiyi.com/order/pay/wxParam/" + orderId;
        String url = "https://open.weixin.qq.com/connect/oauth2/authorize?" +
                "appid=" + WxPayConfig.APPID +
                "&redirect_uri=" +
                URLEncoder.encode(redirect_uri, "UTF-8") +
                "&response_type=code&scope=snsapi_base&state=123#wechat_redirect";

        return "redirect:" + url;
    }

    @RequestMapping({"/pay/wxParam/{orderId}"})
    public String getWxOpenId(HttpServletRequest request, Model model, @PathVariable String orderId) throws Exception {
        try {
            PurchaseOrderPaymentDetails purchaseOrderPaymentDetails = (PurchaseOrderPaymentDetails) baseManager.getObject(PurchaseOrderPaymentDetails.class.getName(), orderId);
            String result;
            //1、网页授权后获取传递的code，用于获取openId
            String code = request.getParameter("code");
            if (request.getSession().getAttribute(code) != null) {
                result = request.getSession().getAttribute(code).toString();
            } else {
                String urlForOpenId = "https://api.weixin.qq.com/sns/oauth2/access_token?appid=" + WxPayConfig.APPID + "&secret=" + WxPayConfig.APPSECRET + "&code=" + code + "&grant_type=authorization_code";
                result = HttpUtil.getHttpResponse(urlForOpenId, null);
                request.getSession().setAttribute(code, result);
            }
            JSONObject jsonObject = JSONObject.fromObject(result);
            if (jsonObject.containsKey("errcode")) {
                throw new RuntimeException("get openId error：" + result);
            }
            String openid = jsonObject.getString("openid");
            JSONObject jsonStr = (JSONObject) paymentManager.wxpay(purchaseOrderPaymentDetails, purchaseOrderPaymentDetails.getMoney().floatValue(), openid);
            model.addAttribute("appId", jsonStr.getString("appId"));
            model.addAttribute("timeStamp", jsonStr.getString("timeStamp"));
            model.addAttribute("pk", jsonStr.getString("package"));
            model.addAttribute("paySign", jsonStr.getString("paySign"));
            model.addAttribute("signType", jsonStr.getString("signType"));
            model.addAttribute("nonceStr", jsonStr.getString("nonceStr"));
            model.addAttribute("orderId", purchaseOrderPaymentDetails.getPurchaseOrderPayment().getPurchaseOrder().getId());
            model.addAttribute("order", purchaseOrderPaymentDetails.getPurchaseOrderPayment().getPurchaseOrder());
            model.addAttribute("purchaseOrderPaymentDetails", purchaseOrderPaymentDetails);
            return "/order/wxpay";
        } catch (Exception e) {
            return "redirect:http://i.efeiyi.com";
        }
    }

    @RequestMapping({"/pay/weixin/native/{orderId}"})
    public String wxPayNative(@PathVariable String orderId, Model model) {
        PurchaseOrderPaymentDetails purchaseOrderPaymentDetails = (PurchaseOrderPaymentDetails) baseManager.getObject(PurchaseOrderPaymentDetails.class.getName(), orderId);
        String codeUrl = paymentManager.wxNativePay(purchaseOrderPaymentDetails, purchaseOrderPaymentDetails.getMoney().floatValue());
        model.addAttribute("order", purchaseOrderPaymentDetails);
        model.addAttribute("codeUrl", codeUrl);
        return "/order/wxNative";
    }

    @RequestMapping({"/pay/balance/{orderId}"})
    public String balancePayNative(@PathVariable String orderId, Model model, HttpServletRequest request) {
        String purchaseOrderId = request.getParameter("purchaseOrderId");
        PurchaseOrder purchaseOrder = (PurchaseOrder) baseManager.getObject(PurchaseOrder.class.getName(), purchaseOrderId);
        // 修改订单状态
        if (purchaseOrder.getSubPurchaseOrder() != null && purchaseOrder.getSubPurchaseOrder().size() > 0) {
            //同时修改子订单状态
            for (PurchaseOrder purchaseOrderTemp : purchaseOrder.getSubPurchaseOrder()) {
                purchaseOrderTemp.setOrderStatus(PurchaseOrder.ORDER_STATUS_WRECEIVE);
                baseManager.saveOrUpdate(PurchaseOrder.class.getName(), purchaseOrderTemp);
            }
        }
        for (PurchaseOrderProduct purchaseOrderProduct : purchaseOrder.getPurchaseOrderProductList()) {
            purchaseOrderProduct.getProductModel().setAmount(purchaseOrderProduct.getProductModel().getAmount() - purchaseOrderProduct.getPurchaseAmount());
            baseManager.saveOrUpdate(ProductModel.class.getName(), purchaseOrderProduct.getProductModel());
        }
        if ("3".equals(purchaseOrder.getOrderType())) {
            purchaseOrder.setOrderStatus("6");
            baseManager.saveOrUpdate(PurchaseOrder.class.getName(), purchaseOrder);
            model.addAttribute("order", purchaseOrder);
            return "redirect:/giftReceive/" + purchaseOrderId;
        } else {
            purchaseOrder.setOrderStatus("5");
            baseManager.saveOrUpdate(PurchaseOrder.class.getName(), purchaseOrder);
            model.addAttribute("order", purchaseOrder);
            return "/purchaseOrder/paySuccess";
        }
    }

    @RequestMapping({"/pay/{orderId}"})
    public String orderPay(@PathVariable String orderId, HttpServletRequest request) {
        //从新创建支付记录详情
        PurchaseOrder purchaseOrder = (PurchaseOrder) baseManager.getObject(PurchaseOrder.class.getName(), orderId);
        String isWeiXin = request.getParameter("isWeiXin");//移动网站页面用的
        String payment = purchaseOrder.getPayWay();
        PurchaseOrderPaymentDetails purchaseOrderPaymentDetails = paymentManager.initPurchaseOrderPayment(purchaseOrder);
        if (payment.equals("1")) {//支付宝
            return "redirect:/order/pay/alipay/" + purchaseOrderPaymentDetails.getId();
        } else if (payment.equals("3")) { //微信
            if (isWeiXin != null) {
                return "redirect:/order/pay/weixin/" + purchaseOrderPaymentDetails.getId();
            } else {
                return "redirect:/order/pay/weixin/native/" + purchaseOrderPaymentDetails.getId();
            }
        }
        return "redirect:/order/choosePayment/" + purchaseOrderPaymentDetails.getId();
    }


    @RequestMapping({"/paysuccess/{orderId}"})
    public String paySuccess(@PathVariable String orderId, Model model) throws Exception {
        PurchaseOrderPaymentDetails purchaseOrder = (PurchaseOrderPaymentDetails) baseManager.getObject(PurchaseOrderPaymentDetails.class.getName(), orderId);
        String purchaseOrderSerial;
        String productMassge = "";
        String deliveryName;
        String deliveryNum;
        String deliveryAddress;
        HashMap<String, String> map = new HashMap<>();

        //支付成功发送短信
        PurchaseOrderPayment purchaseOrderPayment = purchaseOrder.getPurchaseOrderPayment();
        if (purchaseOrderPayment == null) {
            PurchaseOrder purchaseOrder1 = ((PurchaseOrderPayment) baseManager.getObject(PurchaseOrderPayment.class.getName(), purchaseOrder.getPurchaseOrderPayment().getId())).getPurchaseOrder();
            purchaseOrderSerial = purchaseOrder1.getId();
            if (purchaseOrder1.getSubPurchaseOrder() != null && purchaseOrder1.getSubPurchaseOrder().size() > 0) {
                //获取自订单信息
                for (PurchaseOrder purchaseOrderTemp : purchaseOrder1.getSubPurchaseOrder()) {
                    purchaseOrderSerial = purchaseOrderTemp.getId();
                    for (PurchaseOrderProduct purchaseOrderProduct : purchaseOrderTemp.getPurchaseOrderProductList()) {
                        productMassge += purchaseOrderProduct.getProductModel().getProduct().getName() + "(" + purchaseOrderProduct.getPurchaseAmount() + ");";
                    }
                    deliveryName = purchaseOrderTemp.getReceiverName();
                    deliveryNum = purchaseOrderTemp.getReceiverPhone();
                    deliveryAddress = purchaseOrderTemp.getPurchaseOrderAddress();
                    map.put("purchaseOrderSerial", purchaseOrderSerial);
                    map.put("productMassge", productMassge);
                    map.put("deliveryName", deliveryName);
                    map.put("deliveryNum", deliveryNum);
                    map.put("deliveryAddress", deliveryAddress);
                    smsCheckManager.send(purchaseOrderTemp.getBigTenant().getPhone(), map, "1216591");
                    smsCheckManager.send("13671386900", map, "1216591");
                }
            } else {
                for (PurchaseOrderProduct purchaseOrderProduct1 : purchaseOrder1.getPurchaseOrderProductList()) {
                    productMassge += purchaseOrderProduct1.getProductModel().getProduct().getName() + "(" + purchaseOrderProduct1.getPurchaseAmount() + ");";
                }
                deliveryName = purchaseOrder1.getReceiverName();
                deliveryNum = purchaseOrder1.getReceiverPhone();
                deliveryAddress = purchaseOrder1.getPurchaseOrderAddress();
                map.put("purchaseOrderSerial", purchaseOrderSerial);
                map.put("productMassge", productMassge);
                map.put("deliveryName", deliveryName);
                map.put("deliveryNum", deliveryNum);
                map.put("deliveryAddress", deliveryAddress);
                smsCheckManager.send(purchaseOrder1.getBigTenant().getPhone(), map, "1216591");
                smsCheckManager.send("13671386900", map, "1216591");
            }
        }

        model.addAttribute("order", purchaseOrder.getPurchaseOrderPayment().getPurchaseOrder());
        if (purchaseOrder.getPurchaseOrderPayment().getPurchaseOrder().getCallback() != null) {
            String redirect = URLDecoder.decode(purchaseOrder.getPurchaseOrderPayment().getPurchaseOrder().getCallback(), "UTF-8");
            return "redirect:http://" + redirect;
        } else if (purchaseOrder.getPurchaseOrderPayment().getPurchaseOrder().getOrderType() != null && purchaseOrder.getPurchaseOrderPayment().getPurchaseOrder().getOrderType().equals("3")) {
            return "redirect:/giftReceive/" + purchaseOrder.getPurchaseOrderPayment().getPurchaseOrder().getId();
        }
        if ("3".equals(purchaseOrder.getPayWay())) {
            return "redirect:http://www2.efeiyi.com/sharePage/productShare/" + purchaseOrder.getPurchaseOrderPayment().getPurchaseOrder().getId();
        } else {
            return "/purchaseOrder/paySuccess";
        }
    }

    @RequestMapping({"/checkInventory/{orderId}"})
    @ResponseBody
    public boolean checkInventory(@PathVariable String orderId, HttpServletRequest request) {
        PurchaseOrder purchaseOrder = (PurchaseOrder) baseManager.getObject(PurchaseOrder.class.getName(), orderId);
        for (PurchaseOrderProduct purchaseOrderProduct : purchaseOrder.getPurchaseOrderProductList()) {
            if (purchaseOrderProduct.getPurchaseAmount() > purchaseOrderProduct.getProductModel().getAmount()) {
                return false;
            }
        }
        return true;
    }

    @RequestMapping({"/checkBalance"})
    @ResponseBody
    public boolean checkBalance(HttpServletRequest request) {
        BigDecimal balance = new BigDecimal(request.getParameter("balance"));
        String consumerId = AuthorizationUtil.getMyUser().getId();
        Consumer consumer = (Consumer) baseManager.getObject(Consumer.class.getName(), consumerId);
        int result = balance.compareTo(consumer.getBalance());
        if (result == 1) {
            return false;
        } else {
            return true;
        }
    }

}
