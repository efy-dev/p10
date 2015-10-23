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
import com.efeiyi.ec.website.order.service.CartManager;
import com.efeiyi.ec.website.order.service.PaymentManager;
import com.efeiyi.ec.website.order.service.PurchaseOrderManager;
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
    private PurchaseOrderManager purchaseOrderManager;

    @Autowired
    private AutoSerialManager autoSerialManager;

    @Autowired
    private CartManager cartManager;

    @Autowired
    private PaymentManager paymentManager;


    @RequestMapping({"/easyBuy/{productModelId}"})
    public String buyImmediate(HttpServletRequest request, @PathVariable String productModelId, Model model) throws Exception {
        cartManager.initCart();
        ProductModel productModel = (ProductModel) baseManager.getObject(ProductModel.class.getName(), productModelId);
        CartProduct cartProduct = new CartProduct();
        cartProduct.setProductModel(productModel);
        String amount = request.getParameter("amount");
        cartProduct.setAmount(Integer.valueOf(amount));
        cartProduct.setIsChoose("1");
        cartProduct.setStatus("1");
        List<CartProduct> cartProductList = new ArrayList<>();
        cartProductList.add(cartProduct);
        Map<String, List> productMap = new HashMap<>();
        productMap.put(productModel.getProduct().getTenant().getId(), cartProductList);
        model.addAttribute("productMap", productMap);
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

        XQuery xQuery = new XQuery("listConsumerAddress_default", request);
        xQuery.addRequestParamToModel(model, request);
        List addressList = baseManager.listObject(xQuery);

        model.addAttribute("addressList", addressList);
        model.addAttribute("purchaseOrder", purchaseOrder);
        model.addAttribute("productModel", productModel);
        model.addAttribute("amount", amount);

        return "/purchaseOrder/purchaseOrderConfirm";
    }


    /**
     * 生成订单
     *
     * @return
     */
    @RequestMapping({"/saveOrUpdateOrder.do"})
    public String saveOrUpdateOrder(HttpServletRequest request, Model model) throws Exception {
        PurchaseOrder purchaseOrder = purchaseOrderManager.saveOrUpdatePurchaseOrder(cartManager.copyCart((Cart) request.getSession().getAttribute("cart")), model);
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
        //获取参数
        String payment = request.getParameter("payment");
        String isWeiXin = request.getParameter("isWeiXin");//移动网站页面用的
        String addressId = request.getParameter("address");
        String message = request.getParameter("message");
        //买家留言
        HashMap<String, String> messageMap = new HashMap<>();
        for (String messageTemp : message.split(";")) {
            if (messageTemp != null && !messageTemp.equals("")) {
                if (messageTemp.split(":").length >= 2)
                    messageMap.put(messageTemp.split(":")[0], messageTemp.split(":")[1]);
            }
        }
        //订单收货地址//初始化订单状态
        ConsumerAddress consumerAddress = (ConsumerAddress) baseManager.getObject(ConsumerAddress.class.getName(), addressId);
        PurchaseOrder purchaseOrder = (PurchaseOrder) baseManager.getObject(PurchaseOrder.class.getName(), orderId);
        purchaseOrder = purchaseOrderManager.confirmPurchaseOrder(purchaseOrder,consumerAddress,messageMap,payment);
        //生成支付记录以及支付详情
        PurchaseOrderPaymentDetails purchaseOrderPaymentDetails = paymentManager.initPurchaseOrderPayment(purchaseOrder);

        // 清除购物车
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


}
