package com.efeiyi.ec.website.order.controller;

import com.efeiyi.ec.organization.model.MyUser;
import com.efeiyi.ec.purchase.model.PurchaseOrder;
import com.efeiyi.ec.purchase.model.PurchaseOrderProduct;
import com.efeiyi.ec.website.order.service.PaymentManager;
import com.ming800.core.base.controller.BaseController;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import com.ming800.core.does.model.XSaveOrUpdate;
import net.sf.json.JSONObject;
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

  /*  @Autowired
    private PaymentManager paymentManager;*/


    //΢�Ź��ں���ݵ�Ψһ��ʶ�����ͨ������΢�ŷ��͵��ʼ��в鿴
    public static final String APPID = "wx7f6aa253b75466dd";
    //������ID����ݱ�ʶ
    public static final String MCHID = "1231228502";
    //�̻�֧����ԿKey�����ͨ������΢�ŷ��͵��ʼ��в鿴
    public static final String KEY = "nvkijrk4e7s2ndi3vf4amvqlysu7f1pa";
    //JSAPI�ӿ��л�ȡopenid����˺��ڹ���ƽ̨��������ģʽ��ɲ鿴
    public static final String APPSECRET = "04928de13ab23dca159d235ba6dc19ea";

    //��΢�ŷ�������ȡcode������ת����uri
    public static final String REDIRECT_URI = "http://beijing.yuepaila.com/pc/pay/wxPreparePayParams.do";
    //TODO http://weixin.yuepaila.com:8001/pc/pay/wxPreparePayParams.do

    //=======��֤��·�����á�=====================================
    //֤��·��,ע��Ӧ����д����·��
    /*public static final String SSLCERT_PATH = "/xxx/xxx/xxxx/WxPayPubHelper/cacert/apiclient_cert.pem";
    public static final String SSLKEY_PATH = "/xxx/xxx/xxxx/WxPayPubHelper/cacert/apiclient_key.pem";*/

    //=======���첽֪ͨurl���á�===================================
    //�첽֪ͨurl���̻�����ʵ�ʿ��������趨
    public static final String NOTIFY_URL = "http://beijing.yuepaila.com/pc/pay/wxRecordPayment.do";
    //TODO http://weixin.yuepaila.com:8001/pc/pay/wxRecordPayment.do

    //=======��curl��ʱ���á�===================================
    //������ͨ��curlʹ��HTTP POST�������˴����޸��䳬ʱʱ�䣬Ĭ��Ϊ30��
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
    public String payTest(Model model, HttpServletRequest request) {
        String openid = request.getParameter("openid");
        //paymentManager.wxpay(null, null, openid);
        return "/order/testPayment";
    }

    @RequestMapping({"/pay/weixin"})
    public String wxPay(HttpServletRequest request) throws Exception {
        String orderId = request.getParameter("orderId");
        String redirect_uri = "http://";
        redirect_uri = redirect_uri + "?orderId=" + orderId;
        //scope �����Ӹ������������������scope=snsapi_base ��������Ȩҳ��ֱ����ȨĿ��ֻ��ȡͳһ֧���ӿڵ�openid
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
        //1����ҳ��Ȩ���ȡ���ݵ�code�����ڻ�ȡopenId
        String code = request.getParameter("code");
        System.out.println("1����ҳ��Ȩcodeֵ��" + code);
        String urlForOpenId = "https://api.weixin.qq.com/sns/oauth2/access_token?appid=" + APPID + "&secret=" + APPSECRET + "&code=" + code + "&grant_type=authorization_code";
        String result = getHttpResponse(urlForOpenId, null);
        System.out.println("2����ȡopenidʱ����Ӧ���Ϊ��" + result);
        JSONObject jsonObject = JSONObject.fromObject(result);
        if (jsonObject.containsKey("errcode")) {
            throw new RuntimeException("��ȡopenId�쳣��" + result);
        }
        String openid = jsonObject.getString("openid");
       /* paymentManager.wxpay(null, null, openid);
        model.addAttribute("jsonObject", paymentManager.wxpay(null, null, openid));*/
        return "/order/testPayment";
    }

    public static String getHttpResponse(String urlStr, String requestStr) throws Exception {
        URL url = new URL(urlStr);
        HttpURLConnection connection = (HttpURLConnection) url.openConnection();
        //PrintWriter writer =null;
        if (requestStr != null && !requestStr.equals("")) {
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
        while (scanner.hasNextLine()) {
            responseStr.append(scanner.nextLine());
        }

        return responseStr.toString();
    }

    /**
     * ���ɶ���
     *
     * @return
     */
  /*  @RequestMapping({"/saveOrUpdateOrder.do"})
    public String saveOrUpdateOrder(HttpServletRequest request) throws Exception {
        BigDecimal total_fee = new BigDecimal(0);
        String cartId = request.getParameter("cartId");
        String consumerAddressId = request.getParameter("addressId"); //��ȡ�ջ���ַ��id
        Cart cart = (Cart) baseManager.getObject(Cart.class.getName(), cartId);

        XSaveOrUpdate xSaveOrUpdate = new XSaveOrUpdate("saveOrUpdatePurchaseOrder", request);
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
*/
    @RequestMapping({"/choosePayment/{orderId}"})
    public String choosePayment(@PathVariable String orderId, HttpServletRequest request, Model model) {

        PurchaseOrder purchaseOrder = (PurchaseOrder) baseManager.getObject(PurchaseOrder.class.getName(), orderId);
        model.addAttribute("order", purchaseOrder);

        return "/purchaseOrder/choosePayment";
    }


}
