package com.efeiyi.ec.website.order.controller;

import com.aliyun.openservices.oss.OSSClient;
import com.aliyun.openservices.oss.model.ObjectMetadata;
import com.aliyun.openservices.oss.model.PutObjectResult;
import com.efeiyi.ec.organization.model.AddressCity;
import com.efeiyi.ec.organization.model.AddressProvince;
import com.efeiyi.ec.purchase.model.PurchaseOrder;
import com.efeiyi.ec.purchase.model.PurchaseOrderGift;
import com.efeiyi.ec.website.order.service.CartManager;
import com.efeiyi.ec.website.order.service.PaymentManager;
import com.efeiyi.ec.website.order.service.PurchaseOrderManager;
import com.efeiyi.ec.website.organization.util.AuthorizationUtil;
import com.google.zxing.BarcodeFormat;
import com.google.zxing.EncodeHintType;
import com.google.zxing.WriterException;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.qrcode.QRCodeWriter;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.p.service.AutoSerialManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.swing.*;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.InputStream;
import java.math.BigDecimal;
import java.net.URL;
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
        PurchaseOrderGift purchaseOrderGift = (PurchaseOrderGift) baseManager.getObject(PurchaseOrderGift.class.getName(), orderId);
        if (purchaseOrderGift.getOrderType().equals("3") && purchaseOrderGift.getOrderStatus().equals(PurchaseOrder.ORDER_STATUS_WRGIFT)) {
            //判断是否是礼品订单 且可以被收礼
            model.addAttribute("purchaseOrder", purchaseOrderGift);
        }

        //优先判断是否是送礼人查看当前页面
        if (AuthorizationUtil.isAuthenticated() && AuthorizationUtil.getMyUser().getId().equals(purchaseOrderGift.getUser().getId())) {
            model.addAttribute("order", purchaseOrderGift);
            return "/purchaseOrder/purchaseOrderGiftView";
        }
        if (purchaseOrderGift.getOrderStatus().equals(PurchaseOrder.ORDER_STATUS_WRECEIVE)){
            model.addAttribute("purchaseOrder", purchaseOrderGift);
            return "/purchaseOrder/giftView";
        }

        return "/purchaseOrder/receiveGift";
    }


    private static String accessKeyId = "maTnALCpSvWjxyAy";
    private static String accessKeySecret = "0Ou6P67WhuSHESKrwJClFqCKo5BuBf";

    public String productPicture(PurchaseOrderGift purchaseOrderGift) throws Exception {
        String giftMessage = purchaseOrderGift.getGiftMessage();
        String productModelName = new String();
        BigDecimal productModelPrice = new BigDecimal("0");
        if ("1".equals(purchaseOrderGift.getShowGiftNameStatus())) {
            productModelName = purchaseOrderGift.getPurchaseOrderProductList().get(0).getProductModel().getName();
        }
        if ("1".equals(purchaseOrderGift.getShowGiftPriceStatus())) {
            productModelPrice = purchaseOrderGift.getPurchaseOrderProductList().get(0).getProductModel().getPrice();
        }
        //背景图设置
        URL backgroundUrl = new URL("http://pro.efeiyi.com/gift/background.jpg");
        ImageIcon imgIcon = new ImageIcon(backgroundUrl);
        Image theImg = imgIcon.getImage();
        int width = theImg.getWidth(null);
        int height = theImg.getHeight(null);
        BufferedImage bimage = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
        Graphics2D g = bimage.createGraphics();
        g.setColor(Color.black);
        g.drawImage(theImg, 0, 0, null);
        //设置字体、字型、字号
        g.setFont(new Font(null, Font.LAYOUT_NO_LIMIT_CONTEXT, 25));
        //背景图set文字显示
        if (giftMessage != null) {
            g.drawString(giftMessage, 40, 180);
        }
        g.drawString(productModelName, 40, height / 2 + 30);
        g.drawString((productModelPrice.intValue() != 0 ? productModelPrice.toString() : ""), width / 2 + 200, height / 2 + 30);
        g.dispose();
        //二维码生成
        String content = "http://www.efeiyi.com/giftReceive/" + purchaseOrderGift.getId();
        Map<EncodeHintType, Object> hints = new HashMap<EncodeHintType, Object>();
        hints.put(EncodeHintType.MARGIN, 0);
        BitMatrix bitMatrix = null;
        try {
            bitMatrix = new QRCodeWriter().encode(content,
                    BarcodeFormat.QR_CODE, 154, 154, hints);//二维码像素
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
        //下载礼物图
        String urlString = purchaseOrderGift.getGiftPictureUrl();
        URL pictureUrl = new URL(urlString);
        ImageIcon giftImgIcon = new ImageIcon(pictureUrl);
        BufferedImage combined = new BufferedImage(bimage.getWidth(), bimage.getHeight(), BufferedImage.TYPE_INT_RGB);
        //图像合并
        g = combined.createGraphics();
        g.drawImage(bimage, 0, 10, null);
        g.drawImage(image, 100, 750, null);
        g.drawImage(giftImgIcon.getImage(), 40, 250, null);
        //保存到本地
        ByteArrayOutputStream os = new ByteArrayOutputStream();
        ImageIO.write(combined, "jpg", os);
        InputStream is = new ByteArrayInputStream(os.toByteArray());
        ObjectMetadata meta = new ObjectMetadata();
        // 必须设置ContentLength
        meta.setContentLength(os.size());
        // 上传Object
        String url = "gift/" + purchaseOrderGift.getId() + ".jpg";
        OSSClient client = new OSSClient("http://oss-cn-beijing.aliyuncs.com", accessKeyId, accessKeySecret);
        PutObjectResult result = client.putObject("ec-efeiyi", url, is, meta);
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


}
