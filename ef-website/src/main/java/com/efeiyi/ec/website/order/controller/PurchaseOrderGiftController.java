package com.efeiyi.ec.website.order.controller;

import com.aliyun.openservices.oss.OSSClient;
import com.aliyun.openservices.oss.model.ObjectMetadata;
import com.aliyun.openservices.oss.model.PutObjectResult;
import com.efeiyi.ec.organization.model.*;
import com.efeiyi.ec.purchase.model.PurchaseOrder;
import com.efeiyi.ec.purchase.model.PurchaseOrderDelivery;
import com.efeiyi.ec.purchase.model.PurchaseOrderGift;
import com.efeiyi.ec.website.order.service.CartManager;
import com.efeiyi.ec.website.order.service.PaymentManager;
import com.efeiyi.ec.website.order.service.PurchaseOrderManager;
import com.efeiyi.ec.website.organization.model.SmsProvider;
import com.efeiyi.ec.website.organization.model.YunPianSmsProvider;
import com.efeiyi.ec.website.base.util.AuthorizationUtil;
import com.efeiyi.ec.website.organization.service.UserManager;
import com.google.zxing.BarcodeFormat;
import com.google.zxing.EncodeHintType;
import com.google.zxing.WriterException;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.qrcode.QRCodeWriter;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.p.service.AutoSerialManager;
import com.ming800.core.util.ApplicationContextUtil;
import com.ming800.core.util.HttpUtil;
import com.ming800.core.util.StringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.swing.*;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by Administrator on 2015/11/22 0022.
 */
@Controller
public class PurchaseOrderGiftController {

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

        String requestUrl = request.getRequestURL().toString();
        String requestParam = request.getQueryString();
//        http://mall.efeiyi.com/order/giftBuy/ihykdmfn1k8httnz/1#btn-right?
//        http://mall.efeiyi.com/giftReceive/iidvpcgt3j0ab3hz?from=singlemessage&isa
        try {
            if (!HttpUtil.isPhone(request)) {
                String url = requestUrl + "?" + requestParam;
                url = URLEncoder.encode(url, "UTF-8");
                return "redirect:/toMobile.do?mobileUrl=" + url;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }


        try {
            PurchaseOrderGift purchaseOrderGift = (PurchaseOrderGift) baseManager.getObject(PurchaseOrderGift.class.getName(), orderId);
            model.addAttribute("purchaseOrder", purchaseOrderGift);
            String productName = purchaseOrderGift.getPurchaseOrderProductList().get(0).getProductModel().getProduct().getName();
            String projectName = purchaseOrderGift.getPurchaseOrderProductList().get(0).getProductModel().getProduct().getProject().getName();
            String giftMessage = purchaseOrderGift.getGiftMessage();
            String sender = purchaseOrderGift.getGiftGaverName();
            model.addAttribute("giftMessage", giftMessage);
            model.addAttribute("productName", productName);
            model.addAttribute("projectName", projectName);
            model.addAttribute("sender", sender);
            model.addAttribute("purchaseOrderGift",purchaseOrderGift);
            String lc = "";//物流公司
            String serial = "";//物流单号
            String content = "";//物流信息
            if (purchaseOrderGift.getPurchaseOrderDeliveryList() != null && !purchaseOrderGift.getPurchaseOrderDeliveryList().isEmpty()) {
                PurchaseOrderDelivery purchaseOrderDelivery = purchaseOrderGift.getPurchaseOrderDeliveryList().get(0);

                if(!"0".equals(purchaseOrderDelivery.getStatus())){

                    serial = purchaseOrderDelivery.getSerial();
                    lc = purchaseOrderDelivery.getLogisticsCompany();
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
                    model.addAttribute("content", content);
                    model.addAttribute("serial", serial);
                    model.addAttribute("lc", lc);

                }

            }
            //优先判断是否是送礼人查看当前页面
            if (AuthorizationUtil.isAuthenticated() && AuthorizationUtil.getMyUser().getId().equals(purchaseOrderGift.getUser().getId())) {
                model.addAttribute("request", "/purchaseOrder/giftView");
                return "/purchaseOrder/purchaseOrderGiftView";
            }
            if (!purchaseOrderGift.getOrderStatus().equals(PurchaseOrder.ORDER_STATUS_WPAY) && !purchaseOrderGift.getOrderStatus().equals(PurchaseOrder.ORDER_STATUS_WRGIFT)) {
                model.addAttribute("request", "/purchaseOrder/giftView");
                return "/purchaseOrder/giftView";
            }
            model.addAttribute("request", "/purchaseOrder/receiveGift");
        } catch (Exception e) {

        }
        return "/purchaseOrder/receiveGift";
    }


