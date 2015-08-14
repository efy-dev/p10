package com.efeiyi.ec.website.order.controller;

import cn.beecloud.BCPay;
import cn.beecloud.BCPayResult;
import cn.beecloud.BeeCloud;
import com.efeiyi.ec.organization.model.ConsumerAddress;
import com.efeiyi.ec.purchase.model.Cart;
import com.efeiyi.ec.purchase.model.CartProduct;
import com.efeiyi.ec.purchase.model.PurchaseOrder;
import com.efeiyi.ec.purchase.model.PurchaseOrderProduct;
import com.efeiyi.ec.website.order.service.PaymentManager;
import com.efeiyi.ec.website.order.service.WxPayConfig;
import com.ming800.core.base.controller.BaseController;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import com.ming800.core.does.model.XSaveOrUpdate;
import com.ming800.core.util.HttpUtil;
import net.sf.json.JSONObject;
import org.omg.PortableInterceptor.SYSTEM_EXCEPTION;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.ServletInputStream;
import javax.servlet.http.HttpServletRequest;
import java.io.*;
import java.math.BigDecimal;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.Enumeration;
import java.util.List;
import java.util.Scanner;

/**
 * Created by Administrator on 2015/6/25.
 */
@Controller
@RequestMapping("/order")
public class PurchaseOrderController extends BaseController {
    @Autowired
    private BaseManager baseManager;

    @Autowired
    private PaymentManager paymentManager;

    /*
    * 订单状态查询
    *
    * */
    @RequestMapping({"/list.do"})
    public String listPruchaseOrder(HttpServletRequest request, Model model) throws Exception {
        String orderStatus = request.getParameter("id");
        XQuery xQuery = null;
        int c = 0;
        if (orderStatus == null) {
            xQuery = new XQuery("plistPurchaseOrder_default", request);
        } else {
            c = Integer.parseInt(orderStatus);
            switch (c) {
                case 1:
                    xQuery = new XQuery("plistPurchaseOrder_default1", request);
                    break;
                case 5:
                    xQuery = new XQuery("plistPurchaseOrder_default5", request);
                    break;
                case 9:
                    xQuery = new XQuery("plistPurchaseOrder_default9", request);
                    break;
                case 13:
                    xQuery = new XQuery("plistPurchaseOrder_default13", request);
                    break;
                case 17:
                    xQuery = new XQuery("plistPurchaseOrder_default17", request);
                    break;
                default:
                    xQuery = new XQuery("plistPurchaseOrder_default", request);
        }

        }
        xQuery.addRequestParamToModel(model, request);
        List<Object> list = baseManager.listPageInfo(xQuery).getList();
        model.addAttribute("orderList", list);
        return "/purchaseOrder/purchaseOrderList";

    }

    /*
    * 查看订单详情
    * */
    @RequestMapping({"/view/{orderId}"})
    public String viewPurchaseOrder(HttpServletRequest request, Model model) {
        String orderId = request.getParameter("orderId");
        PurchaseOrder purchaseOrder = (PurchaseOrder) baseManager.getObject(PurchaseOrder.class.getName(), orderId);
        model.addAttribute("order", purchaseOrder);
        return "/purchaseOrder/orderView";
    }

    @RequestMapping({"/pay/alipay/{orderId}"})
    public String aliPay(HttpServletRequest request, Model model, @PathVariable String orderId) {
        PurchaseOrder purchaseOrder = (PurchaseOrder) baseManager.getObject(PurchaseOrder.class.getName(), orderId);
        String resultHtml = paymentManager.alipay(purchaseOrder, purchaseOrder.getTotal().floatValue());
        model.addAttribute("resultHtml", resultHtml);
        return "/order/alipay";
    }

