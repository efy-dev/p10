package com.efeiyi.ec.website.order.controller;

import com.efeiyi.ec.organization.model.*;
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
        model.addAttribute("status", orderStatus);
        XQuery xQuery = null;
        int c = 0;
        if (orderStatus == null || orderStatus == "") {
            xQuery = new XQuery("plistPurchaseOrder_default", request, 10);
        } else {
            c = Integer.parseInt(orderStatus);
            switch (c) {
                case 1:
                    xQuery = new XQuery("plistPurchaseOrder_default1", request, 10);
                    break;
                case 5:
                    xQuery = new XQuery("plistPurchaseOrder_default5", request, 10);
                    break;
                case 9:
                    xQuery = new XQuery("plistPurchaseOrder_default9", request, 10);
                    break;
                case 13:
                    xQuery = new XQuery("plistPurchaseOrder_default13", request, 10);
                    break;
                case 17:
                    xQuery = new XQuery("plistPurchaseOrder_default17", request, 10);
                    break;
                default:
                    xQuery = new XQuery("plistPurchaseOrder_default", request, 10);
            }

        }
        xQuery.addRequestParamToModel(model, request);
        List<Object> list = baseManager.listPageInfo(xQuery).getList();
        String userId = AuthorizationUtil.getMyUser().getId();
        BigUser user = (BigUser) baseManager.getObject(BigUser.class.getName(), userId);
        model.addAttribute("orderList", list);
        model.addAttribute("user", user);
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
        List dl = new ArrayList();
        PurchaseOrder purchaseOrder = (PurchaseOrder) baseManager.getObject(PurchaseOrder.class.getName(), orderId);
        model.addAttribute("order", purchaseOrder);
        String lc = "";
        String serial = "";
        String content = "";
        if (purchaseOrder.getSubPurchaseOrder().equals(null) || purchaseOrder.getSubPurchaseOrder().size() == 0) {
            List pl = purchaseOrder.getPurchaseOrderDeliveryList();
            if (pl.size() > 0) {

                serial = purchaseOrder.getPurchaseOrderDeliveryList().get(0).getSerial();
                lc = purchaseOrder.getPurchaseOrderDeliveryList().get(0).getLogisticsCompany();

                try {
                    URL url = new URL("http://www.kuaidi100.com/applyurl?key=" + "f8e96a50d49ef863" + "&com=" + lc + "&nu=" + serial);
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
            }

            dl.add(content);
            model.addAttribute("dl", dl);
            model.addAttribute("pl", pl);
        } else {
            List pl = purchaseOrder.getPurchaseOrderDeliveryList();
            if (pl.size() > 0) {
                for (int i = 0; i < pl.size(); i++) {
                    serial = purchaseOrder.getPurchaseOrderDeliveryList().get(i).getSerial();
                    lc = purchaseOrder.getPurchaseOrderDeliveryList().get(i).getLogisticsCompany();
                    try {
                        URL url = new URL("http://www.kuaidi100.com/applyurl?key=" + "f8e96a50d49ef863" + "&com=" + lc + "&nu=" + serial);
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
                        dl.add(content);
                        urlStream.close();
                    } catch (Exception e) {
                        e.printStackTrace();
                    }

                }

            }
            model.addAttribute("pl", pl);
            model.addAttribute("dl", dl);
        }


        return "/purchaseOrder/purchaseOrderView";
    }

    @RequestMapping({"/pay/alipay/{orderId}"})
    public String aliPay(HttpServletRequest request, Model model, @PathVariable String orderId) {
        PurchaseOrderPaymentDetails purchaseOrderPaymentDetails = (PurchaseOrderPaymentDetails) baseManager.getObject(PurchaseOrderPaymentDetails.class.getName(), orderId);
        String resultHtml = paymentManager.alipay(purchaseOrderPaymentDetails, purchaseOrderPaymentDetails.getMoney().floatValue());
        model.addAttribute("resultHtml", resultHtml);
        return "/order/alipay";
    }


    @RequestMapping({"/pay/alipay/callback"})
    @ResponseBody
    public String aliPayCallback(HttpServletRequest request) throws IOException {
        try {

//
//            String resultJson = "{\"transactionType\":\"PAY\",\"retryCounter\":8,\"transactionFee\":100,\"tradeSuccess\":true,\"notifyUrl\":\"http://master4.efeiyi.com/ef-website/order/pay/alipay/callback\",\"channelType\":\"WX\",\"optional\":{},\"messageDetail\":{\"transaction_id\":\"1004340401201509230968268774\",\"nonce_str\":\"iewjq1m3c20zz6zt\",\"bank_type\":\"BOB_DEBIT\",\"openid\":\"oc_M1uNonikJprGJts09m2_1iaY0\",\"fee_type\":\"CNY\",\"mch_id\":\"1243815402\",\"cash_fee\":\"100\",\"out_trade_no\":\"ienx05k3c680t1qt\",\"tradeSuccess\":true,\"appid\":\"wx7f6aa253b75466dd\",\"total_fee\":\"100\",\"trade_type\":\"NATIVE\",\"result_code\":\"SUCCESS\",\"time_end\":\"20150923164630\",\"is_subscribe\":\"Y\",\"return_code\":\"SUCCESS\"},\"transactionId\":\"iewjq1m3c20zz6zt\",\"sign\":\"df09e0f46b4d73b025f8669c7acdeb7f\",\"timestamp\":1442998500000}";

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
//                System.out.println("transactionNumber : " + transactionNumber);
//                System.out.println("purchaseOrderPaymentId : " + purchaseOrderPaymentId);
//                System.out.println("=========================test isUpdate==========================");
//            paymentManager.payCallback(purchaseOrderPaymentId, transactionNumber);


                PurchaseOrderPaymentDetails purchaseOrderPaymentDetails = (PurchaseOrderPaymentDetails) baseManager.getObject(PurchaseOrderPaymentDetails.class.getName(), purchaseOrderPaymentId);
                purchaseOrderPaymentDetails.setTransactionNumber(transactionNumber);
                //@TODO 修改订单状态
                PurchaseOrder purchaseOrder = purchaseOrderPaymentDetails.getPurchaseOrderPayment().getPurchaseOrder();
                if (purchaseOrder == null) {
//                    System.out.println("purchaseOrder is null,session problem");
                    purchaseOrder = ((PurchaseOrderPayment) baseManager.getObject(PurchaseOrderPayment.class.getName(), purchaseOrderPaymentDetails.getPurchaseOrderPayment().getId())).getPurchaseOrder();
                }
//                System.out.println(purchaseOrder.getId());

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
        for (PurchaseOrderProduct purchaseOrderProduct : purchaseOrder.getPurchaseOrderProductList()) {
            if (purchaseOrderProduct.getProductModel().getAmount() != null) {
                purchaseOrderProduct.getProductModel().setAmount(purchaseOrderProduct.getProductModel().getAmount() + purchaseOrderProduct.getPurchaseAmount());
            } else {
                ProductModel productModel = (ProductModel) baseManager.getObject(ProductModel.class.getName(), purchaseOrderProduct.getProductModel().getId());
                productModel.setAmount(productModel.getAmount() + purchaseOrderProduct.getPurchaseAmount());
            }
        }
        purchaseOrder.setOrderStatus(PurchaseOrder.ORDER_STATUS_CONSEL);
        baseManager.saveOrUpdate(PurchaseOrder.class.getName(), purchaseOrder);
        return "redirect:/order/myEfeiyi/list.do";
    }

    /**
     * 确认收货
     * @param orderId
     * @return
     */
    @RequestMapping({"/confirmGet/{orderId}"})
    public String confirmGet(@PathVariable String orderId){
        PurchaseOrder purchaseOrder =(PurchaseOrder) baseManager.getObject(PurchaseOrder.class.getName(),orderId);
        purchaseOrder.setOrderStatus(PurchaseOrder.ORDER_STATUS_UNCOMMENT);
        baseManager.saveOrUpdate(PurchaseOrder.class.getName(),purchaseOrder);
        return "redirect:/order/myEfeiyi/list.do";
    }
    /**
     * 订单删除
     */
    @RequestMapping({"/deleteOrder/{orderId}"})
    public String deleteOrder(@PathVariable String orderId) {
        PurchaseOrder purchaseOrder = (PurchaseOrder) baseManager.getObject(PurchaseOrder.class.getName(), orderId);
        for (PurchaseOrderProduct purchaseOrderProduct : purchaseOrder.getPurchaseOrderProductList()) {
            if (purchaseOrderProduct.getProductModel().getAmount() != null) {
                purchaseOrderProduct.getProductModel().setAmount(purchaseOrderProduct.getProductModel().getAmount() + purchaseOrderProduct.getPurchaseAmount());
            } else {
                ProductModel productModel = (ProductModel) baseManager.getObject(ProductModel.class.getName(), purchaseOrderProduct.getProductModel().getId());
                productModel.setAmount(productModel.getAmount() + purchaseOrderProduct.getPurchaseAmount());
            }
        }
        baseManager.saveOrUpdate(PurchaseOrder.class.getName(), purchaseOrder);
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
        String redirect_uri = "http://www2.efeiyi.com/order/pay/wxParam/" + orderId;
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

    @RequestMapping({"/easyBuy/{productModelId}"})
    public String buyImmediate(HttpServletRequest request, @PathVariable String productModelId, Model model) throws Exception {

        MyUser bigUser = AuthorizationUtil.getMyUser();
        Cart cart1 = null;
        try {
            XQuery xQuery = new XQuery("listCart_default", request);
            List<Object> list = baseManager.listObject(xQuery);
            if (list != null && list.size() > 0) {
                cart1 = (Cart) list.get(0);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        if (cart1 == null) {
            User user = new User();
            user.setId(bigUser.getId());
            cart1 = new Cart();
            cart1.setUser(user);
            cart1.setCreateDatetime(new Date());
            cart1.setCartProductList(new ArrayList<CartProduct>());
            baseManager.saveOrUpdate(Cart.class.getName(), cart1);
        }


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
        purchaseOrder.setOriginalPrice(cart.getTotalPrice());
        baseManager.saveOrUpdate(PurchaseOrder.class.getName(), purchaseOrder);

        PurchaseOrderProduct purchaseOrderProduct = new PurchaseOrderProduct();
        purchaseOrderProduct.setPurchaseOrder(purchaseOrder);
        purchaseOrderProduct.setProductModel(productModel);
        purchaseOrderProduct.setPurchasePrice(productModel.getPrice());
        purchaseOrderProduct.setPurchaseAmount(cartProduct.getAmount());
        baseManager.saveOrUpdate(PurchaseOrderProduct.class.getName(), purchaseOrderProduct);

        XQuery xQuery = new XQuery("listConsumerAddress_default", request);
        xQuery.addRequestParamToModel(model, request);
        List addressList = baseManager.listObject(xQuery);

        model.addAttribute("addressList", addressList);
        model.addAttribute("purchaseOrder", purchaseOrder);
        model.addAttribute("productModel", productModel);

        return "/purchaseOrder/purchaseOrderConfirm";
    }


    /**
     * 生成订单
     *
     * @return
     */
    @RequestMapping({"/saveOrUpdateOrder.do"})
    public String saveOrUpdateOrder(HttpServletRequest request, Model model) throws Exception {

        MyUser bigUser = AuthorizationUtil.getMyUser();
        Cart cart = null;
        try {
            XQuery xQuery = new XQuery("listCart_default", request);
            List<Object> list = baseManager.listObject(xQuery);
            if (list != null && list.size() > 0) {
                cart = (Cart) list.get(0);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        if (cart == null && bigUser.getId() != null) {
            User user = new User();
            user.setId(bigUser.getId());
            cart = new Cart();
            cart.setUser(user);
            cart.setCreateDatetime(new Date());
            cart.setCartProductList(new ArrayList<CartProduct>());
            baseManager.saveOrUpdate(Cart.class.getName(), cart);
        }


        String cartId = request.getParameter("cartId");
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
                    realCart.getCartProductList().add(cartProduct);
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

        if (cartProductList != null) {
            for (CartProduct cartProductTemp : cartProductList) {
                if (cartProductTemp.getIsChoose().equals("1")) {
                    PurchaseOrderProduct purchaseOrderProduct = new PurchaseOrderProduct();
                    purchaseOrderProduct.setProductModel(cartProductTemp.getProductModel());
                    purchaseOrderProduct.setPurchaseAmount(cartProductTemp.getAmount());
                    if (cartProductTemp.getProductModel().getPrice() == null) {
                        cartProductTemp.setProductModel((ProductModel) baseManager.getObject(ProductModel.class.getName(), cartProductTemp.getProductModel().getId()));
                    }
                    purchaseOrderProduct.setPurchasePrice(cartProductTemp.getProductModel().getPrice());
                    purchaseOrderProduct.setPurchaseOrder(purchaseOrder);
                    baseManager.saveOrUpdate(PurchaseOrderProduct.class.getName(), purchaseOrderProduct);

                    ProductModel productModel = (ProductModel) baseManager.getObject(ProductModel.class.getName(), cartProductTemp.getProductModel().getId());
                    Product product = productModel.getProduct();
                    Tenant tenant = product.getTenant();
                    tenantListTemp.add(tenant);
                }
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
        purchaseOrder.setOriginalPrice(cart.getTotalPrice());
//        //测试部分
//
//        Coupon coupon = new Coupon();
//        coupon.setId("idlany3zf4hbs5uz");
//
//        purchaseOrder.setCoupon(coupon);
        if (!HttpUtil.isPhone(request)) {
            String couponId = request.getParameter("couponId");
            Coupon coupon = (Coupon) baseManager.getObject(Coupon.class.getName(), couponId);
            purchaseOrder.setCoupon(coupon);
        }
        baseManager.saveOrUpdate(PurchaseOrder.class.getName(), purchaseOrder); //生成父订单

        //拆分订单
        if (tenantList.size() > 1) {
            for (Tenant tenantTemp : tenantList) {
                XSaveOrUpdate xSaveOrUpdateTemp = new XSaveOrUpdate("saveOrUpdatePurchaseOrder2", request);
                xSaveOrUpdateTemp.getParamMap().put("serial", autoSerialManager.nextSerial("orderSerial"));
//                xSaveOrUpdateTemp.getParamMap().put("user.id", null);
                PurchaseOrder purchaseOrderTemp = (PurchaseOrder) baseManager.saveOrUpdate(xSaveOrUpdateTemp);
                purchaseOrderTemp.setFatherPurchaseOrder(purchaseOrder);
                purchaseOrderTemp.setTenant(tenantTemp);
                BigDecimal bigDecimal = new BigDecimal(0);
                for (CartProduct cartProductTemp : cartProductList) {
                    if (cartProductTemp.getProductModel().getProduct() == null) {
                        cartProductTemp.setProductModel((ProductModel) baseManager.getObject(ProductModel.class.getName(), cartProductTemp.getProductModel().getId()));
                    }
                    if (cartProductTemp.getProductModel().getProduct().getTenant().getId().equals(tenantTemp.getId()) && cartProductTemp.getIsChoose().equals("1")) {
                        PurchaseOrderProduct purchaseOrderProduct = new PurchaseOrderProduct();
                        purchaseOrderProduct.setProductModel(cartProductTemp.getProductModel());
                        purchaseOrderProduct.setPurchaseAmount(cartProductTemp.getAmount());
                        purchaseOrderProduct.setPurchasePrice(cartProductTemp.getProductModel().getPrice());
                        bigDecimal.add(cartProductTemp.getProductModel().getPrice());
                        purchaseOrderProduct.setPurchaseOrder(purchaseOrderTemp);
                        baseManager.saveOrUpdate(PurchaseOrderProduct.class.getName(), purchaseOrderProduct);
                    }
                }

                //计算子订单的价格
                purchaseOrderTemp.setOriginalPrice(bigDecimal);
                purchaseOrderTemp.setTotal(bigDecimal);

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
        for (PurchaseOrderProduct purchaseOrderProduct : purchaseOrder.getPurchaseOrderProductList()) {
            purchaseOrderProduct.getProductModel().setAmount(purchaseOrderProduct.getProductModel().getAmount() - purchaseOrderProduct.getPurchaseAmount());
            baseManager.saveOrUpdate(ProductModel.class.getName(), purchaseOrderProduct.getProductModel());
        }
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


        //生成支付记录以及支付详情
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

        String resultPage = "";
        if (payment.equals("1")) {//支付宝
            resultPage = "redirect:/order/pay/alipay/" + purchaseOrderPaymentDetails.getId();
        } else if (payment.equals("3")) { //微信
            if (isWeiXin != null) {
                resultPage = "redirect:/order/pay/weixin/" + purchaseOrderPaymentDetails.getId();
            } else {
                resultPage = "redirect:/order/pay/weixin/native/" + purchaseOrderPaymentDetails.getId();
            }
        }
        System.out.println(resultPage);
        return resultPage;
    }


    @RequestMapping({"/pay/{orderId}"})
    public String orderPay(@PathVariable String orderId, HttpServletRequest request) {
        //从新创建支付记录详情
        PurchaseOrder purchaseOrder = (PurchaseOrder) baseManager.getObject(PurchaseOrder.class.getName(), orderId);
        String isWeiXin = request.getParameter("isWeiXin");//移动网站页面用的
        String payment = purchaseOrder.getPayWay();

        //生成支付记录以及支付详情
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
        ConsumerAddress consumerAddress = (ConsumerAddress) object;
        consumerAddress.setStatus("2");

        String hql = "select obj from " + ConsumerAddress.class.getName() + " obj where obj.status=2 and obj.consumer.id='" + consumerAddress.getConsumer().getId() + "'";
        if (baseManager.listObject(hql) != null && baseManager.listObject(hql).size() > 0) {
            ConsumerAddress consumerAddressTemp = (ConsumerAddress) (baseManager.listObject(hql).get(0));
            consumerAddressTemp.setStatus("1");
            baseManager.saveOrUpdate(ConsumerAddress.class.getName(), consumerAddressTemp);
        }
        baseManager.saveOrUpdate(ConsumerAddress.class.getName(), consumerAddress);
        return consumerAddress;
    }

    @RequestMapping({"/paysuccess/{orderId}"})
    public String paySuccess(@PathVariable String orderId, Model model) {
        PurchaseOrderPaymentDetails purchaseOrder = (PurchaseOrderPaymentDetails) baseManager.getObject(PurchaseOrderPaymentDetails.class.getName(), orderId);
        model.addAttribute("order", purchaseOrder.getPurchaseOrderPayment().getPurchaseOrder());
        return "/purchaseOrder/paySuccess";
    }


    @RequestMapping({"/orderCheck/{orderId}"})
    @ResponseBody
    public boolean checkOrderStatus(@PathVariable String orderId){

        PurchaseOrderPaymentDetails purchaseOrderPaymentDetails = (PurchaseOrderPaymentDetails)baseManager.getObject(PurchaseOrderPaymentDetails.class.getName(),orderId);
        if (purchaseOrderPaymentDetails.getPurchaseOrderPayment().getPurchaseOrder().getOrderStatus().equals("5")){
            return true;
        }else {
            return false;
        }

    }


}
