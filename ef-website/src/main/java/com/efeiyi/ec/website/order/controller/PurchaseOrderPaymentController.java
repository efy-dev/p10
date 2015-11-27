package com.efeiyi.ec.website.order.controller;

import com.efeiyi.ec.organization.model.ConsumerAddress;
import com.efeiyi.ec.organization.model.User;
import com.efeiyi.ec.product.model.ProductModel;
import com.efeiyi.ec.purchase.model.*;
import com.efeiyi.ec.website.order.service.PaymentManager;
import com.efeiyi.ec.website.order.service.WxPayConfig;
import com.efeiyi.ec.website.organization.util.AuthorizationUtil;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import com.ming800.core.p.service.AutoSerialManager;
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
import java.util.Date;
import java.util.HashMap;
import java.util.List;

/**
 * Created by Administrator on 2015/10/10 0010.
 */
@Controller
@RequestMapping({"/order"})
public class PurchaseOrderPaymentController {


    @Autowired
    private BaseManager baseManager;

    @Autowired
    private PaymentManager paymentManager;

    @Autowired
    private AutoSerialManager autoSerialManager;

    @RequestMapping({"/pay/alipay/{orderId}"})
    public String aliPay(HttpServletRequest request, Model model, @PathVariable String orderId) {
        String resultHtml = "";
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
                if (purchaseOrderPaymentDetails.getPurchaseOrderPayment().getPurchaseOrder().getOrderStatus().equals("1")) {
                    purchaseOrderPaymentDetails.setTransactionNumber(transactionNumber);
                    PurchaseOrderPayment purchaseOrderPayment = purchaseOrderPaymentDetails.getPurchaseOrderPayment();
                    purchaseOrderPayment.setStatus("2");
                    //把实际支付详情存在支付记录中
                    purchaseOrderPayment.setPayWay(purchaseOrderPaymentDetails.getPayWay());
                    purchaseOrderPayment.setTransactionNumber(transactionNumber);
                    baseManager.saveOrUpdate(PurchaseOrderPayment.class.getName(), purchaseOrderPayment);

                    PurchaseOrder purchaseOrder = purchaseOrderPaymentDetails.getPurchaseOrderPayment().getPurchaseOrder();
                    if (purchaseOrder == null) {
                        purchaseOrder = ((PurchaseOrderPayment) baseManager.getObject(PurchaseOrderPayment.class.getName(), purchaseOrderPaymentDetails.getPurchaseOrderPayment().getId())).getPurchaseOrder();
                    }
                    if (purchaseOrder.getSubPurchaseOrder() != null && purchaseOrder.getSubPurchaseOrder().size() > 0) {
                        //同时修改子订单状态
                        for (PurchaseOrder purchaseOrderTemp : purchaseOrder.getSubPurchaseOrder()) {
                            purchaseOrderTemp.setOrderStatus(PurchaseOrder.ORDER_STATUS_WRECEIVE);
                            baseManager.saveOrUpdate(PurchaseOrder.class.getName(), purchaseOrderTemp);
                        }
                    }
                    //@TODO 使用库存管理组件做库存管理
                    //修改库存
                    for (PurchaseOrderProduct purchaseOrderProduct : purchaseOrder.getPurchaseOrderProductList()) {
                        purchaseOrderProduct.getProductModel().setAmount(purchaseOrderProduct.getProductModel().getAmount() - purchaseOrderProduct.getPurchaseAmount());
                        baseManager.saveOrUpdate(ProductModel.class.getName(), purchaseOrderProduct.getProductModel());
                    }
                    //需要判断订单类型来改变订单状态
                    //团购的订单在团购端做处理 礼品卷订单在这里处理 如果是礼品卷订单就改为未收礼状态
                    if (purchaseOrder.getOrderType().equals("3")) {
                        purchaseOrder.setOrderStatus(PurchaseOrder.ORDER_STATUS_WRGIFT);
                    } else {
                        purchaseOrder.setOrderStatus(PurchaseOrder.ORDER_STATUS_WRECEIVE); //改变订单状态为待收货状态
                    }
                    baseManager.saveOrUpdate(PurchaseOrderPaymentDetails.class.getName(), purchaseOrderPaymentDetails);
                    baseManager.saveOrUpdate(PurchaseOrder.class.getName(), purchaseOrder);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "success";
    }


    /*
* 付款
* */
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
//        redirect_uri = redirect_uri + "?orderId=" + orderId;
        //scope 参数视各自需求而定，这里用scope=snsapi_base 不弹出授权页面直接授权目的只获取统一支付接口的openid
        String url = "https://open.weixin.qq.com/connect/oauth2/authorize?" +
                "appid=" + WxPayConfig.APPID +
                "&redirect_uri=" +
                URLEncoder.encode(redirect_uri, "UTF-8") +
                "&response_type=code&scope=snsapi_base&state=123#wechat_redirect";

        return "redirect:" + url;
    }

