package com.efeiyi;

import java.security.MessageDigest;
import java.util.Arrays;

/**
 * Created by Administrator on 2015/8/12.
 */
public final class WeiXinMessageDigest {

    /**
     * 单例持有类
     *
     * @author liguocai
     */
    private static class SingletonHolder {
        static final WeiXinMessageDigest INSTANCE = new WeiXinMessageDigest();
    }

    /**
     * 获取单例
     *
     * @return
     */
    public static WeiXinMessageDigest getInstance() {
        return WeiXinMessageDigest.SingletonHolder.INSTANCE;
    }

    private MessageDigest digest;

    private WeiXinMessageDigest() {
        try {
            digest = MessageDigest.getInstance("SHA-1");
        } catch (Exception e) {
            throw new InternalError("init MessageDigest error:" + e.getMessage());
        }
    }


    /**
     * 将字节数组转换成16进制字符串
     *
     * @param b
     * @return
     */
    private static String byte2hex(byte[] b) {
        StringBuilder sbDes = new StringBuilder();
        String tmp = null;
        for (int i = 0; i < b.length; i++) {
            tmp = (Integer.toHexString(b[i] & 0xFF));
            if (tmp.length() == 1) {
                sbDes.append("0");
            }
            sbDes.append(tmp);
        }
        return sbDes.toString();
    }

    private String encrypt(String strSrc) {
        String strDes = null;
        byte[] bt = strSrc.getBytes();
        digest.update(bt);
        strDes = byte2hex(digest.digest());
        return strDes;
    }

    /**
     * 校验请求的签名是否合法
     * <p/>
     * 加密/校验流程：
     * 1. 将token、timestamp、nonce三个参数进行字典序排序
     * 2. 将三个参数字符串拼接成一个字符串进行sha1加密
     * 3. 开发者获得加密后的字符串可与signature对比，标识该请求来源于微信
     *
     * @param signature
     * @param timestamp
     * @param nonce
     * @return
     */
    public boolean validate(String signature, String timestamp, String nonce) {
        //1. 将token、timestamp、nonce三个参数进行字典序排序
        String token = getToken();
        String[] arrTmp = {token, timestamp, nonce};
        Arrays.sort(arrTmp);
        StringBuffer sb = new StringBuffer();
        //2.将三个参数字符串拼接成一个字符串进行sha1加密
        for (int i = 0; i < arrTmp.length; i++) {
            sb.append(arrTmp[i]);
        }
        String expectedSignature = encrypt(sb.toString());
        //3. 开发者获得加密后的字符串可与signature对比，标识该请求来源于微信
        if (expectedSignature.equals(signature)) {
            return true;
        }
        return false;
    }

    private String getToken() {
        return PalConst.getInstance().weiXinToken;
    }
}