    @RequestMapping({"/pay/alipay/callback"})
    @ResponseBody
    public String aliPayCallback(HttpServletRequest request) throws IOException {
        //获得返回参数
        ServletInputStream servletInputStream = request.getInputStream();
        InputStreamReader inputStreamReader = new InputStreamReader(servletInputStream, "UTF-8");
        BufferedReader bufferedReader = new BufferedReader(inputStreamReader);
        String resultJson = bufferedReader.readLine();


        String transactionNumber = "";
        String purchaseOrderPaymentId = "";
        System.out.println(resultJson);
        JSONObject jsonObject = JSONObject.fromObject(resultJson);

        //@TODO 判断支付是否成功
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
            System.out.println("transactionNumber : " + transactionNumber);
            System.out.println("purchaseOrderPaymentId : " + purchaseOrderPaymentId);
            paymentManager.payCallback(purchaseOrderPaymentId, transactionNumber);

        }
        return "success";
    }



    /*
    * 取消订单
    * */
    @RequestMapping({"/cancelOrder/{orderId}"})
    public String cancelPurchaseOrder(HttpServletRequest request, Model model) {
        String orderId = request.getParameter("orderId");
        PurchaseOrder purchaseOrder = (PurchaseOrder) baseManager.getObject(PurchaseOrder.class.getName(), orderId);
        purchaseOrder.setOrderStatus(PurchaseOrder.ORDER_STATUS_CONSEL);
        model.addAttribute("order", purchaseOrder);
        return "/purchaseOrder/orderList";
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
        String redirect_uri = "http://master4.efeiyi.com/ef-website/order/pay/wxParam/" + orderId;
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
        PurchaseOrder purchaseOrder = (PurchaseOrder) baseManager.getObject(PurchaseOrder.class.getName(), orderId);
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
        JSONObject jsonStr = (JSONObject) paymentManager.wxpay(purchaseOrder, purchaseOrder.getTotal().floatValue(), openid);
        model.addAttribute("appId", jsonStr.getString("appId"));
        model.addAttribute("timeStamp", jsonStr.getString("timeStamp"));
        model.addAttribute("pk", jsonStr.getString("package"));
        model.addAttribute("paySign", jsonStr.getString("paySign"));
        model.addAttribute("signType", jsonStr.getString("signType"));
        model.addAttribute("nonceStr", jsonStr.getString("nonceStr"));
        return "/order/wxpay";
    }

    @RequestMapping({"/pay/weixin/native/{orderId}"})
    public String wxPayNative(@PathVariable String orderId,Model model){
        PurchaseOrder purchaseOrder = (PurchaseOrder)baseManager.getObject(PurchaseOrder.class.getName(),orderId);
        String codeUrl = paymentManager.wxNativePay(purchaseOrder,purchaseOrder.getTotal().floatValue());
        model.addAttribute("order",purchaseOrder);
        model.addAttribute("codeUrl",codeUrl);
        return "/order/wxNative";
    }


    /**
     * 生成订单
     *
     * @return
     */
    @RequestMapping({"/saveOrUpdateOrder.do"})
    public String saveOrUpdateOrder(HttpServletRequest request) throws Exception {


        BigDecimal total_fee = new BigDecimal(0);
        String cartId = request.getParameter("cartId");
        String consumerAddressId = request.getParameter("addressId"); //获取收货地址的id
        Cart cart = (Cart) baseManager.getObject(Cart.class.getName(), cartId);

        XSaveOrUpdate xSaveOrUpdate = new XSaveOrUpdate("saveOrUpdat  ePurchaseOrder", request);
        xSaveOrUpdate.getParamMap().put("serial", System.currentTimeMillis() + "");
        xSaveOrUpdate.getParamMap().put("consumerAddress_id", consumerAddressId);
        PurchaseOrder purchaseOrder = (PurchaseOrder) baseManager.saveOrUpdate(xSaveOrUpdate);

        List<CartProduct> cartProductList = cart.getCartProductList();
        for (CartProduct cartProductTemp : cartProductList) {
            total_fee.add(new BigDecimal(cartProductTemp.getProductModel().getPrice().intValue() * cartProductTemp.getAmount()));
            PurchaseOrderProduct purchaseOrderProduct = new PurchaseOrderProduct();
            purchaseOrderProduct.setProductModel(cartProductTemp.getProductModel());
            purchaseOrderProduct.setPurchaseAmount(cartProductTemp.getAmount());
            purchaseOrderProduct.setPurchasePrice(cartProductTemp.getProductModel().getPrice());
            purchaseOrderProduct.setPurchaseOrder(purchaseOrder);
            baseManager.saveOrUpdate(PurchaseOrderProduct.class.getName(), purchaseOrderProduct);
        }

        purchaseOrder.setTotal(total_fee);
        baseManager.saveOrUpdate(PurchaseOrder.class.getName(), purchaseOrder);

        String payment = request.getParameter("payment");
        if (payment.equals("1")) {//支付宝
            return "redirect:/order/pay/alipay/" + purchaseOrder.getId();
        } else if (payment.equals("3")) { //微信
            return "redirect:/order/pay/weixin/" + purchaseOrder.getId();
        }
        return "redirect:/order/choosePayment/" + purchaseOrder.getId();
    }

    @RequestMapping({"/choosePayment/{orderId}"})
    public String choosePayment(@PathVariable String orderId, HttpServletRequest request, Model model) {

        PurchaseOrder purchaseOrder = (PurchaseOrder) baseManager.getObject(PurchaseOrder.class.getName(), orderId);
        model.addAttribute("order", purchaseOrder);

        return "/purchaseOrder/choosePayment";
    }


}
