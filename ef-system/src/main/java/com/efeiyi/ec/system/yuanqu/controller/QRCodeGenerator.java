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
import java.awt.*;
import java.awt.font.TextAttribute;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.net.URL;
import java.text.AttributedCharacterIterator;
import java.text.AttributedString;
import java.util.ArrayList;
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

    public QRCodeGenerator assembleText(String fontName, int fontSize, int fontStyle, String content, int positionX, int positionY) {
        if (qrCode == null) {
            throw new RuntimeException("Please call 'createQRCode(int width, int height)' first.");
        }
//        首先创造文字
        Font font = new Font(fontName, fontStyle, fontSize);
        AttributedString contentString = new AttributedString(content);
        contentString.addAttribute(TextAttribute.FONT, font, 0, content.length());
        AttributedCharacterIterator contentStringIterator = contentString.getIterator();
        Graphics2D resultG2D = result.createGraphics();
        resultG2D.setColor(Color.black);
        resultG2D.setBackground(Color.white);
        resultG2D.setRenderingHint(RenderingHints.KEY_ANTIALIASING, RenderingHints.VALUE_ANTIALIAS_ON);
        resultG2D.drawString(contentStringIterator, positionX, positionY);
        resultG2D.dispose();
        return this;
    }

    public QRCodeGenerator assembleText(String fontName, int fontSize, String content, int positionX, int positionY) {
        return assembleText(fontName, fontSize, Font.PLAIN, content, positionX, positionY);
    }

    public void createLocalFile(String path, String fileName) {
        if (qrCode == null) {
            throw new RuntimeException("Please call 'createQRCode(int width, int height)' first.");
        }
        File downloadFileTest = new File(path);
        if (!downloadFileTest.exists()) {
            downloadFileTest.mkdir();
        }

        File downloadFile = new File(path + "//" + fileName);
        try {
            ImageIO.write(result, "jpg", downloadFile);
        } catch (IOException e) {
            e.printStackTrace();
        }
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


    public static void main(String[] args) throws Exception {
        QRCodeGenerator codeGenerator = new QRCodeGenerator("http://www.efeiyi.com/createWxLoginUrl/1/" + 123345);
        String path = "C://Users//Administrator//Desktop//qrcode";
        String fileName = 123456 + ".jpg";
        String productName = "这是测试使用的名称abcdefg";
        java.util.List<String> productNameArray = new ArrayList<>();

        while (productName.length() > 8) {
            String nameTemp = productName.substring(0, 8);
            productNameArray.add(nameTemp);
            productName = productName.substring(8, productName.length());
            if (productName.length() <= 8) {
                productNameArray.add(productName);
            }
        }

        codeGenerator
                .createQRCode(250, 250)
                .assembleBackground("http://ef-wiki.oss-cn-beijing.aliyuncs.com/picture/newqrcode.jpg", 572, 78)
                .assembleText("宋体", 32, "1234567", 272, 105);

        int height = 147;
        if (!productNameArray.isEmpty()) {
            for (String pn : productNameArray) {
                codeGenerator.assembleText("宋体", 32, pn, 272, height);
                height += 42;
            }
        } else {
            codeGenerator.assembleText("宋体", 32, productName, 272, height);
        }

        codeGenerator
                .assembleText("等线", 100, Font.PLAIN, "79", 143, 368)
                .createLocalFile(path, fileName);
    }

}