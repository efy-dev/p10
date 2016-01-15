package com.efeiyi.ec.website.organization.controller;

import com.efeiyi.ec.website.order.service.WxPayConfig;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.p.model.WxCalledRecord;
import com.ming800.core.util.HttpUtil;
import com.ming800.core.util.StringUtil;
import net.sf.json.JSONObject;
import org.omg.CORBA.Current;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;

/**
 * Created by Administrator on 2015/11/25 0025.
 */
@Controller
@RequestMapping({"/wx"})
public class WxController {


    @Autowired
    private BaseManager baseManager;

    @RequestMapping({"/fetchCode.do"})
    public String getWxCode(HttpServletRequest request) throws Exception {
        String callback = request.getParameter("callback");
        String dataKey = request.getParameter("dataKey");
        String redirect_uri = "http://www.efeiyi.com/wx/fetchUserInfo/" + dataKey + "/" + callback;
        String url = "https://open.weixin.qq.com/connect/oauth2/authorize?" +
                "appid=" + WxPayConfig.APPID +
                "&redirect_uri=" +
                URLEncoder.encode(redirect_uri, "UTF-8") +
                "&response_type=code&scope=snsapi_base&state=123#wechat_redirect";

        return "redirect:" + url;
    }

    @RequestMapping({"/fetchBaseUserCode.do"})
    public String getWxUserInfo(HttpServletRequest request) throws Exception {
        String callback = request.getParameter("callback");
        String dataKey = request.getParameter("dataKey");
        String redirect_uri = "http://www.efeiyi.com/wx/fetchBaseUserInfo/" + dataKey + "/" + callback;
        String url = "https://open.weixin.qq.com/connect/oauth2/authorize?" +
                "appid=" + WxPayConfig.APPID +
                "&redirect_uri=" +
                URLEncoder.encode(redirect_uri, "UTF-8") +
                "&response_type=code&scope=snsapi_userinfo&state=123#wechat_redirect";
        return "redirect:" + url;
    }

    @RequestMapping({"/fetchUserInfo/{dataKey}/{callback}"})
    public String getUserInfo(HttpServletRequest request, Model model, @PathVariable String dataKey, @PathVariable String callback) throws Exception {
//        String callbackUrl = URLDecoder.decode(callback, "UTF-8");
        String result = "";
        String code = request.getParameter("code");
        if (request.getSession().getAttribute(code) != null) {
            result = request.getSession().getAttribute(code).toString();
        } else {
            System.out.println("1、 page code value：" + code);
            String urlForOpenId = "https://api.weixin.qq.com/sns/oauth2/access_token?appid=" + WxPayConfig.APPID + "&secret=" + WxPayConfig.APPSECRET + "&code=" + code + "&grant_type=authorization_code";
            result = HttpUtil.getHttpResponse(urlForOpenId, null);
            request.getSession().setAttribute(code, result);
        }
        System.out.println("2、get openid result：" + result);
        JSONObject jsonObject = JSONObject.fromObject(result);
        if (jsonObject.containsKey("errcode")) {
            throw new RuntimeException("get openId error：" + result);
        }
        String value = jsonObject.getString(dataKey);
        String access_token = jsonObject.getString("access_token");
        //微信调用记录
        WxCalledRecord wxCalledRecord = (WxCalledRecord) baseManager.getObject(WxCalledRecord.class.getName(), callback);
        wxCalledRecord.setAccessToken(access_token);
        wxCalledRecord.setData(value);
        String callbackUrl = URLDecoder.decode(wxCalledRecord.getCallback(), "UTF-8");
        if (callbackUrl.contains("?")) {
            callbackUrl += "&" + dataKey + "=" + value;
        } else {
            callbackUrl += "?" + dataKey + "=" + value;
        }
        return "redirect:http://" + callbackUrl;
    }


    @RequestMapping({"/fetchBaseUserInfo/{dataKey}/{callback}"})
    public String getUserBaseInfo(HttpServletRequest request, Model model, @PathVariable String dataKey, @PathVariable String callback) throws Exception {
        String result = "";
        String code = request.getParameter("code");
        if (request.getSession().getAttribute(code) != null) {
            result = request.getSession().getAttribute(code).toString();
        } else {
            System.out.println("1、 page code value：" + code);
            String urlForOpenId = "https://api.weixin.qq.com/sns/oauth2/access_token?appid=" + WxPayConfig.APPID + "&secret=" + WxPayConfig.APPSECRET + "&code=" + code + "&grant_type=authorization_code";
            result = HttpUtil.getHttpResponse(urlForOpenId, null);
            request.getSession().setAttribute(code, result);
        }
        System.out.println("2、get openid result：" + result);
        JSONObject jsonObject = JSONObject.fromObject(result);
        if (jsonObject.containsKey("errcode")) {
            throw new RuntimeException("get openId error：" + result);
        }
//        String value = jsonObject.getString(dataKey);
        String access_token = jsonObject.getString("access_token");
        String openid = jsonObject.getString("openid");

        WxCalledRecord wxCalledRecord = (WxCalledRecord) baseManager.getObject(WxCalledRecord.class.getName(), callback);
        wxCalledRecord.setAccessToken(access_token);
        String callbackUrl = URLDecoder.decode(wxCalledRecord.getCallback(), "UTF-8");

        String urlForOpenId = "https://api.weixin.qq.com/sns/userinfo?access_token=" + access_token + "&openid=" + openid + "&lang=zh_CN";
        String userInfo = HttpUtil.getHttpResponse(urlForOpenId, null);
        System.out.println("2、get openid result：" + userInfo);
        JSONObject userJsonObject = JSONObject.fromObject(userInfo);


        String[] keyArray = dataKey.split(";");
        String data = "";
        for (String key : keyArray) {
            String value = userJsonObject.getString(key);
            wxCalledRecord.setData(value);
            value = URLEncoder.encode(value, "utf-8");
            if (callbackUrl.contains("?")) {
                callbackUrl += "&" + key + "=" + value;
            } else {
                callbackUrl += "?" + key + "=" + value;
            }
            if (!data.equals("")) {
                data += ";" + value;
            } else {
                data += value;
            }
        }
        wxCalledRecord.setData(data);
        baseManager.saveOrUpdate(WxCalledRecord.class.getName(), wxCalledRecord);
        return "redirect:http://" + callbackUrl;
    }


