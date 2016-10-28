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
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.net.URL;
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


    public static void main(String[] args) throws Exception {
        QRCodeGenerator QRCodeGenerator = new QRCodeGenerator("https://open.weixin.qq.com/connect/oauth2/authorize?appid=wx7f6aa253b75466dd&redirect_uri=http%3A%2F%2Fmall.efeiyi.com%2Fwl&response_type=code&scope=snsapi_userinfo&state=0%2Fiu0sc2bu318fkbta#wechat_redirect");

        BufferedImage image = QRCodeGenerator
                .createQRCode(582, 582)
                .assembleLogo("http://ef-wiki.oss-cn-beijing.aliyuncs.com/test/logo.png")
                .assembleBackground("http://ef-wiki.oss-cn-beijing.aliyuncs.com/test/background.jpg", 123, 92)
                .getImageResult();
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

}