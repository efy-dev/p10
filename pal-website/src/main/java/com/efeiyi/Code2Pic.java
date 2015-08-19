package com.efeiyi;

import com.alibaba.fastjson.JSONObject;
import com.ming800.core.util.JsonUtil;
import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpMethod;
import org.apache.commons.httpclient.methods.GetMethod;
import org.apache.http.HttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.util.EntityUtils;

import java.io.*;
import java.util.Map;

/**
 * Created by Administrator on 2015/8/19.
 */
public class Code2Pic {

   static DefaultHttpClient httpClient = new DefaultHttpClient();

    public static void main(String[] arg) throws IOException {
        String accessToken = getAccessToken();
        String ticket = getTicket(accessToken);
        System.out.println(accessToken);
        System.out.println(ticket);
        getPic(ticket);
    }


    public static String getAccessToken() throws IOException {

        HttpClient httpclient = new HttpClient();
        HttpMethod method = new GetMethod("https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=wx7f6aa253b75466dd&secret=04928de13ab23dca159d235ba6dc19ea");
        httpclient.executeMethod(method);
        String accesToken = method.getResponseBodyAsString();
        System.out.println(method.getResponseBodyAsString());
        method.releaseConnection();
        Map<?, ?> ipAddressMap = JsonUtil.parseJsonStringToMap(accesToken);
        return (String) ipAddressMap.get("access_token");
    }

    public static String getTicket(String accessToken) throws IOException {


        HttpPost method = new HttpPost("https://api.weixin.qq.com/cgi-bin/qrcode/create?access_token=" + accessToken);
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("expire_seconds", "3000");
        jsonObject.put("action_name", "QR_SCENE");

        JSONObject sceneId = new JSONObject();
        sceneId.put("scene_id", "12345678");
        JSONObject scene = new JSONObject();
        scene.put("scene", sceneId);
        jsonObject.put("action_info", scene);

        String jsonString = jsonObject.toJSONString();
        StringEntity stringEntity = new StringEntity(jsonString, "utf-8");
        stringEntity.setContentType("application/json");
        method.setEntity(stringEntity);

        HttpResponse response = httpClient.execute(method);
        String result = EntityUtils.toString(response.getEntity());
        JSONObject resultJson = JSONObject.parseObject(result);
        return (String) resultJson.get("ticket");
    }

    public static void getPic(String ticket) throws IOException {

        HttpClient httpclient = new HttpClient();
        HttpMethod method = new GetMethod("https://mp.weixin.qq.com/cgi-bin/showqrcode?ticket=" + ticket);
        httpclient.executeMethod(method);
        InputStream is = method.getResponseBodyAsStream();
        OutputStream os = new FileOutputStream(new File("d:/abc.jpg"));
        byte[] b = new byte[1];
        while (is.read(b) != -1) {
            os.write(b);
        }
        os.flush();
    }
}
