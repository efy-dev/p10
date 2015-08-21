package com.efeiyi.util;

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
import java.util.concurrent.ConcurrentLinkedQueue;

/**
 * Created by Administrator on 2015/8/19.
 */
public class Code2PicConsumer implements Runnable {

    HttpClient httpclient = new HttpClient();
    DefaultHttpClient httpClient = new DefaultHttpClient();
    static String accessToken ;
    HttpPost method;
    JSONObject jsonObject = new JSONObject();
    HttpResponse response;
    StringEntity stringEntity;
    String filePath = "d:/new/";
    static ConcurrentLinkedQueue<String> codeList = new ConcurrentLinkedQueue<>();
    static transient boolean theEnd = false;

    public static void main(String[] arg) throws IOException {

        for(int x=0;x<10;x++){
            new Thread(new Code2PicConsumer()).start();
        }
        new Thread(new Code2PicProducer()).start();

    }


    public void run() {

        Code2PicConsumer consumer = new Code2PicConsumer();

        try {
            if(Code2PicConsumer.accessToken == null){
                synchronized (Code2PicConsumer.codeList){
                    if(Code2PicConsumer.accessToken == null){
                        Code2PicConsumer.accessToken = consumer.getAccessToken();
                    }
                }
            }
            consumer.method = new HttpPost("https://api.weixin.qq.com/cgi-bin/qrcode/create?access_token=" + accessToken);
            consumer.prepareJsonObject();

            while (true) {
                if (codeList.size() > 0) {
                    String code = codeList.remove();
                    String ticket = consumer.getTicket(code);
                    System.out.println(Thread.currentThread().getId() + ":      " + ticket);
                    consumer.getPic(ticket, consumer.filePath + code + ".jpg");
                } else {
                    if(Code2PicConsumer.theEnd){
                        break;
                    }
                    try {
                        System.out.println("Thread[" + Thread.currentThread().getId() + "]wait");
                        synchronized (Code2PicConsumer.codeList){
                            Code2PicConsumer.codeList.notifyAll();
                            Code2PicConsumer.codeList.wait();
                        }
                    } catch (InterruptedException e) {
                        e.printStackTrace();
                    }
                }
            }
        } catch (IOException e) {
            throw new RuntimeException(e.getMessage());
        }

    }

    private void prepareJsonObject() {
        jsonObject.put("expire_seconds", "3000");
        jsonObject.put("action_name", "QR_SCENE");

        JSONObject sceneId = new JSONObject();
        JSONObject scene = new JSONObject();
        scene.put("scene", sceneId);
        jsonObject.put("action_info", scene);
    }

    private String getAccessToken() throws IOException {

        HttpMethod method = new GetMethod("https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=wx7f6aa253b75466dd&secret=04928de13ab23dca159d235ba6dc19ea");
        httpclient.executeMethod(method);
        String accessToken = method.getResponseBodyAsString();
        System.out.println(method.getResponseBodyAsString());
        method.releaseConnection();
        Map<?, ?> ipAddressMap = JsonUtil.parseJsonStringToMap(accessToken);
        return (String) ipAddressMap.get("access_token");
    }

    private String getTicket(String code) throws IOException {

        ((JSONObject) ((JSONObject) jsonObject.get("action_info")).get("scene")).put("scene_id", code);
        stringEntity = new StringEntity(jsonObject.toJSONString(), "utf-8");
        stringEntity.setContentType("application/json");
        method.setEntity(stringEntity);
        response = httpClient.execute(method);
        return (String) JSONObject.parseObject(EntityUtils.toString(response.getEntity())).get("ticket");
    }

    private void getPic(String ticket, String fileName) throws IOException {

        HttpMethod method = new GetMethod("https://mp.weixin.qq.com/cgi-bin/showqrcode?ticket=" + ticket);
        httpclient.executeMethod(method);
        InputStream is = method.getResponseBodyAsStream();
        OutputStream os = new FileOutputStream(new File(fileName));
        byte[] b = new byte[1];
        while (is.read(b) != -1) {
            os.write(b);
        }
        os.flush();
        os.close();
    }

}