    private static String accessKeyId = "maTnALCpSvWjxyAy";
    private static String accessKeySecret = "0Ou6P67WhuSHESKrwJClFqCKo5BuBf";

    public String productPicture(PurchaseOrderGift purchaseOrderGift) throws Exception {
        String giftMessage = purchaseOrderGift.getGiftMessage();
        String productName = purchaseOrderGift.getPurchaseOrderProductList().get(0).getProductModel().getProduct().getName();
        String projectName = purchaseOrderGift.getPurchaseOrderProductList().get(0).getProductModel().getProduct().getProject().getName();
        String urlString = purchaseOrderGift.getPurchaseOrderProductList().get(0).getProductModel().getProductModel_url();
        String sender = purchaseOrderGift.getGiftGaverName();
        Integer amount = purchaseOrderGift.getPurchaseOrderProductList().get(0).getPurchaseAmount();
        //背景图设置
        URL backgroundUrl = new URL("http://pro.efeiyi.com/gift/background5.jpg");
        ImageIcon imgIcon = new ImageIcon(backgroundUrl);
        Image theImg = imgIcon.getImage();
        int width = theImg.getWidth(null);
        int height = theImg.getHeight(null);
        BufferedImage bimage = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
        Graphics2D g = bimage.createGraphics();
        // 设置“抗锯齿”的属性
        g.setRenderingHint(RenderingHints.KEY_ANTIALIASING, RenderingHints.VALUE_ANTIALIAS_ON);
        g.setRenderingHint(RenderingHints.KEY_TEXT_ANTIALIASING, RenderingHints.VALUE_TEXT_ANTIALIAS_ON);
        g.setColor(Color.black);
        g.drawImage(theImg, 0, 0, null);
        //设置字体、字型、字号
        g.setFont(new Font("微软雅黑", Font.BOLD, 20));
        g.setColor(Color.LIGHT_GRAY);
        if (productName.length() <= 8) {
            g.drawString(productName, 447, 203);
        } else if (8 < productName.length() && productName.length() < 17) {
            g.drawString(productName.substring(0, 8), 447, 203);
            g.drawString(productName.substring(8, productName.length()), 447, 233);
        } else {
            g.drawString(productName.substring(0, 8), 447, 203);
            g.drawString(productName.substring(8, 16), 447, 233);
            g.drawString(productName.substring(8, productName.length()), 447, 253);
        }
        g.drawString("「" + projectName + "」", 447, 313);
        g.drawString("数量："+amount+" 个", 447, 393);
        //背景图set文字显示
        g.setFont(new Font("微软雅黑", Font.BOLD, 22));
        g.setColor(Color.black);
        if (giftMessage != null) {
            if (giftMessage.length() < 15) {
                g.drawString(giftMessage, 267, 493);
            } else if (15 <= giftMessage.length() && giftMessage.length() < 30) {
                g.drawString(giftMessage.substring(0, 15), 267, 493);
                g.drawString(giftMessage.substring(15, giftMessage.length()), 267, 541);
            } else if (30 <= giftMessage.length() && giftMessage.length() < 45) {
                g.drawString(giftMessage.substring(0, 15), 267, 493);
                g.drawString(giftMessage.substring(15, 30), 267, 541);
                g.drawString(giftMessage.substring(30, giftMessage.length()), 267, 589);
            } else {
                g.drawString(giftMessage.substring(0, 15), 267, 493);
                g.drawString(giftMessage.substring(15, 30), 267, 541);
                g.drawString(giftMessage.substring(30, 45), 267, 589);
                g.drawString(giftMessage.substring(45, giftMessage.length()), 267, 637);
            }
        }
        if (sender != null && !"".equals(sender)) {
            g.drawString("——", 480, 662);
            g.drawString(sender, 540, 662);
        }
        g.dispose();
        //二维码生成
        String content = "http://mall.efeiyi.com/giftReceive/" + purchaseOrderGift.getId();
        Map<EncodeHintType, Object> hints = new HashMap<EncodeHintType, Object>();
        hints.put(EncodeHintType.MARGIN, 0);
        BitMatrix bitMatrix = null;
        try {
            bitMatrix = new QRCodeWriter().encode(content, BarcodeFormat.QR_CODE, 150, 150, hints);//二维码像素
        } catch (WriterException e) {
            e.printStackTrace();
        }
        int qRWidth = bitMatrix.getWidth();
        int qRHeight = bitMatrix.getHeight();
        BufferedImage image = new BufferedImage(qRWidth, qRHeight, BufferedImage.TYPE_INT_ARGB);
        for (int x = 0; x < qRWidth; x++) {
            for (int y = 0; y < qRHeight; y++) {
                image.setRGB(x, y, bitMatrix.get(x, y) == true ?
                        Color.BLACK.getRGB() : Color.WHITE.getRGB());
            }
        }
        //载入logo
        URL logoUrl = new URL("http://pro.efeiyi.com/gift/test1.jpg");
        BufferedImage logo = ImageIO.read(logoUrl);
        int widthLogo = logo.getWidth(), heightLogo = logo.getHeight();
        // 计算图片放置位置
        Graphics2D g2 = image.createGraphics();
        g2.setRenderingHint(RenderingHints.KEY_ANTIALIASING, RenderingHints.VALUE_ANTIALIAS_ON);
        g2.setRenderingHint(RenderingHints.KEY_TEXT_ANTIALIASING, RenderingHints.VALUE_TEXT_ANTIALIAS_ON);
        int x = (image.getWidth() - widthLogo) / 2;
        int y = (image.getHeight() - logo.getHeight()) / 2;
        g2.drawImage(logo, x, y, widthLogo, heightLogo, null);
        g2.dispose();
        String imgName = urlString.substring(urlString.lastIndexOf("/") + 1, urlString.length());
        String imgNameEncode = URLEncoder.encode(imgName, "UTF-8");
        urlString = urlString.substring(0, urlString.lastIndexOf("/") + 1) + imgNameEncode;
        URL pictureUrl = new URL("http://pro.efeiyi.com/" + urlString + "@!gift-picture-sender");
        ImageIcon giftImgIcon = new ImageIcon(pictureUrl);
        BufferedImage combined = new BufferedImage(bimage.getWidth(), bimage.getHeight(), BufferedImage.TYPE_INT_RGB);
        //图像合并
        Graphics2D g1 = combined.createGraphics();
        g1.drawImage(bimage, 0, 0, null);
        g1.drawImage(image, 47, 470, null);
        //商品图片位置
        g1.drawImage(giftImgIcon.getImage(), 37, 183, null);
        g1.dispose();
        ByteArrayOutputStream os = new ByteArrayOutputStream();
        ImageIO.write(combined, "jpg", os);
        InputStream is = new ByteArrayInputStream(os.toByteArray());
        os.close();
        ObjectMetadata meta = new ObjectMetadata();
        // 必须设置ContentLength
        meta.setContentLength(os.size());
        // 上传Object
        String url = "gift/" + purchaseOrderGift.getId() + ".jpg";
        OSSClient client = new OSSClient("http://oss-cn-beijing.aliyuncs.com", accessKeyId, accessKeySecret);
        PutObjectResult result = client.putObject("ec-efeiyi", url, is, meta);
        is.close();
        return url;
    }

