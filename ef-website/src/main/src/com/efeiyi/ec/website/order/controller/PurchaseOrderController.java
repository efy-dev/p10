package com.efeiyi.ec.website.order.controller;

import cn.beecloud.BCPay;
import cn.beecloud.BCPayResult;
import cn.beecloud.BeeCloud;
import com.efeiyi.ec.purchase.model.PurchaseOrder;
import com.efeiyi.ec.website.order.service.PaymentManager;
import com.ming800.core.base.controller.BaseController;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import net.sf.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import java.io.OutputStream;
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
    public String viewPurchaseOrder(@PathVariable String orderId,Model model){

        Object order = baseManager.getObject(PurchaseOrder.class.getName(),orderId);
        model.addAttribute("order",order);

        return "/purchaseOrder/orderView";

    }

    @RequestMapping({"/pay/test"})
    public String payTest(Model model ,HttpServletRequest request){
        String openid = request.getParameter("openid");
        paymentManager.wxpay(null,null,openid);
        return "/order/testPayment";
    }

    @RequestMapping({"/pay/weixin"})
    public String wxPay(HttpServletRequest request) throws Exception{
        String orderId = request.getParameter("orderId");
        String redirect_uri = "http://";
        redirect_uri = redirect_uri+"?orderId="+orderId;
        //scope 参数视各自需求而定，这里用scope=snsapi_base 不弹出授权页面直接授权目的只获取统一支付接口的openid
        String url = "https://open.weixin.qq.com/connect/oauth2/authorize?" +
                "appid=" + APPID+
                "&redirect_uri=" +
                URLEncoder.encode(redirect_uri, "UTF-8")+
                "&response_type=code&scope=snsapi_base&state=123#wechat_redirect";
        return "redirect:"+url;
    }

    @RequestMapping({"/pay/wxParam.do"})
    public String getWxOpenId(HttpServletRequest request ,Model model) throws Exception{
        String orderId = request.getParameter("orderId");
        //1、网页授权后获取传递的code，用于获取openId
        String code = request.getParameter("code");
        System.out.println("1、网页授权code值："+code);
        String urlForOpenId = "https://api.weixin.qq.com/sns/oauth2/access_token?appid="+APPID+"&secret="+APPSECRET+"&code="+code+"&grant_type=authorization_code";
        String result = getHttpResponse(urlForOpenId,null);
        System.out.println("2、获取openid时的响应结果为："+result);
        JSONObject jsonObject = JSONObject.fromObject(result);
        if(jsonObject.containsKey("errcode")){
            throw new RuntimeException("获取openId异常："+result);
        }
        String openid = jsonObject.getString("openid");
        paymentManager.wxpay(null,null,openid);
        model.addAttribute("jsonObject",paymentManager.wxpay(null,null,openid));
        return "/order/testPayment";
    }

    public static String getHttpResponse(String urlStr,String requestStr) throws Exception{
        URL url = new URL(urlStr);
        HttpURLConnection connection = (HttpURLConnection)url.openConnection();
        //PrintWriter writer =null;
        if(requestStr!=null && !requestStr.equals("")){
            connection.setDoOutput(true);
            OutputStream outputStream = connection.getOutputStream();
            outputStream.write(requestStr.getBytes("UTF-8"));
            outputStream.flush();
            /*writer = new PrintWriter(connection.getOutputStream());
            writer.println(requestStr);
            writer.flush();*/
        }
        Scanner scanner = new Scanner(connection.getInputStream());
        StringBuilder responseStr = new StringBuilder();
        while (scanner.hasNextLine()){
            responseStr.append(scanner.nextLine());
        }

        return responseStr.toString();
    }


}
