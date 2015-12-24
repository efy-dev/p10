package com.efeiyi.ec.wiki.organization.model;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpMethod;
import org.apache.commons.httpclient.methods.GetMethod;
import org.apache.commons.httpclient.params.HttpMethodParams;

import java.io.DataInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;

/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 13-5-24
 * Time: 下午3:14
 * To change this template use File | Settings | File Templates.
 */

//天信博易 短信平台
public class TianXinBoYiSmsProvider implements SmsProvider {


    /**
     * 编码格式
     */
    private static String ENCODING = "GBK";
    /**
     * 查账户信息的http地址
     */
    private static String URI_GET_USER_INFO = "http://221.122.112.136:8080/sms/mm.jsp";
    /**
     * 通用发送接口的http地址
     */
    private static String URI_SEND_SMS = "http://221.122.112.136:8080/sms/mt.jsp";


    final static String cpName = "yuepai";

    final static String cpPwd = "baomax6123";

    final static String cpYxName = "yuepaiyx";

    final static String cpYxPwd = "yuepaiyx";

    /**
     * 发送, 并返回结果
     *
     * @param phone
     * @param content
     * @return
     */
    @Override
    public SendCode post(String phone, String content, String tpl_id) {


        //验证码
        if (tpl_id.equals("1")) {
            content = "您的手机验证码是 " + content + "【约拍啦】";
        }
        //营销短信
        else if (tpl_id.equals("2")) {
            content = "欢迎加入约拍啦，您的优惠券是 " + content + "，如有疑问请联系4008069955【约拍啦】";
        }


        String postData = "";
        String data = null;
        try {
            if (tpl_id.equals("3")){
                postData = "cpName=" + cpYxName + "&cpPwd=" + cpYxPwd + "&phones=" + phone + "&msg=" + URLEncoder.encode(URLEncoder.encode(content, ENCODING), ENCODING);
            }else{
                postData = "cpName=" + cpName + "&cpPwd=" + cpPwd + "&phones=" + phone + "&msg=" + URLEncoder.encode(URLEncoder.encode(content, ENCODING), ENCODING);
            }

            URL dataUrl = new URL(URI_SEND_SMS);
            HttpURLConnection con = (HttpURLConnection) dataUrl.openConnection();
            con.setRequestMethod("POST");
            con.setRequestProperty("Proxy-Connection", "Keep-Alive");
            con.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
            con.setDoOutput(true);
            con.setDoInput(true);
            con.setUseCaches(false);
            OutputStreamWriter out = new OutputStreamWriter(con.getOutputStream(), ENCODING);
            out.write(postData);
            out.flush();
            out.close();
            InputStream is = con.getInputStream();
            DataInputStream dis = new DataInputStream(is);
            byte[] d = new byte[dis.available()];
            dis.read(d);
            data = new String(d, ENCODING);
            con.disconnect();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return conversion(data);
    }


    /**
     * 返回结果
     * 通过JSON解析
     *
     * @param
     * @return
     */
    public SendCode conversion(String data) {
        String[] datas = data.split("&");
        SendCode postResult = new SendCode();
        postResult.setCode(Integer.valueOf(datas[0]));
        if ("0".equals(datas[0])) {
            postResult.setMsg("发送成功！");
        } else {
            postResult.setMsg(datas[1]);
        }
        return postResult;
    }


    /**
     * 查询余额
     *
     * @return
     */
    @Override
    public String checkAmount() throws IOException {
        HttpClient client = new HttpClient();
        HttpMethod method = new GetMethod(URI_GET_USER_INFO);
        HttpMethodParams param = method.getParams();
        param.setContentCharset(ENCODING);
        client.executeMethod(method);
        String jsonBody = method.getResponseBodyAsString();
        return jsonBody;

    }
}