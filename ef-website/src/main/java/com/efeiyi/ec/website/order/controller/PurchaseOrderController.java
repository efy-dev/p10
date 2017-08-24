package com.efeiyi.ec.website.order.controller;

import com.efeiyi.ec.organization.model.Consumer;
import com.efeiyi.ec.organization.model.ConsumerAddress;
import com.efeiyi.ec.product.model.ProductModel;
import com.efeiyi.ec.purchase.model.*;
import com.efeiyi.ec.tenant.model.Tenant;
import com.efeiyi.ec.website.base.util.ApplicationException;
import com.efeiyi.ec.website.base.util.AuthorizationUtil;
import com.efeiyi.ec.website.order.service.*;
import com.efeiyi.ec.website.organization.service.AddressManager;
import com.efeiyi.ec.website.product.service.ProductManager;
import com.ming800.core.base.controller.BaseController;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import com.ming800.core.does.model.XSaveOrUpdate;
import com.ming800.core.p.PConst;
import com.ming800.core.p.service.AutoSerialManager;
import com.ming800.core.util.HttpUtil;
import com.ming800.core.util.StringUtil;
import net.sf.json.JSONArray;
import net.sf.json.JSONException;
import net.sf.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.InputStream;
import java.math.BigDecimal;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import static com.efeiyi.ec.purchase.model.PurchaseOrder.orderStatusMap;
import static com.efeiyi.ec.purchase.model.PurchaseOrder.paymentTypeMap;
import static com.efeiyi.ec.purchase.model.PurchaseOrderDelivery.deliveryMap;

/**
 * Created by Administrator on 2015/6/25.
 */
@Controller
@RequestMapping("/order")
public class PurchaseOrderController extends BaseController {
    @Autowired
    private BaseManager baseManager;

    @Autowired
    private PurchaseOrderManager purchaseOrderManager;

    @Autowired
    private AutoSerialManager autoSerialManager;

    @Autowired
    private CartManager cartManager;

    @Autowired
    private PaymentManager paymentManager;

    @Autowired
    private BalanceManager balanceManager;

    @Autowired
    private PostageManager postageManager;

    @Autowired
    private ProductManager productManager;


    @Autowired
    private AddressManager addressManager;


    @Autowired
    private PrepaidCardManager prepaidCardManager;


    @RequestMapping("/giftBuy/showNameStatus.do")
    @ResponseBody
    public boolean changeShowGiftStatus(HttpServletRequest request) {
        try {
            String purchaseOrderId = request.getParameter("purchaseOrderId");
            String status = request.getParameter("status");
            PurchaseOrderGift purchaseOrderGift = (PurchaseOrderGift) baseManager.getObject(PurchaseOrderGift.class.getName(), purchaseOrderId);
            purchaseOrderGift.setShowGiftNameStatus(status);
            baseManager.saveOrUpdate(PurchaseOrderGift.class.getName(), purchaseOrderGift);
            return true;
        } catch (Exception e) {
            return false;
        }
    }

    @RequestMapping({"/giftBuy/updateImg.do"})
    @ResponseBody
    public boolean updateImg(HttpServletRequest request) {
        try {

            String purchaseOrderId = request.getParameter("purchaseOrderId");
            String imageUrl = request.getParameter("imageUrl");
            PurchaseOrderGift purchaseOrderGift = (PurchaseOrderGift) baseManager.getObject(PurchaseOrderGift.class.getName(), purchaseOrderId);
            purchaseOrderGift.setGiftPictureUrl(imageUrl);
            baseManager.saveOrUpdate(PurchaseOrderGift.class.getName(), purchaseOrderGift);
            return true;
        } catch (Exception e) {
            return false;
        }
    }

    @RequestMapping("/giftBuy/showPriceStatus.do")
    @ResponseBody
    public boolean changeShowGiftPriceStatus(HttpServletRequest request) {
        try {
            String purchaseOrderId = request.getParameter("purchaseOrderId");
            String status = request.getParameter("priceStatus");
            PurchaseOrderGift purchaseOrderGift = (PurchaseOrderGift) baseManager.getObject(PurchaseOrderGift.class.getName(), purchaseOrderId);
            purchaseOrderGift.setShowGiftPriceStatus(status);
            baseManager.saveOrUpdate(PurchaseOrderGift.class.getName(), purchaseOrderGift);
            return true;
        } catch (Exception e) {
            return false;
        }
    }

