package com.efeiyi.ec.website.organization.controller;

import com.efeiyi.ec.website.order.service.WxPayConfig;
import com.ming800.core.util.HttpUtil;
import net.sf.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import java.net.URLDecoder;
import java.net.URLEncoder;

/**
 * Created by Administrator on 2015/11/25 0025.
 */
@Controller
@RequestMapping({"/wx"})
public class WxController {

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

    @RequestMapping({"/fetchUserInfo/{dataKey}/{callback}"})
    public String getUserInfo(HttpServletRequest request, Model model, @PathVariable String dataKey, @PathVariable String callback) throws Exception {
        String callbackUrl = URLDecoder.decode(callback, "UTF-8");
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
        if (callbackUrl.contains("?")) {
            callbackUrl += "&" + dataKey + "=" + value;
        } else {
            callbackUrl += "?" + dataKey + "=" + value;
        }
        return "redirect:" + callbackUrl;
    }

    @RequestMapping({"/getInfo.do"})
    public String getWxInfo(HttpServletRequest request) {
        String callback = request.getParameter("callback");
        String dataKey = request.getParameter("dataKey");
        String redirect = "/wx/fetchCode.do?callback=" + callback + "&dataKey=" + dataKey;
        return "redirect:" + redirect;
    }

}
