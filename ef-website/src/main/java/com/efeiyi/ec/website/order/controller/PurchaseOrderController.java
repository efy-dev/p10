package com.efeiyi.ec.website.order.controller;

import com.efeiyi.ec.organization.model.BigUser;
import com.efeiyi.ec.organization.model.ConsumerAddress;
import com.efeiyi.ec.product.model.Product;
import com.efeiyi.ec.product.model.ProductModel;
import com.efeiyi.ec.purchase.model.Cart;
import com.efeiyi.ec.purchase.model.*;
import com.efeiyi.ec.purchase.model.CartProduct;
import com.efeiyi.ec.purchase.model.PurchaseOrder;
import com.efeiyi.ec.purchase.model.PurchaseOrderProduct;
import com.efeiyi.ec.tenant.model.Tenant;
import com.efeiyi.ec.website.order.service.PaymentManager;
import com.efeiyi.ec.website.order.service.WxPayConfig;
import com.efeiyi.ec.website.organization.util.AuthorizationUtil;
import com.ming800.core.base.controller.BaseController;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import com.ming800.core.does.model.XSaveOrUpdate;
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
import java.io.*;
import java.math.BigDecimal;
import java.net.URL;
import java.net.URLConnection;
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

    @Autowired
    private AutoSerialManager autoSerialManager;

    /*
    * 订单状态查询
    *
    * */
    @RequestMapping({"/myEfeiyi/list.do"})
    public String listPruchaseOrder(HttpServletRequest request, Model model) throws Exception {
        String orderStatus = request.getParameter("status");
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
 *手机端个人中心(订单查询)
 *
 */
    @RequestMapping({"/myMobileEfeiyi/list.do"})
    public String listPruchaseOrderForMobile(HttpServletRequest request, Model model) throws Exception {
        XQuery xQuery = new XQuery("plistPurchaseOrder_default", request);
        xQuery.addRequestParamToModel(model, request);
        List<Object> list = baseManager.listPageInfo(xQuery).getList();
        model.addAttribute("orderList", list);
        return "purchaseOrder/purchaseOrder";
    }

    /*
    * 查看订单详情
    * */
    @RequestMapping({"/myEfeiyi/view/{orderId}"})
    public String viewPurchaseOrder(Model model, @PathVariable String orderId) {
        PurchaseOrder purchaseOrder = (PurchaseOrder) baseManager.getObject(PurchaseOrder.class.getName(), orderId);
        model.addAttribute("order", purchaseOrder);
        LinkedHashMap<String, Object> queryParamMap = new LinkedHashMap<>();
        queryParamMap.put("orderId", orderId);
        String hql = "from PurchaseOrderDelivery p where p.purchaseOrder.id=:orderId";
        PurchaseOrderDelivery purchaseOrderDelivery = (PurchaseOrderDelivery) baseManager.getUniqueObjectByConditions(hql, queryParamMap);
        String pd = "null";
        String serial = "null";
        if (purchaseOrderDelivery != null) {
            pd = purchaseOrderDelivery.getLogisticsCompany();
            serial = purchaseOrderDelivery.getSerial();
        }
        model.addAttribute("purchaseOrderDelivery", purchaseOrderDelivery);
        String content = "";
        try {
            URL url = new URL("http://www.kuaidi100.com/applyurl?key=" + "f8e96a50d49ef863" + "&com=" + pd + "&nu=" + serial);
            URLConnection con = url.openConnection();
            con.setAllowUserInteraction(false);
            InputStream urlStream = url.openStream();
            byte b[] = new byte[10000];
            int numRead = urlStream.read(b);
            content = new String(b, 0, numRead);
            while (numRead != -1) {
                numRead = urlStream.read(b);
                if (numRead != -1) {
                    String newContent = new String(b, 0, numRead, "UTF-8");
                    content += newContent;
                }
            }
            urlStream.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        System.out.print(content);
        model.addAttribute("content", content);

        return "/purchaseOrder/purchaseOrderView";
    }

    @RequestMapping({"/pay/alipay/{orderId}"})
    public String aliPay(HttpServletRequest request, Model model, @PathVariable String orderId) {
        PurchaseOrder purchaseOrder = (PurchaseOrder) baseManager.getObject(PurchaseOrder.class.getName(), orderId);
        String resultHtml = paymentManager.alipay(purchaseOrder, purchaseOrder.getTotal().floatValue());
        model.addAttribute("resultHtml", resultHtml);
        return "/order/alipay";
    }

    //
//    {"transactionType":"PAY","retryCounter":10,"transactionFee":1,"tradeSuccess":tru
//        e,"notifyUrl":"http://master4.efeiyi.com/ef-website/order/pay/alipay/callback","
//        channelType":"ALI","optional":{},"messageDetail":{"bc_appid":"130498c1-8928-433b
//            -a01d-c26420f41818_7bba2e15-90f6-4274-b56c-291302825d82","discount":"0.00","paym
//        ent_type":"1","subject":"非遗产品","trade_no":"2015082500001000370059468325","bu
//        yer_email":"fullclass@sohu.com","gmt_create":"2015-08-25 17:57:30","notify_type"
//        :"trade_status_sync","quantity":"1","out_trade_no":"idr6gvdc30c2v1yt","seller_id
//        ":"2088911195111171","notify_time":"2015-08-25 17:57:46","trade_status":"TRADE_S
//        UCCESS","is_total_fee_adjust":"N","total_fee":"0.01","gmt_payment":"2015-08-25 1
//        7:57:46","seller_email":"feiyipark@ich-park.com","price":"0.01","buyer_id":"2088
//        302138690372","notify_id":"6973870d15793850425d02d63a53927942","use_coupon":"N",
//        "sign_type":"MD5","sign":"70af79b510f7e4ca6876523029df02e6","tradeSuccess":true}
//    ,"transactionId":"idr6gvdc30c2v1yt","sign":"9a0c2d275615c5369ada83aa18391fb8","t
//    imestamp":1440498660000}
    @RequestMapping({"/pay/alipay/callback"})
    @ResponseBody
    public String aliPayCallback(HttpServletRequest request) throws IOException {
        //获得返回参数
//
//        String resultJson = "{\"transactionType\":\"PAY\",\"retryCounter\":10,\"transactionFee\":1,\"tradeSuccess\":tru" +
//                "e,\"notifyUrl\":\"http://master4.efeiyi.com/ef-website/order/pay/alipay/callback\",\"" +
//                "channelType\":\"ALI\",\"optional\":{},\"messageDetail\":{\"bc_appid\":\"130498c1-8928-433b" +
//                "-a01d-c26420f41818_7bba2e15-90f6-4274-b56c-291302825d82\",\"discount\":\"0.00\",\"paym" +
//                "ent_type\":\"1\",\"subject\":\"非遗产品\",\"trade_no\":\"2015082500001000370059468325\",\"bu" +
//                "yer_email\":\"fullclass@sohu.com\",\"gmt_create\":\"2015-08-25 17:57:30\",\"notify_type\"" +
//                ":\"trade_status_sync\",\"quantity\":\"1\",\"out_trade_no\":\"idr6gvdc30c2v1yt\",\"seller_id" +
//                "\":\"2088911195111171\",\"notify_time\":\"2015-08-25 17:57:46\",\"trade_status\":\"TRADE_S" +
//                "UCCESS\",\"is_total_fee_adjust\":\"N\",\"total_fee\":\"0.01\",\"gmt_payment\":\"2015-08-25 1" +
//                "7:57:46\",\"seller_email\":\"feiyipark@ich-park.com\",\"price\":\"0.01\",\"buyer_id\":\"2088" +
//                "302138690372\",\"notify_id\":\"6973870d15793850425d02d63a53927942\",\"use_coupon\":\"N\"," +
//                "\"sign_type\":\"MD5\",\"sign\":\"70af79b510f7e4ca6876523029df02e6\",\"tradeSuccess\":true}" +
//                ",\"transactionId\":\"idr6gvdc30c2v1yt\",\"sign\":\"9a0c2d275615c5369ada83aa18391fb8\",\"t" +
//                "imestamp\":1440498660000}";
        try {

//
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
//            paymentManager.payCallback(purchaseOrderPaymentId, transactionNumber);


                PurchaseOrderPayment purchaseOrderPayment = (PurchaseOrderPayment) baseManager.getObject(PurchaseOrderPayment.class.getName(), purchaseOrderPaymentId);
                purchaseOrderPayment.setTransactionNumber(transactionNumber);
                //@TODO 修改订单状态
                PurchaseOrder purchaseOrder = purchaseOrderPayment.getPurchaseOrder();
                if (purchaseOrder.getSubPurchaseOrder() != null && purchaseOrder.getSubPurchaseOrder().size() > 0) {
                    //同时修改子订单状态
                    for (PurchaseOrder purchaseOrderTemp : purchaseOrder.getSubPurchaseOrder()) {
                        purchaseOrderTemp.setOrderStatus(PurchaseOrder.ORDER_STATUS_WRECEIVE);
                        baseManager.saveOrUpdate(PurchaseOrder.class.getName(), purchaseOrderTemp);
                    }
                }


                purchaseOrder.setOrderStatus(PurchaseOrder.ORDER_STATUS_WRECEIVE); //改变订单状态为待收货状态
                baseManager.saveOrUpdate(PurchaseOrderPayment.class.getName(), purchaseOrderPayment);
                baseManager.saveOrUpdate(PurchaseOrder.class.getName(), purchaseOrder);

            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "success";
    }


    /*
  * 取消订单
  * */
    @RequestMapping({"/cancelOrder/{orderId}"})
    public String cancelPurchaseOrder(@PathVariable String orderId) throws Exception {
        PurchaseOrder purchaseOrder = (PurchaseOrder) baseManager.getObject(PurchaseOrder.class.getName(), orderId);
        purchaseOrder.setOrderStatus(PurchaseOrder.ORDER_STATUS_CONSEL);
        baseManager.saveOrUpdate(PurchaseOrder.class.getName(), purchaseOrder);
        return "redirect:/order/myEfeiyi/list.do";
    }

    /**
     * 订单删除
     */
    @RequestMapping({"/deleteOrder/{orderId}"})
    public String deleteOrder(@PathVariable String orderId) {
        baseManager.remove(PurchaseOrder.class.getName(), orderId);
        return "redirect:/order/myEfeiyi/list.do";
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
    public String wxPayNative(@PathVariable String orderId, Model model) {
        PurchaseOrder purchaseOrder = (PurchaseOrder) baseManager.getObject(PurchaseOrder.class.getName(), orderId);
        String codeUrl = paymentManager.wxNativePay(purchaseOrder, purchaseOrder.getTotal().floatValue());
        model.addAttribute("order", purchaseOrder);
        model.addAttribute("codeUrl", codeUrl);
        return "/order/wxNative";
    }

    @RequestMapping({"/easyBuy/{productModelId}"})
    public String buyImmediate(HttpServletRequest request, @PathVariable String productModelId, Model model) throws Exception {
        ProductModel productModel = (ProductModel) baseManager.getObject(ProductModel.class.getName(), productModelId);
        CartProduct cartProduct = new CartProduct();
        cartProduct.setProductModel(productModel);
        cartProduct.setAmount(1);
        cartProduct.setIsChoose("1");
        cartProduct.setStatus("1");
        List<CartProduct> cartProductList = new ArrayList<>();
        cartProductList.add(cartProduct);
        Map<String, List> productMap = new HashMap<>();
        productMap.put(productModel.getProduct().getTenant().getId(), cartProductList);
        model.addAttribute("productMap", productMap);
        Cart cart = new Cart();
        cart.setTotalPrice(productModel.getPrice());
        model.addAttribute("cart", cart);
        List<Tenant> tenantList = new ArrayList<>();
        tenantList.add(productModel.getProduct().getTenant());
        model.addAttribute("tenantList", tenantList);

        XSaveOrUpdate xSaveOrUpdate = new XSaveOrUpdate("saveOrUpdatePurchaseOrder", request);
        xSaveOrUpdate.getParamMap().put("serial", autoSerialManager.nextSerial("orderSerial"));
        xSaveOrUpdate.getParamMap().put("user.id", AuthorizationUtil.getMyUser().getId());
        PurchaseOrder purchaseOrder = (PurchaseOrder) baseManager.saveOrUpdate(xSaveOrUpdate);

        purchaseOrder.setTenant(tenantList.get(0));
        purchaseOrder.setTotal(cart.getTotalPrice());
        baseManager.saveOrUpdate(PurchaseOrder.class.getName(), purchaseOrder);

        PurchaseOrderProduct purchaseOrderProduct = new PurchaseOrderProduct();
        purchaseOrderProduct.setPurchaseOrder(purchaseOrder);
        purchaseOrderProduct.setProductModel(productModel);
        purchaseOrderProduct.setPurchasePrice(productModel.getPrice());
        purchaseOrderProduct.setPurchaseAmount(productModel.getAmount());
        baseManager.saveOrUpdate(PurchaseOrderProduct.class.getName(), purchaseOrderProduct);

        XQuery xQuery = new XQuery("listConsumerAddress_default", request);
        xQuery.addRequestParamToModel(model, request);
        List addressList = baseManager.listPageInfo(xQuery).getList();

        model.addAttribute("addressList", addressList);
        model.addAttribute("purchaseOrder", purchaseOrder);

        return "/purchaseOrder/purchaseOrderConfirm";
    }


    /**
     * 生成订单
     *
     * @return
     */
    @RequestMapping({"/saveOrUpdateOrder.do"})
    public String saveOrUpdateOrder(HttpServletRequest request, Model model) throws Exception {
        String cartId = request.getParameter("cartId");
        Cart cart;
        if (cartId == null || cartId.equals("")) {
            cart = (Cart) request.getSession().getAttribute("cart");
            XQuery xQuery = new XQuery("listCart_default", request);
            List<Object> list = baseManager.listObject(xQuery);
            Cart realCart = (Cart) list.get(0);
            realCart.setTotalPrice(realCart.getTotalPrice() != null ? realCart.getTotalPrice().add(cart.getTotalPrice()) : cart.getTotalPrice());
            baseManager.saveOrUpdate(Cart.class.getName(), realCart);
            if (cart.getCartProductList() != null && cart.getCartProductList().size() > 0) {
                for (CartProduct cartProduct : cart.getCartProductList()) {
                    cartProduct.setCart(realCart);
                    baseManager.saveOrUpdate(CartProduct.class.getName(), cartProduct);
                }
            }
            request.getSession().removeAttribute("cart");
            cart = (Cart) baseManager.getObject(Cart.class.getName(), realCart.getId());
        } else {
            cart = (Cart) baseManager.getObject(Cart.class.getName(), cartId);
        }
        //得到店铺的信息
        List<Tenant> tenantListTemp = new ArrayList<>();
        List<Tenant> tenantList = new ArrayList<>();
        List<CartProduct> cartProductList = cart.getCartProductList();
        HashMap<String, List> productMap = new HashMap<>();

        XSaveOrUpdate xSaveOrUpdate = new XSaveOrUpdate("saveOrUpdatePurchaseOrder", request);
        xSaveOrUpdate.getParamMap().put("serial", autoSerialManager.nextSerial("orderSerial"));
        xSaveOrUpdate.getParamMap().put("user.id", AuthorizationUtil.getMyUser().getId());
        PurchaseOrder purchaseOrder = (PurchaseOrder) baseManager.saveOrUpdate(xSaveOrUpdate);

        for (CartProduct cartProductTemp : cartProductList) {
            if (cartProductTemp.getIsChoose().equals("1")) {
                PurchaseOrderProduct purchaseOrderProduct = new PurchaseOrderProduct();
                purchaseOrderProduct.setProductModel(cartProductTemp.getProductModel());
                purchaseOrderProduct.setPurchaseAmount(cartProductTemp.getAmount());
                purchaseOrderProduct.setPurchasePrice(cartProductTemp.getProductModel().getPrice());
                purchaseOrderProduct.setPurchaseOrder(purchaseOrder);
                baseManager.saveOrUpdate(PurchaseOrderProduct.class.getName(), purchaseOrderProduct);
                ProductModel productModel = (ProductModel) baseManager.getObject(ProductModel.class.getName(), cartProductTemp.getProductModel().getId());
                Product product = productModel.getProduct();
                Tenant tenant = product.getTenant();
                tenantListTemp.add(tenant);
            }
        }

        for (Tenant tenantTemp : tenantListTemp) {
            boolean isContain = false;
            for (Tenant tenant : tenantList) {
                if (tenant.getId().equals(tenantTemp.getId())) {
                    isContain = true;
                    break;
                } else {
                    isContain = false;
                }
            }
            if (!isContain) {
                tenantList.add(tenantTemp);
            }
        }

        model.addAttribute("tenantList", tenantList);
        purchaseOrder.setTotal(cart.getTotalPrice());
        baseManager.saveOrUpdate(PurchaseOrder.class.getName(), purchaseOrder); //生成父订单

        //拆分订单
        if (tenantList.size() > 1) {
            for (Tenant tenantTemp : tenantList) {
                XSaveOrUpdate xSaveOrUpdateTemp = new XSaveOrUpdate("saveOrUpdatePurchaseOrder", request);
                xSaveOrUpdateTemp.getParamMap().put("serial", autoSerialManager.nextSerial("orderSerial"));
                xSaveOrUpdateTemp.getParamMap().put("user.id", AuthorizationUtil.getMyUser().getId());
                PurchaseOrder purchaseOrderTemp = (PurchaseOrder) baseManager.saveOrUpdate(xSaveOrUpdateTemp);
                purchaseOrderTemp.setFatherPurchaseOrder(purchaseOrder);
                purchaseOrderTemp.setTenant(tenantTemp);
                for (CartProduct cartProductTemp : cartProductList) {
                    if (cartProductTemp.getProductModel().getProduct().getTenant().getId().equals(tenantTemp.getId()) && cartProductTemp.getIsChoose().equals("1")) {
                        PurchaseOrderProduct purchaseOrderProduct = new PurchaseOrderProduct();
                        purchaseOrderProduct.setProductModel(cartProductTemp.getProductModel());
                        purchaseOrderProduct.setPurchaseAmount(cartProductTemp.getAmount());
                        purchaseOrderProduct.setPurchasePrice(cartProductTemp.getProductModel().getPrice());
                        purchaseOrderProduct.setPurchaseOrder(purchaseOrderTemp);
                        baseManager.saveOrUpdate(PurchaseOrderProduct.class.getName(), purchaseOrderProduct);
                    }
                }
                baseManager.saveOrUpdate(PurchaseOrder.class.getName(), purchaseOrderTemp);
            }
        } else {
            purchaseOrder.setTenant(tenantList.get(0));
            baseManager.saveOrUpdate(PurchaseOrder.class.getName(), purchaseOrder);
        }

        for (Tenant tenant : tenantList) {
            List<Object> productList = new ArrayList<>();
            for (CartProduct cartProduct : cartProductList) {
                ProductModel productModel = (ProductModel) baseManager.getObject(ProductModel.class.getName(), cartProduct.getProductModel().getId());
                cartProduct.setProductModel(productModel);
                if (productModel.getProduct().getTenant().getId().equals(tenant.getId())) {
                    productList.add(cartProduct);
                }
            }
            productMap.put(tenant.getId(), productList);
        }

        model.addAttribute("productMap", productMap);
        model.addAttribute("cart", cart);

        //收货地址
        XQuery xQuery = new XQuery("listConsumerAddress_default", request);
        xQuery.addRequestParamToModel(model, request);
        List addressList = baseManager.listObject(xQuery);

        model.addAttribute("addressList", addressList);
        model.addAttribute("purchaseOrder", purchaseOrder);

        return "/purchaseOrder/purchaseOrderConfirm";
    }


    @RequestMapping({"/confirm/{orderId}"})
    public String orderConfirm(@PathVariable String orderId, HttpServletRequest request) throws Exception {
        String payment = request.getParameter("payment");
        String isWeiXin = request.getParameter("isWeiXin");//移动网站页面用的
        String addressId = request.getParameter("address");
        String message = request.getParameter("message");

        //买家留言
        HashMap<String, String> messageMap = new HashMap<>();

        for (String messageTemp : message.split(";")) {
            if (messageTemp != null && !messageTemp.equals("") && messageTemp.length() == 2) {
                messageMap.put(messageTemp.split(":")[0], messageTemp.split(":")[1]);
            }
        }


        ConsumerAddress consumerAddress = (ConsumerAddress) baseManager.getObject(ConsumerAddress.class.getName(), addressId);
        PurchaseOrder purchaseOrder = (PurchaseOrder) baseManager.getObject(PurchaseOrder.class.getName(), orderId);
        purchaseOrder.setStatus("1");
        purchaseOrder.setPayWay(payment);
        purchaseOrder.setConsumerAddress(consumerAddress);
        List<PurchaseOrder> subPurchaseOrderList = purchaseOrder.getSubPurchaseOrder();
        if (subPurchaseOrderList != null && subPurchaseOrderList.size() > 1) {
            for (PurchaseOrder purchaseOrderTemp : subPurchaseOrderList) {
                purchaseOrderTemp.setStatus("1");
                purchaseOrderTemp.setConsumerAddress(consumerAddress);
                purchaseOrderTemp.setMessage(messageMap.get(purchaseOrderTemp.getTenant().getId() + "Message"));
                baseManager.saveOrUpdate(PurchaseOrder.class.getName(), purchaseOrderTemp);
            }
        } else {
            purchaseOrder.setMessage(messageMap.get(purchaseOrder.getTenant().getId() + "Message"));
        }
        baseManager.saveOrUpdate(PurchaseOrder.class.getName(), purchaseOrder);

        //@TODO 清除购物车
        XQuery xQuery = new XQuery("listCart_default", request);
        List<Object> list = baseManager.listObject(xQuery);
        Cart realCart = (Cart) list.get(0);
        realCart.setTotalPrice(new BigDecimal(0));
        baseManager.saveOrUpdate(Cart.class.getName(), realCart);
        for (CartProduct cartProductTemp : realCart.getCartProductList()) {
            if (cartProductTemp.getIsChoose().equals("1")) {
                baseManager.remove(CartProduct.class.getName(), cartProductTemp.getId());
            }
        }


        if (payment.equals("1")) {//支付宝
            return "redirect:/order/pay/alipay/" + purchaseOrder.getId();
        } else if (payment.equals("3")) { //微信
            if (isWeiXin != null) {
                return "redirect:/order/pay/weixin/" + purchaseOrder.getId();
            } else {
                return "redirect:/order/pay/weixin/native/" + purchaseOrder.getId();
            }
        }
        return "redirect:/order/choosePayment/" + purchaseOrder.getId();
//        return "redirect:/order/pay/alipay/callback";
    }


    @RequestMapping({"/pay/{orderId}"})
    public String orderPay(@PathVariable String orderId, HttpServletRequest request) {
        PurchaseOrder purchaseOrder = (PurchaseOrder) baseManager.getObject(PurchaseOrder.class.getName(), orderId);
        String isWeiXin = request.getParameter("isWeiXin");//移动网站页面用的
        String payment = purchaseOrder.getPayWay();
        if (payment.equals("1")) {//支付宝
            return "redirect:/order/pay/alipay/" + purchaseOrder.getId();
        } else if (payment.equals("3")) { //微信
            if (isWeiXin != null) {
                return "redirect:/order/pay/weixin/" + purchaseOrder.getId();
            } else {
                return "redirect:/order/pay/weixin/native/" + purchaseOrder.getId();
            }
        }
        return "redirect:/order/choosePayment/" + purchaseOrder.getId();
//        return "redirect:/order/pay/alipay/callback";
    }


    @RequestMapping({"/choosePayment/{orderId}"})
    public String choosePayment(@PathVariable String orderId, HttpServletRequest request, Model model) {

        PurchaseOrder purchaseOrder = (PurchaseOrder) baseManager.getObject(PurchaseOrder.class.getName(), orderId);
        model.addAttribute("order", purchaseOrder);

        return "/purchaseOrder/choosePayment";
    }

    @RequestMapping({"/addAddress.do"})
    @ResponseBody
    public Object addAddressJson(HttpServletRequest request) throws Exception {
        XSaveOrUpdate xSaveOrUpdate = new XSaveOrUpdate("saveOrUpdateConsumerAddress", request);
        xSaveOrUpdate.getParamMap().put("consumer_id", AuthorizationUtil.getMyUser().getId());
        Object object = baseManager.saveOrUpdate(xSaveOrUpdate);
        return object;
    }

    @RequestMapping({"/paysuccess/{orderId}"})
    public String paySuccess(@PathVariable String orderId, Model model) {
        PurchaseOrder purchaseOrder = (PurchaseOrder) baseManager.getObject(PurchaseOrder.class.getName(), orderId);
        model.addAttribute("order", purchaseOrder);
        return "/purchaseOrder/paySuccess";
    }


}
