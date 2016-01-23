package com.efeiyi.ec.art.base.util;

/**
 * Created by Administrator on 2015/8/12.
 */
public class WxPayConfig {

    //微信公众号身份的唯一标识。审核通过后，在微信发送的邮件中查看
    public static final String APPID = "wx7f6aa253b75466dd";
    //受理商ID，身份标识
    public static final String MCHID = "1231228502";
    //商户支付密钥Key。审核通过后，在微信发送的邮件中查看
    public static final String KEY = "nvkijrk4e7s2ndi3vf4amvqlysu7f1pa";
    //JSAPI接口中获取openid，审核后在公众平台开启开发模式后可查看
    public static final String APPSECRET = "04928de13ab23dca159d235ba6dc19ea";

    //从微信服务器获取code，并跳转到此uri
    public static final String REDIRECT_URI = "http://beijing.yuepaila.com/pc/pay/wxPreparePayParams.do";
    //TODO http://weixin.yuepaila.com:8001/pc/pay/wxPreparePayParams.do

    //=======【证书路径设置】=====================================
    //证书路径,注意应该填写绝对路径
    /*public static final String SSLCERT_PATH = "/xxx/xxx/xxxx/WxPayPubHelper/cacert/apiclient_cert.pem";
    public static final String SSLKEY_PATH = "/xxx/xxx/xxxx/WxPayPubHelper/cacert/apiclient_key.pem";*/

    //=======【异步通知url设置】===================================
    //异步通知url，商户根据实际开发过程设定
    public static final String NOTIFY_URL = "http://beijing.yuepaila.com/pc/pay/wxRecordPayment.do";
    //TODO http://weixin.yuepaila.com:8001/pc/pay/wxRecordPayment.do

    //=======【curl超时设置】===================================
    //本例程通过curl使用HTTP POST方法，此处可修改其超时时间，默认为30秒
    public static final int CURL_TIMEOUT = 30;



}
