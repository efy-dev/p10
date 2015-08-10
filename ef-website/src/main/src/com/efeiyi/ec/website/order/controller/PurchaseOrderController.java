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

import javax.servlet.http.HttpServletRequest;
import java.io.OutputStream;
import java.math.BigDecimal;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.*;

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


    //微信公众号身份的唯一标识。审核通过后，在微信发送的邮件中查看
    public static final String APPID = "wx7f6aa253b75466dd";
    //受理商ID，身份标识
    public static final String MCHID = "1231228502";
    //商户支付密钥Key。审核通过后，在微信发送的邮件中查看
    public static final String KEY = "nvkijrk4e7s2ndi3vf4amvqlysu7f1pa";
    //JSAPI接口中获取openid，审核后在公众平台开启开发模式后可查看
    public static final String APPSECRET = "04928de13ab23dca159d235ba6dc19ea";

    //从微信服务器获取code，并跳转到此uri
    public static final String REDIRECT_URI = "http://beijing.yuepaila.com/pc/pay/wxPreparePayParams.do";
    //TODO http://weixin.yuepaila.com:8001/pc/pay/wxPreparePayParams.do

    //=======【证书路径设置】=====================================
    //证书路径,注意应该填写绝对路径
    /*public static final String SSLCERT_PATH = "/xxx/xxx/xxxx/WxPayPubHelper/cacert/apiclient_cert.pem";
    public static final String SSLKEY_PATH = "/xxx/xxx/xxxx/WxPayPubHelper/cacert/apiclient_key.pem";*/

    //=======【异步通知url设置】===================================
    //异步通知url，商户根据实际开发过程设定
    public static final String NOTIFY_URL = "http://beijing.yuepaila.com/pc/pay/wxRecordPayment.do";
    //TODO http://weixin.yuepaila.com:8001/pc/pay/wxRecordPayment.do

    //=======【curl超时设置】===================================
    //本例程通过curl使用HTTP POST方法，此处可修改其超时时间，默认为30秒
    public static final int CURL_TIMEOUT = 30;


    @RequestMapping({"/list"})
    public String listPruchaseOrder(HttpServletRequest request, Model model) throws Exception {

        XQuery xQuery = new XQuery("plistPurchaseOrder_default", request);
        xQuery.addRequestParamToModel(model, request);

        List<Object> list = baseManager.listPageInfo(xQuery).getList();
        model.addAttribute("orderList", list);

        return "/purchaseOrder/orderList";

    }

    @RequestMapping({"/view/{orderId}"})
    public String viewPurchaseOrder(@PathVariable String orderId, Model model) {

        Object order = baseManager.getObject(PurchaseOrder.class.getName(), orderId);
        model.addAttribute("order", order);

        return "/purchaseOrder/orderView";

    }


    @RequestMapping({"/pay/weixin"})
    public String wxPay(HttpServletRequest request) throws Exception {
        String orderId = request.getParameter("orderId");
        //@TODO 添加订单数据部分
        String redirect_uri = "http://master4.efeiyi.com/ef-website/order/pay/wxParam.do";
//        redirect_uri = redirect_uri + "?orderId=" + orderId;
        //scope 参数视各自需求而定，这里用scope=snsapi_base 不弹出授权页面直接授权目的只获取统一支付接口的openid
        String url = "https://open.weixin.qq.com/connect/oauth2/authorize?" +
                "appid=" + APPID +
                "&redirect_uri=" +
                URLEncoder.encode(redirect_uri, "UTF-8") +
                "&response_type=code&scope=snsapi_base&state=123#wechat_redirect";

        return "redirect:" + url;
    }

    @RequestMapping({"/pay/wxParam.do"})
    public String getWxOpenId(HttpServletRequest request, Model model) throws Exception {
        String orderId = request.getParameter("orderId");
        String result = "";
        //1、网页授权后获取传递的code，用于获取openId
        String code = request.getParameter("code");
        if (request.getSession().getAttribute(code) != null) {
            result = request.getSession().getAttribute(code).toString();
        } else {

            System.out.println("1、 page code value：" + code);
            String urlForOpenId = "https://api.weixin.qq.com/sns/oauth2/access_token?appid=" + APPID + "&secret=" + APPSECRET + "&code=" + code + "&grant_type=authorization_code";
            result = HttpUtil.getHttpResponse(urlForOpenId, null);
            request.getSession().setAttribute(code,result);
        }
        System.out.println("2、get openid result：" + result);
        JSONObject jsonObject = JSONObject.fromObject(result);
        if (jsonObject.containsKey("errcode")) {
            throw new RuntimeException("get openId error：" + result);
        }
        String openid = jsonObject.getString("openid");
        JSONObject jsonStr = (JSONObject)paymentManager.wxpay(null, null, openid);
        model.addAttribute("appId",jsonStr.getString("appId"));
        model.addAttribute("timeStamp",jsonStr.getString("timeStamp"));
        model.addAttribute("pk",jsonStr.getString("package"));
        model.addAttribute("paySign",jsonStr.getString("paySign"));
        model.addAttribute("signType",jsonStr.getString("signType"));
        model.addAttribute("nonceStr",jsonStr.getString("nonceStr"));
        return "/order/testPayment";
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

        return "redirect:/order/choosePayment/" + purchaseOrder.getId();
    }

    @RequestMapping({"/choosePayment/{orderId}"})
    public String choosePayment(@PathVariable String orderId, HttpServletRequest request, Model model) {

        PurchaseOrder purchaseOrder = (PurchaseOrder) baseManager.getObject(PurchaseOrder.class.getName(), orderId);
        model.addAttribute("order", purchaseOrder);

        return "/purchaseOrder/choosePayment";
    }


}
