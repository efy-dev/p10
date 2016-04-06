package com.efeiyi.ec.system.masterWork.controller;

import com.alibaba.fastjson.JSONObject;

import com.efeiyi.ec.master.model.MasterWork;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpMethod;
import org.apache.commons.httpclient.HttpStatus;
import org.apache.commons.httpclient.methods.GetMethod;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.util.EntityUtils;
import org.dom4j.Document;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.URL;
import java.util.List;

/**
 * Created by Administrator on 2015/7/20.
 */
@Controller("/")
public class MasterWorkController {


    @Autowired
    protected BaseManager baseManager;
    HttpClient httpClient = new HttpClient();
    DefaultHttpClient client = new DefaultHttpClient();
//    static transient String accessToken;
    HttpPost method;
    JSONObject jsonObject = new JSONObject();
    HttpResponse response;
    StringEntity stringEntity;
//    static transient String ticket;
    public static final String APP_ID = "wx7f6aa253b75466dd";
    public static final String SECRET = "04928de13ab23dca159d235ba6dc19ea";
    public static final String GET_TOKEN_URL = "https://api.weixin.qq.com/cgi-bin/token";// 获取access

    //true:永久二维码模式；false：临时二维码模式
//    private boolean runningModel = false;
    private boolean runningModel = false;

    @RequestMapping(value = "/masterWork/gg.do")
    @ResponseBody
    public void getCode(HttpServletRequest request,HttpServletResponse response) throws Exception {


            String serial = request.getParameter("serial");
            String  token = getAccessToken(GET_TOKEN_URL,APP_ID,SECRET);

            //永久/临时二维码
            if (runningModel) {
                //永久
                preparePermanentJsonObject();
            } else {
                //临时
                prepareTempJsonObject();
            }
           String ticket = getTicket(serial,token);
           String root = "D:\\Images";
        response.setHeader("Pragma", "No-cache");
        response.setHeader("Cache-Control", "No-cache");
        response.setDateHeader("Expires", 0);
        response.setContentType("application/octet-stream");
        response.setHeader("Content-Disposition", "attachment; fileName=" + serial + System.currentTimeMillis() + ".jpg");
        response.getOutputStream().write(getPic(ticket,root));
//        return  "";
        }

     private String getAccessToken(String apiurl, String appid, String secret){
//         method = new HttpPost(GET_TOKEN_URL+"?grant_type=client_credential&appid=" + appid+"&secret="+secret);
         String turl = String.format("%s?grant_type=client_credential&appid=%s&secret=%s", apiurl,
                               appid, secret);
         HttpGet get = new HttpGet(turl);
         String result = null;
         try
        {
              HttpResponse res = client.execute(get);
                   String responseContent = null; // 响应内容
                   HttpEntity entity = res.getEntity();
                   responseContent = EntityUtils.toString(entity, "UTF-8");
                          JSONObject json =  JSONObject.parseObject(responseContent);
                          // 将json字符串转换为json对象
                          if (res.getStatusLine().getStatusCode() == HttpStatus.SC_OK)
                             {
                                  if (json.get("errcode") != null)
                                     {// 错误时微信会返回错误码等信息，{"errcode":40013,"errmsg":"invalid appid"}
                                      }
                                  else
                                 {// 正常情况下{"access_token":"ACCESS_TOKEN","expires_in":7200}
                                         result = json.get("access_token").toString();
                                    }
                              }
                     }
                  catch (Exception e)
                  {
                        e.printStackTrace();
                     }
                 finally
                 {
                          // 关闭连接 ,释放资源
                        client.getConnectionManager().shutdown();
                         return result;
                  }
     }
        private void prepareTempJsonObject() {
            jsonObject.put("expire_seconds", "3000");
            jsonObject.put("action_name", "QR_SCENE");

            JSONObject sceneId = new JSONObject();
            JSONObject scene = new JSONObject();
            scene.put("scene", sceneId);
            jsonObject.put("action_info", scene);
        }

        private void preparePermanentJsonObject() {
            jsonObject.put("action_name", "QR_LIMIT_STR_SCENE");
            JSONObject sceneId = new JSONObject();
            JSONObject scene = new JSONObject();
            scene.put("scene", sceneId);
            jsonObject.put("action_info", scene);
        }

//      @RequestMapping(value = "/masterWork/getCode.do",method = RequestMethod.GET)
//      public  String  contact(HttpServletRequest request, HttpServletResponse response) throws IOException {
//          String s = request.getParameter("echostr");
//          System.out.print("echostr ----->"+s);
////          response.getWriter().write(s);
//          return s;
//      }



