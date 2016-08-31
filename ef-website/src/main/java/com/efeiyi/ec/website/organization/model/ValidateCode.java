//
// Source code recreated from a .class file by IntelliJ IDEA
// (powered by Fernflower decompiler)
//

package com.efeiyi.ec.website.organization.model;

import javax.imageio.ImageIO;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.Random;

public class ValidateCode {
    private int width = 160;
    private int height = 40;
    private int codeCount = 5;
    private int lineCount = 150;
    private static String code = null;
    private BufferedImage buffImg = null;
    private char[] codeSequence = new char[]{'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', '1', '2', '3', '4', '5', '6', '7', '8', '9'};

    public ValidateCode() {
        this.createCode();
    }

    public ValidateCode(int width, int height) {
        this.width = width;
        this.height = height;
        this.createCode();
    }

    public ValidateCode(int width, int height, int codeCount, int lineCount) {
        this.width = width;
        this.height = height;
        this.codeCount = codeCount;
        this.lineCount = lineCount;
        this.createCode();
    }

    public void createCode() {
        boolean x = false;
        boolean fontHeight = false;
        boolean codeY = false;
        boolean red = false;
        boolean green = false;
        boolean blue = false;
        int var14 = this.width / (this.codeCount + 2);
        int var15 = this.height - 2;
        int var16 = this.height - 4;
        this.buffImg = new BufferedImage(this.width, this.height, 1);
        Graphics2D g = this.buffImg.createGraphics();
        Random random = new Random();
        g.setColor(Color.WHITE);
        g.fillRect(0, 0, this.width, this.height);
        g.setFont(new Font("Times New Roman", 0, var15));

        int i;
        int var17;
        int var18;
        int var19;
        for(int randomCode = 0; randomCode < this.lineCount; ++randomCode) {
            i = random.nextInt(this.width);
            int strRand = random.nextInt(this.height);
            int xe = i + random.nextInt(this.width / 8);
            int ye = strRand + random.nextInt(this.height / 8);
            var17 = random.nextInt(255);
            var18 = random.nextInt(255);
            var19 = random.nextInt(255);
            g.setColor(new Color(var17, var18, var19));
            g.drawLine(i, strRand, xe, ye);
        }

        StringBuffer var20 = new StringBuffer();

        for(i = 0; i < this.codeCount; ++i) {
            String var21 = String.valueOf(this.codeSequence[random.nextInt(this.codeSequence.length)]);
            var17 = random.nextInt(255);
            var18 = random.nextInt(255);
            var19 = random.nextInt(255);
            g.setColor(new Color(var17, var18, var19));
            g.drawString(var21, (i + 1) * var14, var16);
            var20.append(var21);
        }

        code = var20.toString();
    }

    public void write(String path) throws IOException {
        FileOutputStream sos = new FileOutputStream(path);
        this.write((OutputStream)sos);
    }

    public void write(OutputStream sos) throws IOException {
        ImageIO.write(this.buffImg, "png", sos);
        sos.close();
    }

    public BufferedImage getBuffImg() {
        return this.buffImg;
    }

    public static String getCode() {
        return code;
    }
}
