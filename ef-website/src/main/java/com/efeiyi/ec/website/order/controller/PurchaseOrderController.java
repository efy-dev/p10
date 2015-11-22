package com.efeiyi.ec.website.order.controller;

import com.aliyun.openservices.oss.OSSClient;
import com.aliyun.openservices.oss.model.ObjectMetadata;
import com.aliyun.openservices.oss.model.PutObjectResult;
import com.efeiyi.ec.group.model.GroupProduct;
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
import com.google.zxing.qrcode.decoder.ErrorCorrectionLevel;
import com.google.zxing.WriterException;

import javax.imageio.ImageIO;
import javax.servlet.ServletInputStream;
import javax.servlet.http.HttpServletRequest;
import javax.swing.*;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.*;
import java.math.BigDecimal;
import java.net.URL;
import java.net.URLConnection;
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


    @RequestMapping("/giftReceive/{orderId}")
    public String receiveGift(HttpServletRequest request, @PathVariable String orderId, Model model) {
        PurchaseOrderGift purchaseOrderGift = (PurchaseOrderGift) baseManager.getObject(PurchaseOrderGift.class.getName(), orderId);
        if (purchaseOrderGift.getOrderType().equals("3") && purchaseOrderGift.getOrderStatus().equals(PurchaseOrder.ORDER_STATUS_WRGIFT)) {
            //判断是否是礼品订单 且可以被收礼
            model.addAttribute("purchaseOrder", purchaseOrderGift);
        }

        if (AuthorizationUtil.isAuthenticated() && AuthorizationUtil.getMyUser().getId().equals(purchaseOrderGift.getUser().getId())){
            model.addAttribute("order",purchaseOrderGift);
            return "/purchaseOrder/purchaseOrderGiftView";
        }
        return "/purchaseOrder/receiveGift";
    }


    private static String accessKeyId = "maTnALCpSvWjxyAy";
    private static String accessKeySecret = "0Ou6P67WhuSHESKrwJClFqCKo5BuBf";
    public String productPicture(PurchaseOrderGift purchaseOrderGift) throws Exception{
        String giftMessage = purchaseOrderGift.getGiftMessage();
        String productModelName = new String();
        BigDecimal productModelPrice = new BigDecimal("0");
        if("1".equals(purchaseOrderGift.getShowGiftNameStatus())){
            productModelName = purchaseOrderGift.getPurchaseOrderProductList().get(0).getProductModel().getName();
        }
        if("1".equals(purchaseOrderGift.getShowGiftPriceStatus())){
            productModelPrice = purchaseOrderGift.getPurchaseOrderProductList().get(0).getProductModel().getPrice();
        }
        //背景图设置
        URL backgroundUrl = new URL("http://pro.efeiyi.com/gift/background.jpg");
        ImageIcon imgIcon = new ImageIcon(backgroundUrl);
        Image theImg = imgIcon.getImage();
        int width=theImg.getWidth(null);
        int height=theImg.getHeight(null);
        BufferedImage bimage = new BufferedImage(width,height, BufferedImage.TYPE_INT_RGB);
        Graphics  g = bimage.createGraphics();
        g.setColor(Color.black);
        g.drawImage(theImg, 0, 0, null );
        //设置字体、字型、字号
        g.setFont(new Font(null,Font.LAYOUT_NO_LIMIT_CONTEXT,25));
        //背景图set文字显示
        g.drawString(giftMessage,40,180);
        g.drawString(productModelName,40,height/2+30);
        g.drawString(productModelPrice.toString(),width/2+200,height/2+30);
        g.dispose();
        //二维码生成
        String content = "http://www.efeiyi.com/order/giftReceive/"+purchaseOrderGift.getId();
        Map<EncodeHintType, Object> hints = new HashMap<EncodeHintType, Object>();
        hints.put(EncodeHintType.MARGIN, 0);
        BitMatrix bitMatrix = null;
        try {
            bitMatrix = new QRCodeWriter().encode(content,
                    BarcodeFormat.QR_CODE, 154, 154,hints);//二维码像素
        } catch (WriterException e) {
            e.printStackTrace();
        }
        int qRWidth = bitMatrix.getWidth();
        int qRHeight = bitMatrix.getHeight();
        BufferedImage image = new BufferedImage(qRWidth, qRHeight,BufferedImage.TYPE_INT_ARGB);
        for (int x = 0; x < qRWidth; x++) {
            for (int y = 0; y < qRHeight; y++) {
                image.setRGB(x, y, bitMatrix.get(x, y) == true ?
                        Color.BLACK.getRGB():Color.WHITE.getRGB());
            }
        }
        //下载礼物图
        String urlString = purchaseOrderGift.getGiftPictureUrl();
        URL pictureUrl = new URL(urlString);
        ImageIcon giftImgIcon = new ImageIcon(pictureUrl);
        BufferedImage combined = new BufferedImage(bimage.getWidth(), bimage.getHeight(), BufferedImage.TYPE_INT_RGB);
        //图像合并
        g = combined.getGraphics();
        g.drawImage(bimage, 0, 10, null);
        g.drawImage(image, 100, 750, null);
        g.drawImage(giftImgIcon.getImage(), 40, 250, null);
        //保存到本地
        ImageIO.write(combined, "JPG", new File("c://test3.jpg"));
        ByteArrayOutputStream os = new ByteArrayOutputStream();
        ImageIO.write(combined, "jpg", os);
        InputStream is = new ByteArrayInputStream(os.toByteArray());
        ObjectMetadata meta = new ObjectMetadata();
        // 必须设置ContentLength
        meta.setContentLength(os.size());
        // 上传Object
        String url = "gift/"+purchaseOrderGift.getId()+".jpg";
        OSSClient client = new OSSClient("http://oss-cn-beijing.aliyuncs.com", accessKeyId, accessKeySecret);
        PutObjectResult result = client.putObject("ec-efeiyi", url, is, meta);
        return url;
    }

    @RequestMapping({"/createGiftImage/{orderId}"})
    public String createGiftImage(@PathVariable String orderId,Model model) throws Exception{
        PurchaseOrderGift purchaseOrderGift = (PurchaseOrderGift)baseManager.getObject(PurchaseOrderGift.class.getName(),orderId);
        String url = productPicture(purchaseOrderGift);
        model.addAttribute("url",url);
        return "/purchaseOrder/giftImage";
    }


    @RequestMapping("/giftConfirm.do")
    public String confirmGift(HttpServletRequest request, Model model) {
        String purchaseOrderId = request.getParameter("purchaseOrderId");
        PurchaseOrderGift purchaseOrderGift = (PurchaseOrderGift) baseManager.getObject(PurchaseOrder.class.getName(), purchaseOrderId);
        AddressProvince addressProvince = (AddressProvince) baseManager.getObject(AddressProvince.class.getName(), request.getParameter("province.id"));
        AddressCity addressCity = (AddressCity) baseManager.getObject(AddressCity.class.getName(), request.getParameter("city.id"));
        String detail = request.getParameter("receiveDetail");
        String address = addressProvince.getName() + addressCity.getName() + detail;
        String receiveName = request.getParameter("receiveName");
        String receivePhone = request.getParameter("receivePhone");
        purchaseOrderGift.setReceiverName(receiveName);
        purchaseOrderGift.setReceiverPhone(receivePhone);
        purchaseOrderGift.setPurchaseOrderAddress(address);
        purchaseOrderGift.setOrderStatus(PurchaseOrder.ORDER_STATUS_WRECEIVE); //订单改为未发货状态
        baseManager.saveOrUpdate(PurchaseOrderGift.class.getName(), purchaseOrderGift);
        model.addAttribute("purchaseOrder", purchaseOrderGift);
        return "/purchaseOrder/giftView";
    }

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

    @RequestMapping({"giftBuy/updateImg.do"})
    @ResponseBody
    public boolean updateImg(HttpServletRequest request) {
        try {
            String imageUrl = request.getParameter("imageUrl");
            String purchaseOrderId = request.getParameter("purchaseOrderId");
            PurchaseOrderGift purchaseOrderGift = (PurchaseOrderGift) baseManager.getObject(PurchaseOrderGift.class.getName(), purchaseOrderId);
            purchaseOrderGift.setGiftPictureUrl(imageUrl);
            baseManager.saveOrUpdate(PurchaseOrderGift.class.getName(), purchaseOrderGift);
            return true;
        }catch (Exception e){
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
        baseManager.saveOrUpdate(PurchaseOrderGift.class.getName(), purchaseOrderGift);
        PurchaseOrderProduct purchaseOrderProduct = new PurchaseOrderProduct();
        purchaseOrderProduct.setPurchaseOrder(purchaseOrderGift);
        purchaseOrderProduct.setProductModel(productModel);
        purchaseOrderProduct.setPurchasePrice(productModel.getPrice().multiply(new BigDecimal(Integer.parseInt(amount))));
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

        return "/purchaseOrder/purchaseOrderGiftConfirm";
    }


    @RequestMapping({"/groupBuy/{groupProductId}/{amount}"})
    public String groupBuy(HttpServletRequest request, @PathVariable String groupProductId, Model model, @PathVariable String amount) throws Exception {
        GroupProduct groupProduct = (GroupProduct) baseManager.getObject(GroupProduct.class.getName(), groupProductId);
        ProductModel productModel = new ProductModel();
        productModel.setId(groupProduct.getProductModel().getId());
        productModel.setProduct(groupProduct.getProductModel().getProduct());
        productModel.setPrice(groupProduct.getGroupPrice());
        productModel.setAmount(groupProduct.getProductModel().getAmount());
        productModel.setName(groupProduct.getProductModel().getName());
        productModel.setProductModel_url(groupProduct.getProductModel().getProductModel_url());
        CartProduct cartProduct = new CartProduct();
        String callback = request.getParameter("callback");
        cartProduct.setProductModel(productModel);
//        String amount = request.getParameter("amount");
        cartProduct.setAmount(Integer.valueOf(amount));
        cartProduct.setIsChoose("1");
        cartProduct.setStatus("1");
        List<CartProduct> cartProductList = new ArrayList<>();
//        cartProduct.getProductModel().setPrice(groupProduct.getGroupPrice());
        cartProductList.add(cartProduct);
        Map<String, List> productMap = new HashMap<>();
        productMap.put(groupProduct.getProductModel().getProduct().getTenant().getId(), cartProductList);
        model.addAttribute("productMap", productMap);
        Cart cart = new Cart();
        cart.setTotalPrice(groupProduct.getGroupPrice().multiply(new BigDecimal(cartProduct.getAmount())));
        model.addAttribute("cart", cart);
        List<Tenant> tenantList = new ArrayList<>();
        tenantList.add(groupProduct.getProductModel().getProduct().getTenant());
        model.addAttribute("tenantList", tenantList);

        XSaveOrUpdate xSaveOrUpdate = new XSaveOrUpdate("saveOrUpdatePurchaseOrder", request);
        xSaveOrUpdate.getParamMap().put("serial", autoSerialManager.nextSerial("orderSerial"));
        xSaveOrUpdate.getParamMap().put("user.id", AuthorizationUtil.getMyUser().getId());
        PurchaseOrder purchaseOrder = (PurchaseOrder) baseManager.saveOrUpdate(xSaveOrUpdate);

        purchaseOrder.setTenant(tenantList.get(0));
        purchaseOrder.setTotal(cart.getTotalPrice());
        purchaseOrder.setOriginalPrice(cart.getTotalPrice());
        baseManager.saveOrUpdate(PurchaseOrder.class.getName(), purchaseOrder);
        //拼写回调路径purchaseOrderId,groupProductId,memberId,groupId
        String callbackTemp = callback+"?purchaseOrderId=" + purchaseOrder.getId() + "&groupProductId=" + groupProductId + "&memberId=" + (request.getParameter("memberId") != null ? request.getParameter("memberId") : "null") + "&groupId=" + (request.getParameter("groupId") != null ? request.getParameter("groupId") : "null");
        purchaseOrder.setCallback(callbackTemp);
        baseManager.saveOrUpdate(PurchaseOrder.class.getName(), purchaseOrder);

        PurchaseOrderProduct purchaseOrderProduct = new PurchaseOrderProduct();
        purchaseOrderProduct.setPurchaseOrder(purchaseOrder);
        purchaseOrderProduct.setProductModel(groupProduct.getProductModel());
        purchaseOrderProduct.setPurchasePrice(groupProduct.getGroupPrice());
        purchaseOrderProduct.setPurchaseAmount(cartProduct.getAmount());
        baseManager.saveOrUpdate(PurchaseOrderProduct.class.getName(), purchaseOrderProduct);

        XQuery xQuery = new XQuery("listConsumerAddress_default", request);
        xQuery.addRequestParamToModel(model, request);
        List addressList = baseManager.listObject(xQuery);

        model.addAttribute("addressList", addressList);
        model.addAttribute("purchaseOrder", purchaseOrder);
        model.addAttribute("productModel", productModel);
        model.addAttribute("amount", amount);
        model.addAttribute("isEasyBuy", true);
        model.addAttribute("callback", callback);
        model.addAttribute("groupProductId", groupProductId);

        return "/purchaseOrder/purchaseOrderConfirm";
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