        private String getTicket(String code,String token) throws IOException {
            String ticket="";
            DefaultHttpClient client1 = new DefaultHttpClient();
            method = new HttpPost("https://api.weixin.qq.com/cgi-bin/qrcode/create?access_token="+token);
//            List<NameValuePair> params = new ArrayList<NameValuePair>();
//            params.add(new BasicNameValuePair("access_token",token));
            //写入二维码Json参数code
            if (runningModel) {
                //永久
                ((JSONObject) ((JSONObject) jsonObject.get("action_info")).get("scene")).put("scene_str", code);
            } else {
                //临时
                ((JSONObject) ((JSONObject) jsonObject.get("action_info")).get("scene")).put("scene_id", Integer.parseInt(code));
            }
          try {
              stringEntity = new StringEntity(jsonObject.toJSONString(), "utf-8");
              stringEntity.setContentType("application/json");
              method.setEntity(stringEntity);
              response = client1.execute(method);
              String json = EntityUtils.toString(response.getEntity());
              ticket = (String) JSONObject.parseObject(json).get("ticket");
          }catch (Exception e){
              e.printStackTrace();
          }finally {
              client1.getConnectionManager().shutdown();
          }

//            if (ticket == null) {
//                Code2UrlConsumer.accessToken = getAccessToken();
//                ticket = getTicket(code);
//            }
            return ticket;
        }

        private String getTicketUrl(String code) throws UnsupportedEncodingException {

            if (runningModel) {
                ((JSONObject) ((JSONObject) jsonObject.get("action_info")).get("scene")).put("scene_str", code);
            } else {
                ((JSONObject) ((JSONObject) jsonObject.get("action_info")).get("scene")).put("scene_id", 123);
            }
            stringEntity = new StringEntity(jsonObject.toJSONString(), "utf-8");
            stringEntity.setContentType("application/json");
            method.setEntity(stringEntity);
            String url = "";
            try {
                response = client.execute(method);
                String json = EntityUtils.toString(response.getEntity());
                url = (String) JSONObject.parseObject(json).get("url");
//            url = "*******************";
                if (url == null) {
                    url = getTicketUrl(code);
                }
            } catch (Throwable e) {
                e.printStackTrace();
                System.out.println("重试...................");
                url = getTicketUrl(code);
            }
            return url;
        }

        private  void  downPic(String url){
            try {

            // 创建流
            BufferedInputStream in = new BufferedInputStream(new URL(url).openStream());

            // 生成图片名
            int index = url.lastIndexOf("/");
            String sName = url.substring(index+1, url.length());
            System.out.println(sName);
            // 存放地址
            File img = new File("c:"+File.separator+"image");
            // 生成图片
            BufferedOutputStream out = new BufferedOutputStream(
                    new FileOutputStream(img));
            byte[] buf = new byte[2048];
            int length = in.read(buf);
            while (length != -1) {
                out.write(buf, 0, length);
                length = in.read(buf);
            }
            in.close();
            out.close();
        } catch (Exception e) {
        e.printStackTrace();
    }
}

        private byte[] getPic(String ticket,String root) throws IOException {
            File file = new File(root);
            HttpMethod method = new GetMethod("https://mp.weixin.qq.com/cgi-bin/showqrcode?ticket=" + ticket);
            httpClient.executeMethod(method);
//            InputStream is = method.getResponseBodyAsStream();
//            method.getResponseBody()
            byte[] b = method.getResponseBody();
//            BufferedImage bufferedImage = new BufferedImage(is)
//            ImageIO imageIO = new ImageIO()
//            OutputStream os = new ByteArrayOutputStream(b.length);
//            byte[] b = new byte[1];
//            while (is.read(b) != -1) {
//                os.write(b);
//            }
//            os.write(b);
//            os.flush();
//            os.close();
            return b;
        }
    @RequestMapping(value = "/masterWork/getCode.do")
    public String viewMasterWork(HttpServletRequest request,HttpServletResponse response) throws Exception {

       InputStream is = request.getInputStream();
        byte[] b = new byte[request.getContentLength()];
        is.read(b);
        String inxml = new String(b);
        String serial = treatWeixinMsg(request,inxml);
        XQuery xQuery = new XQuery("listMasterWorkCode_default",request);
        xQuery.put("serial",serial);
        List<MasterWork> masterWorkList = baseManager.listObject(xQuery);
        String id = "";
        if(masterWorkList!=null){
            if(masterWorkList.size()>0){
               id = masterWorkList.get(0).getId();
            }
        }
       return  "redirect:http://master.efeiyi.com/masterBrief/masterWork/"+id;

    }

    public String treatWeixinMsg(HttpServletRequest request,String inxml){
        Document document = null;
        try {
            document = DocumentHelper.parseText(inxml);

        }catch (Exception e){
            e.printStackTrace();
        }
        Element root = document.getRootElement();
        String  serial = root.element("EventKey").getText();
        if(serial==null){
            serial = "";
        }
        return  serial;
    }

}