    @RequestMapping({"/createGiftImage/{orderId}"})
    public String createGiftImage(@PathVariable String orderId, Model model) throws Exception {
        PurchaseOrderGift purchaseOrderGift = (PurchaseOrderGift) baseManager.getObject(PurchaseOrderGift.class.getName(), orderId);
        String url = productPicture(purchaseOrderGift);
        model.addAttribute("url", url);
        return "/purchaseOrder/giftImage";
    }


    @RequestMapping("/giftConfirm.do")
    public String confirmGift(HttpServletRequest request, Model model) {
        String purchaseOrderId = request.getParameter("purchaseOrderId");
        PurchaseOrderGift purchaseOrderGift = (PurchaseOrderGift) baseManager.getObject(PurchaseOrder.class.getName(), purchaseOrderId);
        if (!purchaseOrderGift.getOrderStatus().equals(PurchaseOrder.ORDER_STATUS_WRGIFT)) {
            return "redirect:/giftReceive/" + purchaseOrderGift.getId();
        }
        AddressProvince addressProvince = (AddressProvince) baseManager.getObject(AddressProvince.class.getName(), request.getParameter("province.id"));
        AddressCity addressCity = (AddressCity) baseManager.getObject(AddressCity.class.getName(), request.getParameter("city.id"));
        AddressDistrict addressDistrict =  (AddressDistrict) baseManager.getObject(AddressDistrict.class.getName(), request.getParameter("district.id"));
        String detail = request.getParameter("receiveDetail");
        String address = addressProvince.getName() + addressCity.getName() + addressDistrict.getName() + detail;
        String receiveName = request.getParameter("receiveName");
        String receivePhone = request.getParameter("receivePhone");
        purchaseOrderGift.setReceiverName(receiveName);
        purchaseOrderGift.setReceiverPhone(receivePhone);
        purchaseOrderGift.setPurchaseOrderAddress(address);

        ConsumerAddress consumerAddress = new ConsumerAddress();
        consumerAddress.setProvince(addressProvince);
        consumerAddress.setDistrict(addressDistrict);
        consumerAddress.setDetails(detail);
        consumerAddress.setCity(addressCity);
        purchaseOrderGift.setConsumerAddress(consumerAddress);
        consumerAddress.setConsignee(receiveName);
        baseManager.saveOrUpdate(ConsumerAddress.class.getName(), consumerAddress);

        purchaseOrderGift.setOrderStatus(PurchaseOrder.ORDER_STATUS_WRECEIVE); //订单改为未发货状态
        baseManager.saveOrUpdate(PurchaseOrderGift.class.getName(), purchaseOrderGift);
        SmsProvider smsProvider = new YunPianSmsProvider();
        String userId =  purchaseOrderGift.getUser().getId();
        //远程调用httpinvoker接口
        UserManager userManager = (UserManager) ApplicationContextUtil.getApplicationContext().getBean("userServiceProxy");
        User user = userManager.getUserByUserId(userId);
        String phoneNumber  =  user.getUsername();
        HashMap<String,String> param = null;
        smsProvider.post(phoneNumber,param,"1185009");
        model.addAttribute("purchaseOrder", purchaseOrderGift);
        model.addAttribute("request", "/purchaseOrder/giftView");
        return "/purchaseOrder/giftView";
    }

    @RequestMapping("/giftReceive/checkAddress.do")
    @ResponseBody
    public boolean checkAddressDetail(HttpServletRequest request) {
        String addressDetail = request.getParameter("addressDetail");
        if(addressDetail==null){
            return false;
        }
        int len = addressDetail.length();
        for (int i = 0; i < len; i++)
        {
            char codePoint = addressDetail.charAt(i);
            if (!StringUtil.isNotEmojiCharacter(codePoint))
            {
                return false;
            }
        }
        return true;
    }
}