    @RequestMapping("/giftBuy/saveOrUpdateGiftMessage.do")
    @ResponseBody
    public String saveOrUpdateGiftMessage(HttpServletRequest request) {
        try {
            String purchaseOrderId = request.getParameter("purchaseOrderId");
            String message = request.getParameter("giftMessage");
            message = StringUtil.filterEmoji(message).trim();
            PurchaseOrderGift purchaseOrderGift = (PurchaseOrderGift) baseManager.getObject(PurchaseOrderGift.class.getName(), purchaseOrderId);
            purchaseOrderGift.setGiftMessage(message);
            baseManager.saveOrUpdate(PurchaseOrderGift.class.getName(), purchaseOrderGift);
            return message;
        } catch (Exception e) {
            return "";
        }
    }


    @RequestMapping({"/giftBuy/{productId}/{amount}"})
    public String giftBuy(HttpServletRequest request, @PathVariable String productId, Model model, @PathVariable String amount) throws Exception {
        String requestUrl = request.getRequestURL().toString();
        String requestParam = request.getQueryString();
        try {
            if (!HttpUtil.isPhone(request)) {
                String url = requestUrl + "?" + requestParam;
                url = URLEncoder.encode(url, "UTF-8");
                return "redirect:/toMobile.do?mobileUrl=" + url;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        ProductModel productModel = (ProductModel) baseManager.getObject(ProductModel.class.getName(), productId);
        CartProduct cartProduct = new CartProduct();
        cartProduct.setProductModel(productModel);
        cartProduct.setAmount(Integer.valueOf(amount));
        cartProduct.setIsChoose("1");
        cartProduct.setStatus("1");
        List<CartProduct> cartProductList = new ArrayList<>();
        cartProductList.add(cartProduct);
        XSaveOrUpdate xSaveOrUpdate = new XSaveOrUpdate("saveOrUpdatePurchaseOrderGift", request);
        xSaveOrUpdate.getParamMap().put("serial", autoSerialManager.nextSerial("orderSerial"));
        xSaveOrUpdate.getParamMap().put("user.id", AuthorizationUtil.getMyUser().getId());
        PurchaseOrderGift purchaseOrderGift = (PurchaseOrderGift) baseManager.saveOrUpdate(xSaveOrUpdate);
        purchaseOrderGift.setTenant(productModel.getProduct().getTenant());
        purchaseOrderGift.setTotal(productModel.getPrice().multiply(new BigDecimal(Integer.parseInt(amount))));
        purchaseOrderGift.setOriginalPrice(productModel.getPrice().multiply(new BigDecimal(Integer.parseInt(amount))));
        purchaseOrderGift.setOrderType("3");
        baseManager.saveOrUpdate(PurchaseOrderGift.class.getName(), purchaseOrderGift);
        PurchaseOrderProduct purchaseOrderProduct = new PurchaseOrderProduct();
        purchaseOrderProduct.setPurchaseOrder(purchaseOrderGift);
        purchaseOrderProduct.setProductModel(productModel);
        purchaseOrderProduct.setPurchasePrice(productModel.getPrice());
        purchaseOrderProduct.setPurchaseAmount(cartProduct.getAmount());
        baseManager.saveOrUpdate(PurchaseOrderProduct.class.getName(), purchaseOrderProduct);
        XQuery xQuery = new XQuery("listConsumerAddress_default", request);
        xQuery.addRequestParamToModel(model, request);
        List addressList = baseManager.listObject(xQuery);

        String consumerId = AuthorizationUtil.getMyUser().getId();
        Consumer consumer = (Consumer) baseManager.getObject(Consumer.class.getName(), consumerId);
        if (null == consumer.getBalance()) {
            consumer.setBalance(new BigDecimal(0));
            baseManager.saveOrUpdate(Consumer.class.getName(), consumer);
        }

        model.addAttribute("addressList", addressList);
        model.addAttribute("purchaseOrder", purchaseOrderGift);
        model.addAttribute("productModel", productModel);
        model.addAttribute("purchaseOrderProduct", purchaseOrderProduct);
        model.addAttribute("amount", amount);
        model.addAttribute("request", "/giftBuy/**");
        model.addAttribute("consumer", consumer);
        return "/purchaseOrder/purchaseOrderGiftConfirm";
    }


    @RequestMapping({"/easyBuy/{productModelId}"})
    public String buyImmediate(HttpServletRequest request, @PathVariable String productModelId, Model model) throws Exception {
        String amount = request.getParameter("amount");
        ProductModel productModel = (ProductModel) baseManager.getObject(ProductModel.class.getName(), productModelId);
        String callback = PConst.NEWWEBURL + "/cart/paySuccess.do";

        return "redirect:" + PConst.NEWWEBURL + "/order/saveOrUpdateOrder2.do?productModelId=" + productModelId + "&amount=" + amount + "&price=" + productModel.getPrice() + "&orderType=1&callback=" + URLEncoder.encode(callback, "UTF-8");
    }


    @RequestMapping({"/saveOrUpdateOrder.do"})
    public String saveOrUpdateOrder(HttpServletRequest request, Model model) throws Exception {
        Cart cart = cartManager.copyCart((Cart) request.getSession().getAttribute("cart"), cartManager.getCurrentCart(request));
        PurchaseOrder purchaseOrder = purchaseOrderManager.saveOrUpdatePurchaseOrder(cart, model);
        purchaseOrder.setOrderType("1");
        String callback = request.getParameter("callback");
        purchaseOrder.setCallback(callbackFilter(callback, purchaseOrder.getId()));
        //收货地址
        XQuery xQuery = new XQuery("listConsumerAddress_default", request);
        xQuery.addRequestParamToModel(model, request);
        List<ConsumerAddress> addressList = baseManager.listObject(xQuery);
//        for(ConsumerAddress consumerAddress:addressList){
//            if(consumerAddress.getStatus().equals("2")){
//                model.addAttribute("freight",postageManager.getFreight(purchaseOrder,consumerAddress));
//            }
//        }

        String consumerId = AuthorizationUtil.getMyUser().getId();
        Consumer consumer = (Consumer) baseManager.getObject(Consumer.class.getName(), "iw1r48p7aunu1y6y");
        if (null == consumer.getBalance()) {
            consumer.setBalance(new BigDecimal(0));
            baseManager.saveOrUpdate(Consumer.class.getName(), consumer);
        }
        baseManager.saveOrUpdate(PurchaseOrder.class.getName(), purchaseOrder);

        model.addAttribute("addressList", addressList);
        model.addAttribute("purchaseOrder", purchaseOrder);
        model.addAttribute("isEasyBuy", false);
        model.addAttribute("cart", cart);
        model.addAttribute("consumer", consumer);
        request.getSession().removeAttribute("cart");
        return "/purchaseOrder/purchaseOrderConfirm";
    }


    private String callbackFilter(String callback, String id) throws Exception {
        callback = URLDecoder.decode(callback, "UTF-8");
        if (callback.contains("?")) {
            callback += "&purchaseOrderId=" + id;
        } else {
            callback += "?purchaseOrderId=" + id;
        }
        return callback;
    }


    /**
     * 创建新的商品订单
     *
     * @param request productList  商品规格列表的json对象 [{"id":"100000000006","amount":"1"}]  tenantId 店铺id，如果没有改参数说明是多商铺订单，如果有改参数说明所有商品都是属于改店铺
     *                callback 支付成功之后的回调地址
     * @return JSONObject 新生成的订单
     */
    @RequestMapping({"/createNewOrder"})
    @ResponseBody
    public JSONObject createNewOrder(HttpServletRequest request) {
        String productListStr = request.getParameter("productList");
        String tenantId = request.getParameter("tenantId");
        List<CartProduct> cartProductList = new ArrayList<>();
        String callback = request.getParameter("callback");

        JSONArray productJSONArray;
        Tenant tenant;
        try {
            productListStr = URLDecoder.decode(productListStr, "UTF-8");
            tenant = (Tenant) baseManager.getObject(Tenant.class.getName(), tenantId);
            productJSONArray = JSONArray.fromObject(productListStr);
//            @TODO 当TenantId为空的时候说明是多店铺商品
        } catch (Exception e) {
            e.printStackTrace();
            ApplicationException exception = new ApplicationException(ApplicationException.PARAM_ERROR);
            return exception.toJSONObject();
        }


        try {
            for (Object productInfoJson : productJSONArray) {
                JSONObject productInfoJSONObject = (JSONObject) productInfoJson;
                ProductModel productModel = productManager.getProductModelById(productInfoJSONObject.get("id").toString());
                CartProduct cartProduct = productManager.saveCartProduct(productModel, productInfoJSONObject.getInt("amount"));
                cartProductList.add(cartProduct);
            }
        } catch (ApplicationException ae) {
            ae.printStackTrace();
            return ae.toJSONObject();
        } catch (JSONException je) {
            ApplicationException exception = new ApplicationException(ApplicationException.PARAM_ERROR);
            return exception.toJSONObject();
        }

        PurchaseOrder purchaseOrder;
        try {
            purchaseOrder = purchaseOrderManager.saveOrUpdatePurchaseOrder(cartProductList, tenant);

        } catch (ApplicationException e) {
            e.printStackTrace();
            return e.toJSONObject();
        }

        try {
            callback = URLEncoder.encode(callback, "UTF-8");
            callback = URLDecoder.decode(callback, "UTF-8");
            if (callback.contains("?")) {
                callback += "&purchaseOrderId=" + purchaseOrder.getId();
            } else {
                callback += "?purchaseOrderId=" + purchaseOrder.getId();
            }
            purchaseOrder.setCallback(callback);
            purchaseOrderManager.saveOrUpdatePurchaseOrder(purchaseOrder);
        } catch (ApplicationException ae) {
            return ae.toJSONObject();
        } catch (Exception e) {
            return new ApplicationException(ApplicationException.PARAM_ERROR).toJSONObject();

        }

        JSONObject result = new JSONObject();
        result.put("code", "0");
        result.put("orderId", purchaseOrder.getId());
        return result;
    }


    /**
     * 确认订单状态，下一步是根据选择的支付类型进行在线支付
     *
     * @param request  invoiceName发票名 invoiceTitle发票抬头 invoiceType发票类型 paymentType 支付类型，purchaseOrderId 订单id， message JSONObject {"tenantId":"messageContent","tenantId2":"meessageContent2"} 留言，ConsumerAddressId 收货地址id
     * @param response JSONObject 已经确认的订单，由前端来判断是否
     * @return JSONObject 已经确认的订单
     */
    @RequestMapping({"/confirmOrderById"})
    @ResponseBody
    public JSONObject confirmOrderById(HttpServletRequest request, HttpServletResponse response) {
        String paymentType = request.getParameter("paymentType");
        String purchaseOrderId = request.getParameter("purchaseOrderId");
        String consumerAddressId = request.getParameter("consumerAddressId");
        String invoiceName = request.getParameter("invoiceName");
        String invoiceTitle = request.getParameter("invoiceTitle");
        String invoiceType = request.getParameter("invoiceType");
        String message = request.getParameter("message");

        PurchaseOrder purchaseOrder;
        JSONObject messageMap;
        ConsumerAddress consumerAddress;

        if (message != null && !message.equals("")) {
            messageMap = JSONObject.fromObject(message);
        } else {
            messageMap = new JSONObject();
        }

        try {
            purchaseOrder = purchaseOrderManager.getPurchaseOrderById(purchaseOrderId);
            consumerAddress = addressManager.getConsumerAddressById(consumerAddressId);
        } catch (ApplicationException ae) {
            return ae.toJSONObject();
        }

        Invoice invoice = new Invoice();
        invoice.setStatus("1");
        invoice.setName(invoiceName);
        invoice.setTitle(invoiceTitle);
        invoice.setType(invoiceType);
        invoice.setPurchaseOrder(purchaseOrder);

        try {
            purchaseOrderManager.confirmPurchaseOrder(purchaseOrder, consumerAddress, messageMap, paymentType, invoice);
        } catch (ApplicationException ae) {
            return ae.toJSONObject();
        }

        prepaidCardManager.confirmPrepaidCardRecord(purchaseOrderId);

        JSONObject result = new JSONObject();
        result.put("code", "0");
        result.put("purchaseOrderId", purchaseOrder.getId());
        return result;
    }


    /**
     * 通过订单的id获得订单
     *
     * @param request  purchaseOrderId  订单id
     * @param response PurchaseOrder 订单对象
     * @return PurchaseOrder 订单对象
     */
    @RequestMapping({"/getPurchaseOrderById"})
    @ResponseBody
    public JSONObject getPurchaseOrderById(HttpServletRequest request, HttpServletResponse response) {
        String purchaseOrderId = request.getParameter("purchaseOrderId");

        PurchaseOrder purchaseOrder;

        try {
            purchaseOrder = purchaseOrderManager.getPurchaseOrderById(purchaseOrderId);
        } catch (ApplicationException ae) {
            return ae.toJSONObject();
        }

        JSONObject result = new JSONObject();
        JSONObject purchaseOrderJSONObject = new JSONObject();
        JSONArray productListJSONArray = new JSONArray();
        for (PurchaseOrderProduct purchaseOrderProduct : purchaseOrder.getPurchaseOrderProductList()) {
            JSONObject productJSONObject = new JSONObject();
            productJSONObject.put("id", purchaseOrderProduct.getProductModel().getId());
            productJSONObject.put("productName", purchaseOrderProduct.getProductModel().getProduct().getName());
            productJSONObject.put("productModelName", purchaseOrderProduct.getProductModel().getName());
            productJSONObject.put("imageUrl", purchaseOrderProduct.getProductModel().getProductModel_url());
            productJSONObject.put("price", purchaseOrderProduct.getPurchasePrice().setScale(2, BigDecimal.ROUND_HALF_UP).toString());
            productJSONObject.put("amount", purchaseOrderProduct.getPurchaseAmount());
            productListJSONArray.add(productJSONObject);
        }

        JSONArray deliveryListJSONArray = new JSONArray();
        for (PurchaseOrderDelivery purchaseOrderDelivery : purchaseOrder.getPurchaseOrderDeliveryList()) {
            JSONObject deliveryJSONObject = new JSONObject();
            deliveryJSONObject.put("logisticsCompany", deliveryMap.get(purchaseOrderDelivery.getLogisticsCompany()));
            deliveryJSONObject.put("company", purchaseOrderDelivery.getLogisticsCompany());
            deliveryJSONObject.put("serial", purchaseOrderDelivery.getSerial());
            deliveryListJSONArray.add(deliveryJSONObject);
        }

        purchaseOrderJSONObject.put("id", purchaseOrder.getId());
        purchaseOrderJSONObject.put("serial", purchaseOrder.getSerial());
        purchaseOrderJSONObject.put("createDatetime", purchaseOrder.getCreateDatetime().getTime());
        purchaseOrderJSONObject.put("orderStatus", orderStatusMap.get(purchaseOrder.getOrderStatus()));
        purchaseOrderJSONObject.put("total", purchaseOrder.getTotal().setScale(2, BigDecimal.ROUND_HALF_UP).toString());
        purchaseOrderJSONObject.put("originalPrice", purchaseOrder.getOriginalPrice().setScale(2, BigDecimal.ROUND_HALF_UP).toString());
        purchaseOrderJSONObject.put("paymentType", paymentTypeMap.get(purchaseOrder.getPayWay()));
        purchaseOrderJSONObject.put("message", purchaseOrder.getMessage());
        purchaseOrderJSONObject.put("address", purchaseOrder.getPurchaseOrderAddress());
        purchaseOrderJSONObject.put("receiverName", purchaseOrder.getReceiverName());
        purchaseOrderJSONObject.put("receiverPhone", purchaseOrder.getReceiverPhone());
        purchaseOrderJSONObject.put("tenantName", purchaseOrder.getTenant().getName());
        result.put("code", "0");
        result.put("purchaseOrder", purchaseOrderJSONObject);
        result.put("productList", productListJSONArray);
        result.put("deliveryList", deliveryListJSONArray);


        return result;
    }


    /**
     * 通过运单编号查询物流信息
     *
     * @param request  serial 物流单号
     * @param response JSONObject 物流信息数据
     * @return JSONObject 物流信息数据
     */
    @RequestMapping({"/getDeliveryInfoBySerial"})
    @ResponseBody
    public JSONObject getDeliveryInfoBySerial(HttpServletRequest request, HttpServletResponse response) {
        String serial = request.getParameter("serial");
        String company = request.getParameter("company");
        String resultStr;
        try {
            resultStr = getLogistics(serial, company);
        } catch (Exception e) {
            return new ApplicationException(ApplicationException.INNER_ERROR).toJSONObject();
        }

        JSONObject result = new JSONObject();
        result.put("src", resultStr);

        return result;
    }


    /**
     * 获取物流信息
     *
     * @param serial
     * @param logisticsCompany
     * @return
     */
    private String getLogistics(String serial, String logisticsCompany) {
        String content = "";//物流信息
        try {
            URL url = new URL("http://www.kuaidi100.com/applyurl?key=" + "f8e96a50d49ef863" + "&com=" + logisticsCompany + "&nu=" + serial);
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
        return content;
    }


    @RequestMapping("/saveOrUpdateOrder2.do")
    public String saveOrUpdateOrder2(HttpServletRequest request, Model model) throws Exception {
        String productModelId = request.getParameter("productModelId");
        String amount = request.getParameter("amount");
        float priceFloat = Float.parseFloat(request.getParameter("price"));
        String orderType = request.getParameter("orderType");
        BigDecimal price = new BigDecimal(priceFloat);
        ProductModel productModel = (ProductModel) baseManager.getObject(ProductModel.class.getName(), productModelId);
        PurchaseOrder purchaseOrder = purchaseOrderManager.saveOrUpdatePurchaseOrder(productModel, price, Integer.parseInt(amount), model);
        String callback = request.getParameter("callback");
        purchaseOrder.setCallback(callbackFilter(callback, purchaseOrder.getId()));
        baseManager.saveOrUpdate(PurchaseOrder.class.getName(), purchaseOrder);
        if (orderType != null) {
            purchaseOrder.setOrderType(orderType);
            baseManager.saveOrUpdate(PurchaseOrder.class.getName(), purchaseOrder);
        }
        XQuery xQuery = new XQuery("listConsumerAddress_default", request);
        xQuery.addRequestParamToModel(model, request);
        List<ConsumerAddress> addressList = baseManager.listObject(xQuery);
//        for(ConsumerAddress consumerAddress:addressList){
//            if(consumerAddress.getStatus().equals("2")){
//                model.addAttribute("freight",postageManager.getFreight(purchaseOrder,consumerAddress));
//            }
//        }

        String consumerId = AuthorizationUtil.getMyUser().getId();
        Consumer consumer = (Consumer) baseManager.getObject(Consumer.class.getName(), consumerId);
        if (null == consumer.getBalance()) {
            consumer.setBalance(new BigDecimal(0));
            baseManager.saveOrUpdate(Consumer.class.getName(), consumer);
        }
        model.addAttribute("addressList", addressList);
        model.addAttribute("purchaseOrder", purchaseOrder);
        model.addAttribute("isEasyBuy", true);
        model.addAttribute("consumer", consumer);
        return "/purchaseOrder/purchaseOrderConfirm";
    }

    @RequestMapping("/saveOrUpdateOrder3.do")
    public String saveOrUpdateOrder3(HttpServletRequest request, Model model) throws Exception {
        PurchaseOrder purchaseOrder = (PurchaseOrder) baseManager.getObject(PurchaseOrder.class.getName(), request.getParameter("purchaseOrderId"));
        purchaseOrder = purchaseOrderManager.saveOrUpdatePurchaseOrder(purchaseOrder, model);
        XQuery xQuery = new XQuery("listConsumerAddress_default", request);
        xQuery.addRequestParamToModel(model, request);
        List<ConsumerAddress> addressList = baseManager.listObject(xQuery);
//        for(ConsumerAddress consumerAddress:addressList){
//            if(consumerAddress.getStatus().equals("2")){
//                model.addAttribute("freight",postageManager.getFreight(purchaseOrder,consumerAddress));
//            }
//        }

        String consumerId = AuthorizationUtil.getMyUser().getId();
        Consumer consumer = (Consumer) baseManager.getObject(Consumer.class.getName(), consumerId);
        if (null == consumer.getBalance()) {
            consumer.setBalance(new BigDecimal(0));
            baseManager.saveOrUpdate(Consumer.class.getName(), consumer);
        }

        model.addAttribute("addressList", addressList);
        model.addAttribute("purchaseOrder", purchaseOrder);
        model.addAttribute("isEasyBuy", true);
        model.addAttribute("consumer", consumer);
        return "/purchaseOrder/purchaseOrderConfirm";
    }

    @RequestMapping({"/getPurchaseOrderPrice.do"})
    @ResponseBody
    public String getPurchaseOrderPrice(HttpServletRequest request) {
        String purchaseOrderId = request.getParameter("purchaseOrderId");
        PurchaseOrder purchaseOrder = (PurchaseOrder) baseManager.getObject(PurchaseOrder.class.getName(), purchaseOrderId);
        String finalPrice = purchaseOrder.getTotal().subtract(new BigDecimal((purchaseOrder.getCoupon() != null ? purchaseOrder.getCoupon().getCouponBatch().getPrice() : 0))).toString();
        String result = "{\"totalPrice\":\"" + purchaseOrder.getTotal() + "\",\"couponPrice\":\"" + (purchaseOrder.getCoupon() != null ? purchaseOrder.getCoupon().getCouponBatch().getPrice() : 0) + "\",\"finalPrice\":\"" + finalPrice + "\"}";
        return result;
    }


    private void formatPurchaseOrderMessage(String message, HashMap<String, String> messageMap) {
        if (message != null) {
            for (String messageTemp : message.split(";")) {
                if (messageTemp != null && !messageTemp.equals("")) {
                    if (messageTemp.split(":").length >= 2)
                        messageMap.put(messageTemp.split(":")[0], messageTemp.split(":")[1]);
                }
            }
        }
    }

    @RequestMapping({"/confirm/{orderId}"})
    public String orderConfirm(@PathVariable String orderId, HttpServletRequest request) throws Exception {
        //获取参数
        request.getSession().removeAttribute("cart");
        String payment = request.getParameter("payment");
        String isWeiXin = request.getParameter("isWeiXin");//移动网站页面用的
        String addressId = request.getParameter("address");
        String message = request.getParameter("message");
        String balance = request.getParameter("balance");
        String couponId = request.getParameter("couponId");
        String freight = request.getParameter("freight");
        HashMap<String, String> messageMap = new HashMap<>();
        formatPurchaseOrderMessage(message, messageMap);

        PurchaseOrder purchaseOrder = (PurchaseOrder) baseManager.getObject(PurchaseOrder.class.getName(), orderId);
        //校验运费是否正确
//        if(addressId != null && freight != null){
//            BigDecimal returnFreight = postageManager.getFreight((PurchaseOrder)baseManager.getObject(PurchaseOrder.class.getName(),orderId),(ConsumerAddress)baseManager.getObject(ConsumerAddress.class.getName(),addressId));
//            if(postageManager.fetchFreight(freight,returnFreight)){
//                purchaseOrder.setFreight(new BigDecimal(freight));
//                purchaseOrder.setTotal(purchaseOrder.getTotal().add(new BigDecimal(freight)));
//                baseManager.saveOrUpdate(PurchaseOrder.class.getName(),purchaseOrder);
//            }
//        }
        //这里首先余额是从客户端传递过来，需要跟数据库做对比，如果余额的数目不对，就会报错，ckeck的步骤可以放到Manager里做
        if (balanceManager.checkBalance(Float.valueOf(balance))) {
            //订单收货地址//初始化订单状态
            ConsumerAddress consumerAddress = null;
            if (addressId != null) {
                consumerAddress = (ConsumerAddress) baseManager.getObject(ConsumerAddress.class.getName(), addressId);
            }
            purchaseOrder = purchaseOrderManager.confirmPurchaseOrder(purchaseOrder, consumerAddress, messageMap, payment);
            //生成支付记录以及支付详情
            PurchaseOrderPaymentDetails purchaseOrderPaymentDetails = paymentManager.initPurchaseOrderPayment(purchaseOrder, balance, couponId);
            if (PurchaseOrder.YUE.equals(purchaseOrderPaymentDetails.getPayWay())) {
                purchaseOrder.setPayWay(PurchaseOrder.YUE);
                baseManager.saveOrUpdate(PurchaseOrder.class.getName(), purchaseOrder);
            }
            cartManager.clearCart(request, purchaseOrder);
            String resultPage = "";
            if (purchaseOrderPaymentDetails.getPayWay().equals("1")) {//支付宝
                resultPage = "redirect:/order/pay/alipay/" + purchaseOrderPaymentDetails.getId();
            } else if (purchaseOrderPaymentDetails.getPayWay().equals("3")) { //微信
                if (isWeiXin != null) {
                    resultPage = "redirect:/order/pay/weixin/" + purchaseOrderPaymentDetails.getId();
                } else {
                    resultPage = "redirect:/order/pay/weixin/native/" + purchaseOrderPaymentDetails.getId();
                }
            } else if (purchaseOrderPaymentDetails.getPayWay().equals("5")) {
                resultPage = "redirect:/order/pay/balance/" + purchaseOrderPaymentDetails.getId() + "?purchaseOrderId=" + purchaseOrder.getId();
            }
            return resultPage;
        } else {
            return "";
        }
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

    @RequestMapping({"/updateAddress.do"})
    @ResponseBody
    public String updateAddress(HttpServletRequest request) throws Exception {
        XSaveOrUpdate xSaveOrUpdate = new XSaveOrUpdate("saveOrUpdateConsumerAddress", request);
        ConsumerAddress consumerAddress = (ConsumerAddress) baseManager.saveOrUpdate(xSaveOrUpdate);
        String result = "{\"consignee\":\"" + consumerAddress.getConsignee() + "\",\"province\":\"" + (consumerAddress.getProvince() != null ? consumerAddress.getProvince().getName() : 0) + "\",\"city\":\"" + (consumerAddress.getCity() != null ? consumerAddress.getCity().getName() : 0) + "\",\"district\":\"" + (consumerAddress.getDistrict() != null ? consumerAddress.getDistrict().getName() : 0) + "\",\"details\":\"" + consumerAddress.getDetails() + "\",\"phone\":\"" + consumerAddress.getPhone() + "\"}";
        return result;
    }

    @RequestMapping({"/removeAddress.do"})
    @ResponseBody
    public boolean removeAddress(HttpServletRequest request) throws Exception {
        try {
            String addressId = request.getParameter("addressId");
            baseManager.remove(ConsumerAddress.class.getName(), addressId);
            return true;
        } catch (Exception e) {
            return false;
        }
    }

    @RequestMapping({"defaultAddress.do"})
    @ResponseBody
    public boolean defaultAddress(HttpServletRequest request) throws Exception {
        String id = AuthorizationUtil.getMyUser().getId();
        String sql = "update organization_consumer_address set status = '1'where status<>0 and consumer_id='" + id + "'";
        baseManager.executeSql(null, sql, null);
        XSaveOrUpdate xSaveOrUpdate = new XSaveOrUpdate("saveOrUpdateConsumerAddress", request);
        xSaveOrUpdate.getParamMap().put("consumer_id", AuthorizationUtil.getMyUser().getId());
        baseManager.saveOrUpdate(xSaveOrUpdate);
        return true;

    }

    @RequestMapping({"/orderCheck/{orderId}"})
    @ResponseBody
    public boolean checkOrderStatus(@PathVariable String orderId) {
        PurchaseOrderPaymentDetails purchaseOrderPaymentDetails = (PurchaseOrderPaymentDetails) baseManager.getObject(PurchaseOrderPaymentDetails.class.getName(), orderId);
        if (purchaseOrderPaymentDetails.getPurchaseOrderPayment().getPurchaseOrder().getOrderStatus().equals("5")) {
            return true;
        } else {
            return false;
        }
    }

    @RequestMapping({"/checkOrderStatus.do"})
    @ResponseBody
    public String checkOrderStatus(HttpServletRequest request) {
        String purchaseOrderId = request.getParameter("purchaseOrderId");
        PurchaseOrder purchaseOrder = (PurchaseOrder) baseManager.getObject(PurchaseOrder.class.getName(), purchaseOrderId);
        return purchaseOrder.getOrderStatus();
    }


    @RequestMapping({"/addGaverName.do"})
    @ResponseBody
    public String addGaverName(HttpServletRequest request) {
        String gaverName = request.getParameter("gaverName");
        String purchaseOrderGiftId = request.getParameter("purchaseOrderGiftId");
        if (gaverName != null && gaverName != "" && purchaseOrderGiftId != null && purchaseOrderGiftId != "") {
            PurchaseOrderGift purchaseOrderGift = (PurchaseOrderGift) baseManager.getObject(PurchaseOrderGift.class.getName(), purchaseOrderGiftId);
            purchaseOrderGift.setGiftGaverName(gaverName);
            baseManager.saveOrUpdate(PurchaseOrderGift.class.getName(), purchaseOrderGift);
            return gaverName;
        } else {
            return "";
        }
    }

    @RequestMapping({"/getFreight.do"})
    @ResponseBody
    public String getFreight(HttpServletRequest request) {
        String purchaseOrderId = request.getParameter("purchaseOrderId");
        String addressId = request.getParameter("addressId");
        PurchaseOrder purchaseOrder = (PurchaseOrder) baseManager.getObject(PurchaseOrder.class.getName(), purchaseOrderId);
        ConsumerAddress consumerAddress = (ConsumerAddress) baseManager.getObject(ConsumerAddress.class.getName(), addressId);
        return postageManager.getFreight(purchaseOrder, consumerAddress).toString();
    }

}
