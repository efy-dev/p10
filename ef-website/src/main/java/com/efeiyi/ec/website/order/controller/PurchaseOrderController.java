package com.efeiyi.ec.website.order.controller;

import com.aliyun.openservices.oss.OSSClient;
import com.aliyun.openservices.oss.model.ObjectMetadata;
import com.aliyun.openservices.oss.model.PutObjectResult;
import com.efeiyi.ec.organization.model.*;
import com.efeiyi.ec.product.model.Product;
import com.efeiyi.ec.product.model.ProductModel;
import com.efeiyi.ec.purchase.model.Cart;
import com.efeiyi.ec.purchase.model.*;
import com.efeiyi.ec.purchase.model.CartProduct;
import com.efeiyi.ec.purchase.model.PurchaseOrder;
import com.efeiyi.ec.purchase.model.PurchaseOrderProduct;
import com.efeiyi.ec.tenant.model.Tenant;
import com.efeiyi.ec.website.order.service.CartManager;
import com.efeiyi.ec.website.order.service.PaymentManager;
import com.efeiyi.ec.website.order.service.PurchaseOrderManager;
import com.efeiyi.ec.website.order.service.WxPayConfig;
import com.efeiyi.ec.website.organization.util.AuthorizationUtil;
import com.google.zxing.BarcodeFormat;
import com.google.zxing.EncodeHintType;
import com.google.zxing.WriterException;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.qrcode.QRCodeWriter;
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

