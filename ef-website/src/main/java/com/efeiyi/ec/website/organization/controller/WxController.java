package com.efeiyi.ec.website.organization.controller;

import com.efeiyi.ec.website.order.service.WxPayConfig;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.p.model.WxCalledRecord;
import com.ming800.core.util.HttpUtil;
import com.ming800.core.util.StringUtil;
import net.sf.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.Date;

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

        System.out.println("1、 page code value：" + code);
        String urlForOpenId = "https://api.weixin.qq.com/sns/userinfo?access_token=" + access_token + "&openid=" + openid + "&lang=zh_CN";
        String userInfo = HttpUtil.getHttpResponse(urlForOpenId, null);
        JSONObject userJsonObject = JSONObject.fromObject(userInfo);
        if (userJsonObject.containsKey("errcode")) {
            throw new RuntimeException("get userInfo error：" + result);
        }
        String value = userJsonObject.getString(dataKey);
        wxCalledRecord.setData(value);
        baseManager.saveOrUpdate(WxCalledRecord.class.getName(), wxCalledRecord);
        if (callbackUrl.contains("?")) {
            callbackUrl += "&" + dataKey + "=" + value;
        } else {
            callbackUrl += "?" + dataKey + "=" + value;
        }
        return "redirect:http://" + callbackUrl;
    }


    @RequestMapping({"/getInfo.do"})
    public String getWxInfo(HttpServletRequest request) {
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


    private void setUserInfo(String consumerId, JSONObject userJsonObject) {


    }


    @RequestMapping({"/init.do"})
    @ResponseBody
    public String initWxConfig(HttpServletRequest request) throws Exception {
        String timestamp = request.getParameter("timestamp");
        String nonceStr = request.getParameter("nonceStr");
        String callUrl = request.getParameter("callUrl");
        //首先获得accessToken
        String fetchAccessTokenUrl = "https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=" + WxPayConfig.APPID + "&secret=" + WxPayConfig.APPSECRET;
        String tokenResult = HttpUtil.getHttpResponse(fetchAccessTokenUrl, null);
        JSONObject tokenObject = JSONObject.fromObject(tokenResult);
        String accessToken = tokenObject.getString("access_token");
        //获得jsapiTickit
        String fetchJsApiTicketUrl = "https://api.weixin.qq.com/cgi-bin/ticket/getticket?access_token=" + accessToken + "&type=jsapi";
        String ticketResult = HttpUtil.getHttpResponse(fetchJsApiTicketUrl, null);
        JSONObject ticketObject = JSONObject.fromObject(ticketResult);
        String ticket = ticketObject.getString("ticket");
        //生成signature
        String signature = "jsapi_ticket=" + ticket + "&noncestr=" + "Wm3WZYTPz0wzccnW" + "&timestamp=" + timestamp + "&url="+"http://www.efeiyi.com/wx/wxTest.do";
        System.out.println(signature);
        signature = StringUtil.encodePassword(signature, "SHA1");
        System.out.println("-------------------------------------------------------------------------");
        System.out.println(signature);
        System.out.println("-------------------------------------------------------------------------");
//        System.out.println();

        //@TODO 全局缓存
        return signature;
    }

    @RequestMapping({"/wxTest.do"})
    public String wxTest(HttpServletRequest request) {
        return "/wxTest";
    }


}