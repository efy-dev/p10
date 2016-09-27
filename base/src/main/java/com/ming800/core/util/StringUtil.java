package com.ming800.core.util;

/**
 * @author WYB
 */

import org.apache.commons.codec.binary.Base64;

import java.io.*;
import java.security.MessageDigest;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class StringUtil {
    private final static String regxpForHtml = "<([^>]*)>"; // 过滤所有以<开头以>结尾的标签
    public static String encodePassword(String password, String algorithm){
        byte[] unencodedPassword={};
     try{
         unencodedPassword=password.getBytes("utf-8");
        }catch(UnsupportedEncodingException e){
         e.printStackTrace();
        }
        MessageDigest md;
        try {
            md = MessageDigest.getInstance(algorithm);
        } catch (Exception e) {
            return password;
        }
        md.reset();
        // call the update method one or more times
        // (useful when you don't know the size of your data, eg. stream)
        md.update(unencodedPassword);
        // now calculate the hash
        byte[] encodedPassword = md.digest();
        /*StringBuffer buf = new StringBuffer();
        for (byte anEncodedPassword : encodedPassword) {
            if ((anEncodedPassword & 0xff) < 0x10) {
                buf.append("0");
            }
            buf.append(Long.toString(anEncodedPassword & 0xff, 16));
        }
        return buf.toString();*/
        return getFormattedText(encodedPassword);
    }

    /**
     * Encode a string using Base64 encoding.
     *
     * @param str String
     * @return String
     */
    public static byte[] encodeString(String str) {
        return new Base64().encode(str.getBytes());
    }

    /**
     * Decode a string using Base64 encoding.
     *
     * @return String
     */
    /*public static String decodeString(String str) {
		Base64 dec = new Base64();
		try {
			return String.valueOf(dec.decode(str));
		} catch (DecoderException de) {
			throw new RuntimeException(de.getMessage(), de.getCause());
		}
	}*/
    public static String decodeString(byte[] b) {
        return String.valueOf(new Base64().decode(b));
    }

    public static String toFirstUpper(String str) {
        return Character.toUpperCase(str.charAt(0)) + str.substring(1);
    }

    /**
     * 将str中的html标记<,>转换成&lt;和&gt;
     * @param str
     * @return
     */
    public static String escapeHtml(String str){
        if(str == null){
            return null;
        }
        else{
            String result = str.replaceAll("<","&lt;");
            result = result.replaceAll(">","&gt;");
            return result;
        }
    }
    public static String[] split(String str, char c) {
        int pos = str.indexOf(c);
        if (pos < 0) {
            return new String[]{str};
        }
        List<String> strList = new ArrayList<String>();
        if (pos == 0) {
            strList.add("");
        } else {
            strList.add(str.substring(0, pos));
        }
        while (pos >= 0) {
            int end = str.indexOf(c, pos + 1);
            if (end < 0) {
                end = str.length();
            }
            if (end - pos == 1) {
                strList.add("");
            } else {
                strList.add(str.substring(pos + 1, end));
            }
            pos = str.indexOf(c, pos + 1);
        }
        return strList.toArray(new String[strList.size()]);
    }

    public static String random(int randStrLength, int type) {
        String randStr = "";
        if (type == 1)
            randStr = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
        if (type == 2)
            randStr = "0123456789";
        if (type == 3)
            randStr = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
        if (type == 4)
            randStr = "0123456789abcdefghijklmnopqrstuvwxyz";
        StringBuffer generateRandStr = new StringBuffer();
        Random rand = new Random();
        for (int i = 0; i < randStrLength; i++) {
            int randNum = rand.nextInt(randStr.length());
            generateRandStr.append(randStr.substring(randNum, randNum + 1));
        }

        return generateRandStr.toString();
    }

    public static boolean isNumeric(String str) {
        for (int i = str.length(); --i >= 0; ) {
            if (!Character.isDigit(str.charAt(i))) {
                return false;
            }
        }
        return true;
    }

    /**
     * 符号环绕
     * 将例如string=a,b,c regex=，symbol=‘  返回形式为'a','b','c'
     *
     * @param string 要换换的字符串
     * @param regex  分隔符
     * @param symbol 需要环绕的符号
     * @return
     */
    public static String surroundSymbol(String string, String regex, String symbol) {
        String[] array = string.split(regex);
        StringBuilder stringBuilder = new StringBuilder();
        for (String s : array) {
            stringBuilder.append(symbol).append(s).append(symbol).append(regex);
        }
        if (stringBuilder.indexOf(",") != -1)
            stringBuilder.deleteCharAt(stringBuilder.length() - 1);
        return stringBuilder.toString();
    }

    /**
     * 将inputStream转为String
     *
     * @param inputStream
     * @return
     */
    public static String inputStream2String(InputStream inputStream) {
        StringBuilder stringBuilder = new StringBuilder();

        BufferedReader in = null;
        try {
            in = new BufferedReader(new InputStreamReader(inputStream, "UTF-8"));
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();  //To change body of catch statement use File | Settings | File Templates.
        }
        String line = "";
        try {
            while ((line = in.readLine()) != null) {
                stringBuilder.append(line);
            }
        } catch (IOException e) {
            e.printStackTrace();  //To change body of catch statement use File | Settings | File Templates.
        }
        return stringBuilder.toString();
    }

    private static String getFormattedText(byte bytes[]) {
        StringBuilder buf = new StringBuilder(bytes.length * 2);
        for (int j = 0; j < bytes.length; j++) {
            buf.append(HEX_DIGITS[bytes[j] >> 4 & 15]);
            buf.append(HEX_DIGITS[bytes[j] & 15]);
        }

        return buf.toString();
    }
    private static final char HEX_DIGITS[] = { '0', '1', '2', '3', '4', '5',
            '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f' };

    /**判断是否为Emoji表情
     * @param codePoint
     * @return
     */
    public static boolean isNotEmojiCharacter(char codePoint)
    {
        return (codePoint == 0x0) ||
                (codePoint == 0x9) ||
                (codePoint == 0xA) ||
                (codePoint == 0xD) ||
                ((codePoint >= 0x20) && (codePoint <= 0xD7FF)) ||
                ((codePoint >= 0xE000) && (codePoint <= 0xFFFD)) ||
                ((codePoint >= 0x10000) && (codePoint <= 0x10FFFF));
    }

    /**
     *过滤Emoji表情符
     * @param source
     * @return
     */
    public static String filterEmoji(String source)
    {
        int len = source.length();
        StringBuilder buf = new StringBuilder(len);
        for (int i = 0; i < len; i++)
        {
            char codePoint = source.charAt(i);
            if (isNotEmojiCharacter(codePoint))
            {
                buf.append(codePoint);
            } else{
                buf.append("");
            }
        }
        return buf.toString();
    }

    /**
     *
     * 基本功能：过滤所有以"<"开头以">"结尾的标签
     * @param str
     * @return String
     */
    public static String filterHtml(String str) {
        String temp = str == null ? "" : str;
        Pattern pattern = Pattern.compile(regxpForHtml);
        Matcher matcher = pattern.matcher(temp);
        StringBuffer sb = new StringBuffer();
        boolean result = matcher.find();
        while (result) {
            matcher.appendReplacement(sb, "");
            result = matcher.find();
        }
        matcher.appendTail(sb);
        return sb.toString();
    }
}
