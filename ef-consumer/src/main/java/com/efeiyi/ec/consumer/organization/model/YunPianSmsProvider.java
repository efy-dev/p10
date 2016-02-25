package com.efeiyi.ec.consumer.organization.model;

import com.alibaba.fastjson.JSON;
import java.io.DataInputStream;
import java.io.InputStream;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.Map;


/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 13-5-24
 * Time: 下午3:14
 * To change this template use File | Settings | File Templates.
 */

public class YunPianSmsProvider implements SmsProvider {


    /**
     * 服务http地址
     */
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


    final static String apikey = "b802cb40c7a0db20e787884bf29f1e6d";

    @Override
    public SendCode post(String phone, Map<String,String> param, Map<String,String>templateMap) {
        String content="";
        String postData="";
        String tpl_id=templateMap.get("tpl_id");
        try {
            if(param==null){
                content = URLEncoder.encode("#null#="+content, ENCODING);
            }else{
                int i=0;
                for (Map.Entry<String, String> entry : param.entrySet()) {

                    if(i++==0){
                        content = content + "#"+entry.getKey()+"#="+entry.getValue();
                    }else{
                        content = content + "&#"+entry.getKey()+"#="+entry.getValue();
                    }
                }
            }
            content = URLEncoder.encode(content, ENCODING);
            postData = "apikey=" + apikey + "&mobile=" + phone + "&tpl_id=" + tpl_id + "&tpl_value=" + content + "";
        } catch (Exception e) {
            e.printStackTrace();
        }
        return templatePost(postData);
    }




    /**
     * 短信模板发送短信接口
     * @return
     */
    public SendCode templatePost(String postData){
        String data = null;
        try {
            URL dataUrl = new URL(URI_TPL_SEND_SMS);
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
        return JSON.parseObject(data, SendCode.class);
    }


}