package com.efeiyi.ec.system.yuanqu.controller;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.EncodeHintType;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.qrcode.QRCodeWriter;

import javax.imageio.ImageIO;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;

public class QrcodeGenerator {

    private String qrcodeContent;

    private BufferedImage qrcode;
    private BufferedImage result;


    private QrcodeGenerator(String qrcodeContent) {
        this.qrcodeContent = qrcodeContent;
    }


    private int getQrcodeWidth() {
        return qrcode.getWidth();
    }

    private int getQrcodeHeight() {
        return qrcode.getHeight();
    }


    public QrcodeGenerator createQrcode(int width, int height) throws Exception {
        Map<EncodeHintType, Object> hints = new HashMap<>();
        hints.put(EncodeHintType.MARGIN, 0);
        BitMatrix bitMatrix;
        try {
            bitMatrix = new QRCodeWriter().encode(qrcodeContent, BarcodeFormat.QR_CODE, width, height, hints);//二维码像素
            int qRWidth = bitMatrix.getWidth();
            int qRHeight = bitMatrix.getHeight();
            this.qrcode = new BufferedImage(qRWidth, qRHeight, BufferedImage.TYPE_INT_RGB);
            for (int x = 0; x < qRWidth; x++) {
                for (int y = 0; y < qRHeight; y++) {
                    qrcode.setRGB(x, y, bitMatrix.get(x, y) ?
                            new Color(0, 0, 0).getRGB() : Color.WHITE.getRGB());
                }
            }
        } catch (Exception e) {
            throw e;
        }
        this.result = qrcode;
        return this;
    }

    public QrcodeGenerator assembleLogo(String logoUrl) throws Exception {
        if (qrcode == null) {
            throw new RuntimeException("Please call 'createQrcode(int width, int height)' first.");
        }
        URL url = new URL(logoUrl);
        BufferedImage logo = ImageIO.read(url);
        int logoX = (getQrcodeWidth() - logo.getWidth()) / 2;
        int logoY = (getQrcodeHeight() - logo.getHeight()) / 2;
        Graphics2D qrcodeG2 = qrcode.createGraphics();
        qrcodeG2.drawImage(logo, logoX, logoY, logo.getWidth(), logo.getHeight(), null);
        qrcodeG2.dispose();
        result = qrcode;
        return this;
    }

    public QrcodeGenerator assembleBackground(String backgroundUrl, int positionX, int positionY) throws Exception {
        if (qrcode == null) {
            throw new RuntimeException("Please call 'createQrcode(int width, int height)' first.");
        }
        URL url = new URL(backgroundUrl);
        BufferedImage background = ImageIO.read(url);
        Graphics2D backgroundG2 = background.createGraphics();
        backgroundG2.drawImage(qrcode, positionX, positionY, getQrcodeWidth(), getQrcodeHeight(), null);
        backgroundG2.dispose();
        result = background;
        return this;
    }

    public BufferedImage getResult() {
        return result;
    }


    public static void main(String[] args) throws Exception {
        QrcodeGenerator qrcodeGenerator = new QrcodeGenerator("https://open.weixin.qq.com/connect/oauth2/authorize?appid=wx7f6aa253b75466dd&redirect_uri=http%3A%2F%2Fmall.efeiyi.com%2Fwl&response_type=code&scope=snsapi_userinfo&state=0%2Fiu0sc2bu318fkbta#wechat_redirect");

        BufferedImage image = qrcodeGenerator
                .createQrcode(582, 582)
                .assembleLogo("http://ef-wiki.oss-cn-beijing.aliyuncs.com/test/logo.png")
                .assembleBackground("http://ef-wiki.oss-cn-beijing.aliyuncs.com/test/background.jpg", 123, 92)
                .getResult();
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