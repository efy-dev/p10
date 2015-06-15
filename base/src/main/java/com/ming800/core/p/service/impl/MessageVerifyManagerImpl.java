package com.ming800.core.p.service.impl;

import com.ming800.core.p.service.MessageVerifyManager;
import org.springframework.stereotype.Service;

import java.io.IOException;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.NameValuePair;
import org.apache.commons.httpclient.methods.PostMethod;
import org.apache.commons.httpclient.params.HttpMethodParams;


/**
 * Created by Administrator on 2014/11/20.
 */

@Service
public class MessageVerifyManagerImpl implements MessageVerifyManager {


    private static String BASE_URI = "http://yunpian.com";
    /**
     * 服务版本号
     */
    private static String VERSION = "v1";
    /**
     * 编码格式
     */
    private static String ENCODING = "UTF-8";


    /**
     * 模板发送接口的http地址
     */
    private static String URI_TPL_SEND_SMS = BASE_URI + "/" + VERSION + "/sms/tpl_send.json";


    @Override
    public boolean sendVerificationCode(String cellPhoneNumber, String params) throws IOException {
        String returnJson = tplSendSms("e6e72088d0e394b31a5c523928aaa00e", 1, "#code#=" + params + "&#company#=约拍啦", cellPhoneNumber);
        System.out.println(returnJson);
        String result = returnJson.substring(returnJson.indexOf("code") + 6, returnJson.indexOf("code") + 7);
        if (result.equals("0")) {
            return true;
        } else {
            return false;
        }
    }

    @Override
    public boolean sendSaleCode(String cellPhoneNumber, String params) throws IOException {

        String returnJson = tplSendSms("e6e72088d0e394b31a5c523928aaa00e", 636641, "#code#=" + params, cellPhoneNumber);
        System.out.println(returnJson);
        String result = returnJson.substring(returnJson.indexOf("code") + 6, returnJson.indexOf("code") + 7);
        if (result.equals("0")) {
            return true;
        } else {
            return false;
        }
    }

    public static String tplSendSms(String apikey, long tpl_id, String tpl_value, String mobile) throws IOException {
        HttpClient client = new HttpClient();
        NameValuePair[] nameValuePairs = new NameValuePair[4];
        nameValuePairs[0] = new NameValuePair("apikey", apikey);
        nameValuePairs[1] = new NameValuePair("tpl_id", String.valueOf(tpl_id));
        nameValuePairs[2] = new NameValuePair("tpl_value", tpl_value);
        nameValuePairs[3] = new NameValuePair("mobile", mobile);
        PostMethod method = new PostMethod(URI_TPL_SEND_SMS);
        method.setRequestBody(nameValuePairs);
        HttpMethodParams param = method.getParams();
        param.setContentCharset(ENCODING);
        client.executeMethod(method);
        return method.getResponseBodyAsString();
    }
}
