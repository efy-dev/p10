package com.efeiyi.ec.system.yuanqu.controller;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.EncodeHintType;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.qrcode.QRCodeWriter;
import org.apache.commons.io.FileUtils;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;

import javax.imageio.ImageIO;
import javax.swing.*;
import java.awt.*;
import java.awt.font.TextAttribute;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.net.URL;
import java.text.AttributedCharacterIterator;
import java.text.AttributedString;
import java.util.HashMap;
import java.util.Map;

public class QRCodeGenerator {

    private String qrCodeContent;

    private BufferedImage qrCode;
    private BufferedImage result;


    public QRCodeGenerator(String qrCodeContent) {
        this.qrCodeContent = qrCodeContent;
    }


    private int getQRCodeWidth() {
        return qrCode.getWidth();
    }

    private int getQRCodeHeight() {
        return qrCode.getHeight();
    }


    public QRCodeGenerator createQRCode(int width, int height) throws Exception {
        Map<EncodeHintType, Object> hints = new HashMap<>();
        hints.put(EncodeHintType.MARGIN, 0);
        BitMatrix bitMatrix;
        try {
            bitMatrix = new QRCodeWriter().encode(qrCodeContent, BarcodeFormat.QR_CODE, width, height, hints);//二维码像素
            int qRWidth = bitMatrix.getWidth();
            int qRHeight = bitMatrix.getHeight();
            this.qrCode = new BufferedImage(qRWidth, qRHeight, BufferedImage.TYPE_INT_RGB);
            for (int x = 0; x < qRWidth; x++) {
                for (int y = 0; y < qRHeight; y++) {
                    qrCode.setRGB(x, y, bitMatrix.get(x, y) ?
                            new Color(0, 0, 0).getRGB() : Color.WHITE.getRGB());
                }
            }
        } catch (Exception e) {
            throw e;
        }
        this.result = qrCode;
        return this;
    }

    public QRCodeGenerator assembleLogo(String logoUrl) throws Exception {
        if (qrCode == null) {
            throw new RuntimeException("Please call 'createQRCode(int width, int height)' first.");
        }
        URL url = new URL(logoUrl);
        BufferedImage logo = ImageIO.read(url);
        int logoX = (getQRCodeWidth() - logo.getWidth()) / 2;
        int logoY = (getQRCodeHeight() - logo.getHeight()) / 2;
        Graphics2D qrCodeG2 = qrCode.createGraphics();
        qrCodeG2.drawImage(logo, logoX, logoY, logo.getWidth(), logo.getHeight(), null);
        qrCodeG2.dispose();
        result = qrCode;
        return this;
    }

    public QRCodeGenerator assembleBackground(String backgroundUrl, int positionX, int positionY) throws Exception {
        if (qrCode == null) {
            throw new RuntimeException("Please call 'createQRCode(int width, int height)' first.");
        }
        URL url = new URL(backgroundUrl);
        BufferedImage background = ImageIO.read(url);
        Graphics2D backgroundG2 = background.createGraphics();
        backgroundG2.drawImage(qrCode, positionX, positionY, getQRCodeWidth(), getQRCodeHeight(), null);
        backgroundG2.dispose();
        result = background;
        return this;
    }

    public BufferedImage getImageResult() {
        return result;
    }

    public ResponseEntity<byte[]> getResponseEntityResult(String entityName) throws Exception {
        File imageFile = new File(entityName);
        ImageIO.write(result, "jpg", imageFile);
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
        headers.setContentDispositionFormData("attachment", entityName);
        byte[] bytes = FileUtils.readFileToByteArray(imageFile);
        return new ResponseEntity<>(bytes, headers, HttpStatus.OK);
    }


    public static void main1(String[] args) throws Exception {
        QRCodeGenerator QRCodeGenerator = new QRCodeGenerator("http://www.efeiyi.com/createWxLoginUrl/0/iugd2v0v7mbwxumv");

        BufferedImage image = QRCodeGenerator
                .createQRCode(1280, 1280).getImageResult();
//                .assembleLogo("http://ef-wiki.oss-cn-beijing.aliyuncs.com/test/logo.png")
//                .assembleBackground("http://ef-wiki.oss-cn-beijing.aliyuncs.com/test/background.jpg", 123, 92)
//                .getImageResult();
        String path = "C://Users//Administrator//Desktop";
        File downloadFileTest = new File(path);
        if (!downloadFileTest.exists()) {
            downloadFileTest.mkdir();
        }

        String fileName = System.currentTimeMillis() + ".jpg";
        File downloadFile = new File(path + "//" + fileName);
        try {
            ImageIO.write(image, "jpg", downloadFile);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }


    public static void main(String[] args) throws Exception {

        String id = "iuqmdbotfarydf33";

        String productModelId = "iuqmdbotfarydf33";

        String redirect = "1/" + productModelId;

        String url = "http://www.efeiyi.com/createWxLoginUrl/" + redirect;

        String markContent = "";
        int contentLength = 0;

//        markContent = productModel.getSerial() + "：" + productModel.getName();
        markContent = "测试";
        contentLength = markContent.length();

        QRCodeGenerator QRCodeGenerator = new QRCodeGenerator(url);
        QRCodeGenerator.createQRCode(470, 470).assembleBackground("http://m.315cheng.com/images/erweima2016120801.jpg", 175, 200);

        ImageIcon imageIcon = new ImageIcon(QRCodeGenerator.getImageResult());
        java.awt.Image img = imageIcon.getImage();
        int width = img.getWidth(null);
        int height = img.getHeight(null);
        BufferedImage bimage = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
        Graphics2D g = bimage.createGraphics();
        g.setColor(Color.BLACK);
        g.setBackground(Color.white);
        g.drawImage(img, 0, 0, null);
        AttributedString ats = new AttributedString(markContent);
        Font font = new Font("微软雅黑", Font.PLAIN, 22);
        g.setFont(font);
        /* 消除java.awt.Font字体的锯齿 */
        g.setRenderingHint(RenderingHints.KEY_ANTIALIASING, RenderingHints.VALUE_ANTIALIAS_ON);
        if (contentLength != 0) {
            ats.addAttribute(TextAttribute.FONT, font, 0, contentLength);
        }
        AttributedCharacterIterator iter = ats.getIterator();
        g.drawString(iter, 180, 698);
        g.dispose();

//        File imageFile = new File(id + ".jpg");


        String path = "C://Users//Administrator//Desktop//qrcode";
        File downloadFileTest = new File(path);
        if (!downloadFileTest.exists()) {
            downloadFileTest.mkdir();
        }

        String fileName = System.currentTimeMillis() + ".jpg";
        File downloadFile = new File(path + "//" + fileName);
        try {
            ImageIO.write(bimage, "jpg", downloadFile);
//            ImageIO.write(image, "jpg", downloadFile);
        } catch (IOException e) {
            e.printStackTrace();
        }


    }

}