import javax.imageio.ImageIO;
import javax.servlet.ServletInputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.swing.*;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.*;
import java.math.BigDecimal;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.*;
import java.util.List;

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


    @RequestMapping("/giftBuy/showNameStatus.do")
    @ResponseBody
    public boolean changeShowGiftNameStatus(HttpServletRequest request) {
        try {
            String purchaseOrderId = request.getParameter("purchaseOrderId");
            String status = request.getParameter("nameStatus");
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
            String imageUrl = request.getParameter("imageUrl");
            String purchaseOrderId = request.getParameter("purchaseOrderId");
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
//        http://www.efeiyi.com/order/giftBuy/ihykdmfn1k8httnz/1#btn-right?
//        http://www.efeiyi.com/giftReceive/iidvpcgt3j0ab3hz?from=singlemessage&isa
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
        model.addAttribute("addressList", addressList);
        model.addAttribute("purchaseOrder", purchaseOrderGift);
        model.addAttribute("productModel", productModel);
        model.addAttribute("purchaseOrderProduct", purchaseOrderProduct);
        model.addAttribute("amount", amount);
        model.addAttribute("request", "/giftBuy/**");
        return "/purchaseOrder/purchaseOrderGiftConfirm";
    }


    @RequestMapping({"/easyBuy/{productModelId}"})
    public String buyImmediate(HttpServletRequest request, @PathVariable String productModelId, Model model) throws Exception {
        cartManager.fetchCart();
        ProductModel productModel = (ProductModel) baseManager.getObject(ProductModel.class.getName(), productModelId);
        CartProduct cartProduct = new CartProduct();
        cartProduct.setProductModel(productModel);
        String amount = request.getParameter("amount");
        try {
            cartProduct.setAmount(Integer.valueOf(amount));
        } catch (Exception e) {
            cartProduct.setAmount(1);
        }
        cartProduct.setIsChoose("1");
        cartProduct.setStatus("1");
        Cart cart = new Cart();
        cart.setTotalPrice(productModel.getPrice().multiply(new BigDecimal(cartProduct.getAmount())));
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
        List<PurchaseOrderProduct> purchaseOrderProductList = new ArrayList<>();
        purchaseOrderProductList.add(purchaseOrderProduct);
        Map<String, List> productMap = new HashMap<>();
        productMap.put(productModel.getProduct().getTenant().getId(), purchaseOrderProductList);
        model.addAttribute("productMap", productMap);

        XQuery xQuery = new XQuery("listConsumerAddress_default", request);
        xQuery.addRequestParamToModel(model, request);
        List addressList = baseManager.listObject(xQuery);

        model.addAttribute("addressList", addressList);
        model.addAttribute("purchaseOrder", purchaseOrder);
        model.addAttribute("productModel", productModel);
        model.addAttribute("amount", amount);
        model.addAttribute("isEasyBuy", true);

        return "/purchaseOrder/purchaseOrderConfirm";
    }


    /**
     * 生成订单
     *
     * @return
     */
    @RequestMapping({"/saveOrUpdateOrder.do"})
    public String saveOrUpdateOrder(HttpServletRequest request, Model model) throws Exception {
        Cart cart = cartManager.copyCart((Cart) request.getSession().getAttribute("cart"), cartManager.getCurrentCart(request));
        PurchaseOrder purchaseOrder = purchaseOrderManager.saveOrUpdatePurchaseOrder(cart, model);
        String callback = request.getParameter("callback");
        if (callback != null) {
            callback = URLDecoder.decode(callback, "UTF-8");
            if (callback.contains("?")) {
                callback += "&purchaseOrderId=" + purchaseOrder.getId();
            } else {
                callback += "?purchaseOrderId=" + purchaseOrder.getId();
            }
            purchaseOrder.setCallback(callback);
            baseManager.saveOrUpdate(PurchaseOrder.class.getName(), purchaseOrder);
        }
        //收货地址
        XQuery xQuery = new XQuery("listConsumerAddress_default", request);
        xQuery.addRequestParamToModel(model, request);
        List addressList = baseManager.listObject(xQuery);
        model.addAttribute("addressList", addressList);
        model.addAttribute("purchaseOrder", purchaseOrder);
        model.addAttribute("isEasyBuy", false);
        model.addAttribute("cart", cart);
        request.getSession().removeAttribute("cart");
        return "/purchaseOrder/purchaseOrderConfirm";
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
        if (callback != null) {
            callback = URLDecoder.decode(callback, "UTF-8");
            if (callback.contains("?")) {
                callback += "&purchaseOrderId=" + purchaseOrder.getId();
            } else {
                callback += "?purchaseOrderId=" + purchaseOrder.getId();
            }
            purchaseOrder.setCallback(callback);
            baseManager.saveOrUpdate(PurchaseOrder.class.getName(), purchaseOrder);
        }
        if (orderType != null) {
            purchaseOrder.setOrderType(orderType);
            baseManager.saveOrUpdate(PurchaseOrder.class.getName(), purchaseOrder);
        }
        XQuery xQuery = new XQuery("listConsumerAddress_default", request);
        xQuery.addRequestParamToModel(model, request);
        List addressList = baseManager.listObject(xQuery);
        model.addAttribute("addressList", addressList);
        model.addAttribute("purchaseOrder", purchaseOrder);
        model.addAttribute("isEasyBuy", true);
        return "/purchaseOrder/purchaseOrderConfirm";
    }

    @RequestMapping("/saveOrUpdateOrder3.do")
    public String saveOrUpdateOrder3(HttpServletRequest request, Model model) throws Exception {
        PurchaseOrder purchaseOrder = (PurchaseOrder) baseManager.getObject(PurchaseOrder.class.getName(), request.getParameter("purchaseOrderId"));
        purchaseOrder = purchaseOrderManager.saveOrUpdatePurchaseOrder(purchaseOrder, model);
        XQuery xQuery = new XQuery("listConsumerAddress_default", request);
        xQuery.addRequestParamToModel(model, request);
        List addressList = baseManager.listObject(xQuery);
        model.addAttribute("addressList", addressList);
        model.addAttribute("purchaseOrder", purchaseOrder);
        model.addAttribute("isEasyBuy", true);
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


    @RequestMapping({"/confirm/{orderId}"})
    public String orderConfirm(@PathVariable String orderId, HttpServletRequest request) throws Exception {
        //获取参数
        if (request.getSession().getAttribute("cart") != null) {
            request.getSession().removeAttribute("cart");
        }
        String payment = request.getParameter("payment");
        String isWeiXin = request.getParameter("isWeiXin");//移动网站页面用的
        String addressId = request.getParameter("address");
        String message = request.getParameter("message");
        //买家留言
        HashMap<String, String> messageMap = new HashMap<>();
        if (message != null) {
            for (String messageTemp : message.split(";")) {
                if (messageTemp != null && !messageTemp.equals("")) {
                    if (messageTemp.split(":").length >= 2)
                        messageMap.put(messageTemp.split(":")[0], messageTemp.split(":")[1]);
                }
            }
        }
        //订单收货地址//初始化订单状态
        ConsumerAddress consumerAddress = null;
        if (addressId != null) {
            consumerAddress = (ConsumerAddress) baseManager.getObject(ConsumerAddress.class.getName(), addressId);
        }
        PurchaseOrder purchaseOrder = (PurchaseOrder) baseManager.getObject(PurchaseOrder.class.getName(), orderId);
        purchaseOrder = purchaseOrderManager.confirmPurchaseOrder(purchaseOrder, consumerAddress, messageMap, payment);
        //生成支付记录以及支付详情
        PurchaseOrderPaymentDetails purchaseOrderPaymentDetails = paymentManager.initPurchaseOrderPayment(purchaseOrder);

        // 清除购物车
        XQuery xQuery = new XQuery("listCart_default", request);
        List<Object> list = baseManager.listObject(xQuery);
        Cart realCart = (Cart) list.get(0);
        realCart.setTotalPrice(new BigDecimal(0));
        baseManager.saveOrUpdate(Cart.class.getName(), realCart);
        for (CartProduct cartProductTemp : realCart.getCartProductList()) {
            for (PurchaseOrderProduct purchaseOrderProduct : purchaseOrder.getPurchaseOrderProductList()) {
                if (cartProductTemp.getProductModel().getId().equals(purchaseOrderProduct.getProductModel().getId())) {
                    baseManager.remove(CartProduct.class.getName(), cartProductTemp.getId());
                    break;
                }
            }
//            if (cartProductTemp.getIsChoose().equals("1")) {
//            }
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
        return resultPage;
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

}
