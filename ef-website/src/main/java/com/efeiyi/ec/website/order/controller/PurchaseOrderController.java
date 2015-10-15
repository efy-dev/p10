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

    @Autowired
    private CartManager cartManager;

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


    /*
  * 取消订单
  * */
    @RequestMapping({"/cancelOrder/{orderId}"})
    public String cancelPurchaseOrder(@PathVariable String orderId) throws Exception {
        PurchaseOrder purchaseOrder = (PurchaseOrder) baseManager.getObject(PurchaseOrder.class.getName(), orderId);
        if(purchaseOrder.getCoupon() != null){
            purchaseOrder.getCoupon().setStatus("1");
        }
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
     *
     * @param orderId
     * @return
     */
    @RequestMapping({"/confirmGet/{orderId}"})
    public String confirmGet(@PathVariable String orderId) {
        PurchaseOrder purchaseOrder = (PurchaseOrder) baseManager.getObject(PurchaseOrder.class.getName(), orderId);
        purchaseOrder.setOrderStatus(PurchaseOrder.ORDER_STATUS_UNCOMMENT);
        baseManager.saveOrUpdate(PurchaseOrder.class.getName(), purchaseOrder);
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
        model.addAttribute("amount",amount);

        return "/purchaseOrder/purchaseOrderConfirm";
    }


    /**
     * 生成订单
     *
     * @return
     */
    @RequestMapping({"/saveOrUpdateOrder.do"})
    public String saveOrUpdateOrder(HttpServletRequest request, Model model) throws Exception {
        Cart cart = cartManager.initCart();
        String cartId = request.getParameter("cartId");
        if (cartId == null || cartId.equals("")) {
            Cart sessionCart = (Cart) request.getSession().getAttribute("cart");
            cart.setTotalPrice(cart.getTotalPrice() != null ? cart.getTotalPrice().add(sessionCart.getTotalPrice()) : sessionCart.getTotalPrice());
            baseManager.saveOrUpdate(Cart.class.getName(), cart);
            if (sessionCart.getCartProductList() != null && sessionCart.getCartProductList().size() > 0) {
                for (CartProduct cartProduct : sessionCart.getCartProductList()) {
                    cartProduct.setCart(cart);
                    cart.getCartProductList().add(cartProduct);
                    baseManager.saveOrUpdate(CartProduct.class.getName(), cartProduct);
                }
            }
            request.getSession().removeAttribute("cart");
        }
        //得到店铺的信息
        LinkedHashSet<Tenant> tenantSet = new LinkedHashSet<>();
        HashMap<String, List> productMap = new HashMap<>();
        XSaveOrUpdate xSaveOrUpdate = new XSaveOrUpdate("saveOrUpdatePurchaseOrder", request);
        List<CartProduct> cartProductList = cart.getCartProductList();
        //初始化订单
        xSaveOrUpdate.getParamMap().put("serial", autoSerialManager.nextSerial("orderSerial"));
        xSaveOrUpdate.getParamMap().put("user.id", AuthorizationUtil.getMyUser().getId());
        PurchaseOrder purchaseOrder = (PurchaseOrder) baseManager.saveOrUpdate(xSaveOrUpdate);

        for (CartProduct cartProductTemp : cartProductList) {
            if (cartProductTemp.getIsChoose().equals("1")) {
                cartProductTemp.setProductModel((ProductModel) baseManager.getObject(ProductModel.class.getName(), cartProductTemp.getProductModel().getId()));
                PurchaseOrderProduct purchaseOrderProduct = new PurchaseOrderProduct(purchaseOrder, cartProductTemp.getProductModel(), cartProductTemp.getAmount(), cartProductTemp.getProductModel().getPrice());
                baseManager.saveOrUpdate(PurchaseOrderProduct.class.getName(), purchaseOrderProduct);
                Tenant tenant = cartProductTemp.getProductModel().getProduct().getTenant();
                tenantSet.add(tenant);
                if (productMap.get(tenant.getId()) != null) {
                    productMap.get(tenant.getId()).add(cartProductTemp);
                } else {
                    List productList = new ArrayList();
                    productList.add(cartProductTemp);
                    productMap.put(tenant.getId(), productList);
                }
            }
        }
        purchaseOrder.setTotal(cart.getTotalPrice());
        purchaseOrder.setOriginalPrice(cart.getTotalPrice());
        if (!HttpUtil.isPhone(request)) {
            String couponId = request.getParameter("couponId");
            Coupon coupon = (Coupon) baseManager.getObject(Coupon.class.getName(), couponId);
            purchaseOrder.setCoupon(coupon);
        }
        baseManager.saveOrUpdate(PurchaseOrder.class.getName(), purchaseOrder); //更新订单

        //拆分订单
        if (tenantSet.size() > 1) {
            for (Tenant tenantTemp : tenantSet) {
                XSaveOrUpdate xSaveOrUpdateTemp = new XSaveOrUpdate("saveOrUpdatePurchaseOrder", request);
                xSaveOrUpdateTemp.getParamMap().put("serial", autoSerialManager.nextSerial("orderSerial"));
                xSaveOrUpdateTemp.getParamMap().put("user.id", AuthorizationUtil.getMyUser().getId());
                PurchaseOrder purchaseOrderTemp = (PurchaseOrder) baseManager.saveOrUpdate(xSaveOrUpdateTemp);
                purchaseOrderTemp.setFatherPurchaseOrder(purchaseOrder);
                purchaseOrderTemp.setTenant(tenantTemp);
//                BigDecimal bigDecimal = new BigDecimal(0);
                float resultPrice = 0f;
//                bigDecimal = bigDecimal.setScale(2, BigDecimal.ROUND_HALF_UP);
                for (CartProduct cartProductTemp : cartProductList) {
                    cartProductTemp.setProductModel((ProductModel) baseManager.getObject(ProductModel.class.getName(), cartProductTemp.getProductModel().getId()));
                    if (cartProductTemp.getProductModel().getProduct().getTenant().getId().equals(tenantTemp.getId()) && cartProductTemp.getIsChoose().equals("1")) {
                        PurchaseOrderProduct purchaseOrderProduct = new PurchaseOrderProduct(purchaseOrderTemp,cartProductTemp.getProductModel(),cartProductTemp.getAmount(),cartProductTemp.getProductModel().getPrice());
                        resultPrice+=cartProductTemp.getProductModel().getPrice().floatValue()*cartProductTemp.getAmount();
                        baseManager.saveOrUpdate(PurchaseOrderProduct.class.getName(), purchaseOrderProduct);
                    }
                }
                //计算子订单的价格
                BigDecimal bigDecimal = new BigDecimal(resultPrice);
                bigDecimal = bigDecimal.setScale(2, BigDecimal.ROUND_HALF_UP);
                purchaseOrderTemp.setOriginalPrice(bigDecimal);
                purchaseOrderTemp.setTotal(bigDecimal);
                baseManager.saveOrUpdate(PurchaseOrder.class.getName(), purchaseOrderTemp); //更新子订单
            }
        } else {
            purchaseOrder.setTenant(tenantSet.iterator().next());
            baseManager.saveOrUpdate(PurchaseOrder.class.getName(), purchaseOrder);
        }
        //收货地址
        XQuery xQuery = new XQuery("listConsumerAddress_default", request);
        xQuery.addRequestParamToModel(model, request);
        List addressList = baseManager.listObject(xQuery);

        model.addAttribute("productMap", productMap);
        model.addAttribute("cart", cart);
        model.addAttribute("addressList", addressList);
        model.addAttribute("purchaseOrder", purchaseOrder);
        model.addAttribute("tenantList", tenantSet);

        return "/purchaseOrder/purchaseOrderConfirm";
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
