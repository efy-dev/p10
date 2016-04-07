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

//    static transient String accessToken;
    HttpPost method;
    JSONObject jsonObject = new JSONObject();
    HttpResponse response;
    StringEntity stringEntity;
//    static transient String ticket;
    public static final String APP_ID = "wx7f6aa253b75466dd";
    public static final String SECRET = "04928de13ab23dca159d235ba6dc19ea";
    public static final String GET_TOKEN_URL = "https://api.weixin.qq.com/cgi-bin/token";// 获取access
    public static final String TEMPLATE_ID = "apxbSZVG5NLigbuL_DbXzwo77OgdOuSJ-G2JkLtkT1s";

    //true:永久二维码模式；false：临时二维码模式
//    private boolean runningModel = false;
    private boolean runningModel = false;

    /**
     * 生成二维码
     * @param request
     * @param response
     * @throws Exception
     */
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


    /**
     * 获取token
     * @param apiurl
     * @param appid
     * @param secret
     * @return
     */
     private String getAccessToken(String apiurl, String appid, String secret){
//         method = new HttpPost(GET_TOKEN_URL+"?grant_type=client_credential&appid=" + appid+"&secret="+secret);
         DefaultHttpClient client = new DefaultHttpClient();
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

    /**
     * 临时二维码
     */
        private void prepareTempJsonObject() {
            jsonObject.put("expire_seconds", "3000");
            jsonObject.put("action_name", "QR_SCENE");

            JSONObject sceneId = new JSONObject();
            JSONObject scene = new JSONObject();
            scene.put("scene", sceneId);
            jsonObject.put("action_info", scene);
        }

    /**
     * 永久二维码
     */
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


    /**
     * 获取ticket
     * @param code
     * @param token
     * @return
     * @throws IOException
     */
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


    /**
     * 获取二维码图片
     * @param ticket
     * @param root
     * @return
     * @throws IOException
     */
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

    /**
     * 服务器url
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/masterWork/getCode.do")
    public void viewMasterWork(HttpServletRequest request,HttpServletResponse response) throws Exception {
        String id = "";
        MasterWork masterWork;
        String imageUrl = "";
        String url = "";
        String xml = "";

        InputStream is = request.getInputStream();
        byte[] b = new byte[request.getContentLength()];
        is.read(b);
        String inxml = new String(b);
        System.out.print(inxml);
        JSONObject jsonObject = treatWeixinMsg(request,inxml);
        String serial = jsonObject.get("serial").toString();
        String toUserName = jsonObject.get("toUserName").toString();
        String fromUserName = jsonObject.get("fromUserName").toString();
        XQuery xQuery = new XQuery("listMasterWorkCode_default",request);
        xQuery.put("serial",serial);
        List<MasterWork> masterWorkList = baseManager.listObject(xQuery);

        if(masterWorkList!=null){
            if(masterWorkList.size()>0){
               id = masterWorkList.get(0).getId();
                url = "http://master.efeiyi.com/masterBrief/masterWork/"+id;
                try {
                    masterWork = masterWorkList.get(0);
                    if(masterWork.getPictureUrl()!=null&&!"".equals(masterWork.getPictureUrl())){
                         imageUrl = "http://pro.efeiyi.com/"+masterWork.getPictureUrl();
                    }
                    xml = sendPic(toUserName,fromUserName,masterWork.getName(),masterWork.getDescription(),imageUrl,url);
                    PrintWriter pw = response.getWriter();
                    pw.write(xml);

                }catch (Exception e){
                    e.printStackTrace();
                }

            }
        }
    }

    /**
     * 获取code(scene_id)
     * @param request
     * @param inxml
     * @return
     */
    public JSONObject treatWeixinMsg(HttpServletRequest request,String inxml){
        JSONObject jsonObject = new JSONObject();
        Document document = null;
        try {
            document = DocumentHelper.parseText(inxml);

        }catch (Exception e){
            e.printStackTrace();
        }
        Element root = document.getRootElement();
        String  serial = root.element("EventKey").getText();
        String  ToUserName = root.element("ToUserName").getText();
        String  FromUserName = root.element("FromUserName").getText();
        if(ToUserName!=null&&!"".equals(ToUserName)){
            jsonObject.put("toUserName",ToUserName);
        }
        if(serial!=null&&!"".equals(serial)){
            jsonObject.put("serial",serial);
        }
        if(FromUserName!=null&&!"".equals(FromUserName)){
            jsonObject.put("fromUserName",FromUserName);
        }
        System.out.print(serial);
        return  jsonObject;
    }


    /**
     * 推送图文信息
     * @param toUserName
     * @param fromUserName
     * @param title
     * @param content
     * @param imageUrl
     * @param url
     * @return
     */
    private  String sendPic(String toUserName,String fromUserName,String title,String content,String imageUrl,String url){
        Document document = DocumentHelper.createDocument();
        document.setXMLEncoding("utf-8");
        Element root = document.addElement("xml");

        root.addElement("ToUserName").setText(toUserName);//接收方账号(OpenI)
        root.addElement("FromUserName").setText(fromUserName);//开发者微信号
        root.addElement("CreateTime").setText(Long.toString(System.currentTimeMillis()));//时间
        root.addElement("MsgType").setText("news");//类型
        root.addElement("ArticleCount").setText("1");//图文个数
        Element item = root.addElement("Articles").addElement("item");//第一个为大图
        item.addElement("Title").add(DocumentHelper.createCDATA(title));
        item.addElement("Description").add(DocumentHelper.createCDATA(content));
        item.addElement("PicUrl").add(DocumentHelper.createCDATA(imageUrl));//图片链接
        item.addElement("Url").add(DocumentHelper.createCDATA(url));//跳转链接
        return  document.asXML();
    }

}
