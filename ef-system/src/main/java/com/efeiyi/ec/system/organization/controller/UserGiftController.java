package com.efeiyi.ec.system.organization.controller;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.EncodeHintType;
import com.google.zxing.WriterException;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.qrcode.QRCodeWriter;
import com.ming800.core.base.controller.BaseController;
import org.apache.commons.io.FileUtils;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.Map;
import java.net.URL;

/**
 * Created by Administrator on 2015/12/22.
 */

@Controller
@RequestMapping("/userGift")
public class UserGiftController extends BaseController{

    @RequestMapping("/createQRCode.do")
    @ResponseBody
    public ResponseEntity<byte[]> createQRCode(HttpServletRequest request) throws IOException {
        String userID = request.getParameter("userID");
        String content = "http://www.efeiyi.com/subject/iibegant1zwnlnby?source=user_"+userID;
        Map<EncodeHintType, Object> hints = new HashMap<EncodeHintType, Object>();
        hints.put(EncodeHintType.MARGIN, 0);
        BitMatrix bitMatrix = null;
        try {
            bitMatrix = new QRCodeWriter().encode(content, BarcodeFormat.QR_CODE, 300, 300, hints);//二维码像素
        } catch (WriterException e) {
            e.printStackTrace();
        }
        int qRWidth = bitMatrix.getWidth();
        int qRHeight = bitMatrix.getHeight();
        BufferedImage image = new BufferedImage(qRWidth, qRHeight, BufferedImage.TYPE_INT_RGB);
        for (int x = 0; x < qRWidth; x++) {
            for (int y = 0; y < qRHeight; y++) {
                image.setRGB(x, y, bitMatrix.get(x, y) == true ?
                        new Color(157,10,15).getRGB() : Color.WHITE.getRGB());
            }
        }

        URL logoUrl = new URL("http://pro.efeiyi.com/gift/gift2.png");
        BufferedImage logo = ImageIO.read(logoUrl);
        int widthLogo = logo.getWidth(), heightLogo = logo.getHeight();
        // 计算图片放置位置
        Graphics2D g2 = image.createGraphics();
        int x = (image.getWidth() - widthLogo) / 2;
        int y = (image.getHeight() - logo.getHeight()) / 2;
        g2.drawImage(logo, x, y, widthLogo, heightLogo, null);
        g2.dispose();

        String path = this.getClass().getResource("/").getPath().toString() + "com/efeiyi/ec/system/download";
        String fileName = userID+".jpg";
        File downloadFile = new File(path+"//"+fileName);
        try {
            ImageIO.write(image, "jpg", downloadFile);
        } catch (IOException e) {
            e.printStackTrace();
        }

        HttpHeaders headers = new HttpHeaders();

        headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
        try {
            headers.setContentDispositionFormData("attachment", new String(fileName.getBytes("UTF-8"),"iso-8859-1"));
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        byte[] bytes = FileUtils.readFileToByteArray(downloadFile);
        return new ResponseEntity<byte[]>(bytes,headers, HttpStatus.OK);
    }
}