    @RequestMapping({"/pay/wxParam/{orderId}"})
    public String getWxOpenId(HttpServletRequest request, Model model, @PathVariable String orderId) throws Exception {
        PurchaseOrderPaymentDetails purchaseOrderPaymentDetails = (PurchaseOrderPaymentDetails) baseManager.getObject(PurchaseOrderPaymentDetails.class.getName(), orderId);
        String result;
        //1、网页授权后获取传递的code，用于获取openId
        String code = request.getParameter("code");
        if (request.getSession().getAttribute(code) != null) {
            result = request.getSession().getAttribute(code).toString();
        } else {
            System.out.println("1、 page code value：" + code);
            String urlForOpenId = "https://api.weixin.qq.com/sns/oauth2/access_token?appid=" + WxPayConfig.APPID + "&secret=" + WxPayConfig.APPSECRET + "&code=" + code + "&grant_type=authorization_code";
            result = HttpUtil.getHttpResponse(urlForOpenId, null);
            request.getSession().setAttribute(code, result);
        }
        System.out.println("2、get openid result：" + result);
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
        return "/order/wxpay";
    }

    @RequestMapping({"/pay/weixin/native/{orderId}"})
    public String wxPayNative(@PathVariable String orderId, Model model) {
        PurchaseOrderPaymentDetails purchaseOrderPaymentDetails = (PurchaseOrderPaymentDetails) baseManager.getObject(PurchaseOrderPaymentDetails.class.getName(), orderId);
        String codeUrl = paymentManager.wxNativePay(purchaseOrderPaymentDetails, purchaseOrderPaymentDetails.getMoney().floatValue());
        model.addAttribute("order", purchaseOrderPaymentDetails);
        model.addAttribute("codeUrl", codeUrl);
        return "/order/wxNative";
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
    public String paySuccess(@PathVariable String orderId, Model model)throws Exception{
        PurchaseOrderPaymentDetails purchaseOrder = (PurchaseOrderPaymentDetails) baseManager.getObject(PurchaseOrderPaymentDetails.class.getName(), orderId);
        model.addAttribute("order", purchaseOrder.getPurchaseOrderPayment().getPurchaseOrder());
        if (purchaseOrder.getPurchaseOrderPayment().getPurchaseOrder().getCallback()!=null){
            String redirect = URLDecoder.decode(purchaseOrder.getPurchaseOrderPayment().getPurchaseOrder().getCallback(),"UTF-8");
            return "redirect:http://"+redirect;
        }else if (purchaseOrder.getPurchaseOrderPayment().getPurchaseOrder().getOrderType().equals("3")){
            return "redirect:/giftReceive/"+purchaseOrder.getPurchaseOrderPayment().getPurchaseOrder().getId();
        }
        return "/purchaseOrder/paySuccess";
    }

    @RequestMapping({"/checkInventory/{orderId}"})
    @ResponseBody
    public boolean checkInventory(@PathVariable String orderId) {
        PurchaseOrder purchaseOrder = (PurchaseOrder) baseManager.getObject(PurchaseOrder.class.getName(), orderId);
        for (PurchaseOrderProduct purchaseOrderProduct : purchaseOrder.getPurchaseOrderProductList()) {
            if (purchaseOrderProduct.getPurchaseAmount() > purchaseOrderProduct.getProductModel().getAmount()) {
                return false;
            }
        }
        return true;
    }


}