    @RequestMapping({"/getInfo.do"})
    public String getWxInfo(HttpServletRequest request) {
        String callback = request.getParameter("callback"); //www.efeiyi.com   www.efeiyi.com?name=xxxx
        String dataKey = request.getParameter("dataKey");
        String requestSource = request.getParameter("source");
        String consumerId = request.getParameter("consumerId");
        WxCalledRecord wxCalledRecord = new WxCalledRecord();
        wxCalledRecord.setCallback(callback);
        wxCalledRecord.setDataKey(dataKey);
        wxCalledRecord.setRequestSource(requestSource);
        wxCalledRecord.setConsumerId(consumerId);
        wxCalledRecord.setCreateDatetime(new Date());
        baseManager.saveOrUpdate(WxCalledRecord.class.getName(), wxCalledRecord);
        String redirect = "/wx/fetchCode.do?callback=" + wxCalledRecord.getId() + "&dataKey=" + dataKey;
        return "redirect:" + redirect;
    }

    @RequestMapping({"/getUserBaseInfo.do"})
    public String getWxBaseInfo(HttpServletRequest request) {
        String callback = request.getParameter("callback");
        String dataKey = request.getParameter("dataKey");
        String requestSource = request.getParameter("source");
        String consumerId = request.getParameter("consumerId");
        WxCalledRecord wxCalledRecord = new WxCalledRecord();
        wxCalledRecord.setCallback(callback);
        wxCalledRecord.setDataKey(dataKey);
        wxCalledRecord.setRequestSource(requestSource);
        wxCalledRecord.setConsumerId(consumerId);
        wxCalledRecord.setCreateDatetime(new Date());
        baseManager.saveOrUpdate(WxCalledRecord.class.getName(), wxCalledRecord);
        String redirect = "/wx/fetchBaseUserCode.do?callback=" + wxCalledRecord.getId() + "&dataKey=" + dataKey;
        return "redirect:" + redirect;
    }

    @RequestMapping({"/init.do"})
    @ResponseBody
    public String initWxConfig(HttpServletRequest request) throws Exception {
        String timestamp = request.getParameter("timestamp");
        String nonceStr = request.getParameter("nonceStr");
        String callUrl = request.getParameter("callUrl");
        String ticket;

        //获取当前的ticket
        String hql = "select obj from " + WxCalledRecord.class.getName() + " obj where obj.dataKey=:dataKey order by obj.createDatetime desc";
        LinkedHashMap<String, Object> param = new LinkedHashMap<>();
        param.put("dataKey", "jsapi_ticket");
        List<Object> wxCallRecordList = baseManager.listObject(hql, param);

        if ((wxCallRecordList != null && wxCallRecordList.isEmpty()) || (wxCallRecordList != null && !wxCallRecordList.isEmpty() && System.currentTimeMillis() - ((WxCalledRecord) wxCallRecordList.get(0)).getCreateDatetime().getTime() >= 7000000)) {
            //首先获得accessToken
            String fetchAccessTokenUrl = "https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=" + WxPayConfig.APPID + "&secret=" + WxPayConfig.APPSECRET;
            String tokenResult = HttpUtil.getHttpResponse(fetchAccessTokenUrl, null);
            JSONObject tokenObject = JSONObject.fromObject(tokenResult);
            String accessToken = tokenObject.getString("access_token");
            //获得jsapiTickit
            String fetchJsApiTicketUrl = "https://api.weixin.qq.com/cgi-bin/ticket/getticket?access_token=" + accessToken + "&type=jsapi";
            String ticketResult = HttpUtil.getHttpResponse(fetchJsApiTicketUrl, null);
            JSONObject ticketObject = JSONObject.fromObject(ticketResult);
            ticket = ticketObject.getString("ticket");

            WxCalledRecord wxCalledRecord = new WxCalledRecord();
            wxCalledRecord.setData(ticket);
            wxCalledRecord.setDataKey("jsapi_ticket");
            wxCalledRecord.setCreateDatetime(new Date());
            wxCalledRecord.setAccessToken(accessToken);
            baseManager.saveOrUpdate(WxCalledRecord.class.getName(), wxCalledRecord);
        } else {
            ticket = ((WxCalledRecord) wxCallRecordList.get(0)).getData();
        }
        //生成signature
        String signature = "jsapi_ticket=" + ticket + "&noncestr=" + nonceStr + "&timestamp=" + timestamp + "&url=" + URLDecoder.decode(callUrl, "UTF-8");
        System.out.println(signature);
        signature = StringUtil.encodePassword(signature, "SHA1");
        return signature;
    }

    @RequestMapping({"/wxTest.do"})
    public String wxTest(HttpServletRequest request) {
        return "/wxTest";
    }


}