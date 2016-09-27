package com.efeiyi.ec.website.organization.controller;

import com.efeiyi.ec.organization.model.Consumer;
import com.efeiyi.ec.organization.model.MyUser;
import com.efeiyi.ec.website.base.util.AuthorizationUtil;
import com.efeiyi.ec.website.order.model.WxPayConfig;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.p.model.WxCalledRecord;
import com.ming800.core.util.HttpUtil;
import com.ming800.core.util.StringUtil;
import net.sf.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.math.BigDecimal;
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
        String redirect_uri = "http://mall.efeiyi.com/wx/fetchUserInfo/" + dataKey + "/" + callback;
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
        String redirect_uri = "http://mall.efeiyi.com/wx/fetchBaseUserInfo.do?dataKey=" + dataKey + "&callback=" + callback;
        String url = "https://open.weixin.qq.com/connect/oauth2/authorize?" +
                "appid=" + WxPayConfig.APPID +
                "&redirect_uri=" +
                URLEncoder.encode(redirect_uri, "UTF-8") +
                "&response_type=code&scope=snsapi_userinfo&state=123#wechat_redirect";
        return "redirect:" + url;
    }

    @RequestMapping({"/fetchLoginCode.do"})
    public String getWxLoginCode(HttpServletRequest request) throws Exception {
        String redirect = request.getParameter("redirect");
        String redirect_uri = "http://mall.efeiyi.com/wx/login.do?redirect=" + redirect;
        String url = "https://open.weixin.qq.com/connect/oauth2/authorize?" +
                "appid=" + WxPayConfig.APPID +
                "&redirect_uri=" +
                URLEncoder.encode(redirect_uri, "UTF-8") +
                "&response_type=code&scope=snsapi_userinfo&state=123#wechat_redirect";
        return "redirect:" + url;
    }


    @RequestMapping({"/fetchUserInfo/{dataKey}/{callback}"})
    public String getUserInfo(HttpServletRequest request, Model model, @PathVariable String dataKey, @PathVariable String callback) throws Exception {
        String result;
        String code = request.getParameter("code");
        if (request.getSession().getAttribute(code) != null) {
            result = request.getSession().getAttribute(code).toString();
        } else {
            String urlForOpenId = "https://api.weixin.qq.com/sns/oauth2/access_token?appid=" + WxPayConfig.APPID + "&secret=" + WxPayConfig.APPSECRET + "&code=" + code + "&grant_type=authorization_code";
            result = HttpUtil.getHttpResponse(urlForOpenId, null);
            request.getSession().setAttribute(code, result);
        }
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


    @RequestMapping({"/fetchBaseUserInfo.do"})
    public String getUserBaseInfo(HttpServletRequest request, Model model) throws Exception {
        String result;
        String dataKey = request.getParameter("dataKey");
        String callback = request.getParameter("callback");
        String code = request.getParameter("code");
        if (request.getSession().getAttribute(code) != null) {
            result = request.getSession().getAttribute(code).toString();
        } else {
            String urlForOpenId = "https://api.weixin.qq.com/sns/oauth2/access_token?appid=" + WxPayConfig.APPID + "&secret=" + WxPayConfig.APPSECRET + "&code=" + code + "&grant_type=authorization_code";
            result = HttpUtil.getHttpResponse(urlForOpenId, null);
            request.getSession().setAttribute(code, result);
        }
        JSONObject jsonObject = JSONObject.fromObject(result);
        if (jsonObject.containsKey("errcode")) {
            throw new RuntimeException("get openId error：" + result);
        }
        String access_token = jsonObject.getString("access_token");
        String openid = jsonObject.getString("openid");

        WxCalledRecord wxCalledRecord = (WxCalledRecord) baseManager.getObject(WxCalledRecord.class.getName(), callback);
        wxCalledRecord.setAccessToken(access_token);
        String callbackUrl = URLDecoder.decode(wxCalledRecord.getCallback(), "UTF-8");

        String urlForOpenId = "https://api.weixin.qq.com/sns/userinfo?access_token=" + access_token + "&openid=" + openid + "&lang=zh_CN";
        String userInfo = HttpUtil.getHttpResponse(urlForOpenId, null);
        JSONObject userJsonObject = JSONObject.fromObject(userInfo);

        String[] keyArray = dataKey.split(";");
        String data = "";
        for (String key : keyArray) {
            String value = userJsonObject.getString(key);
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
        return "redirect:" + callbackUrl;
    }


    @RequestMapping({"/login.do"})
    public String login(HttpServletRequest request, Model model) throws Exception {
        String result;
        String redirect = request.getParameter("redirect");
        String code = request.getParameter("code");
        if (request.getSession().getAttribute(code) != null) {
            result = request.getSession().getAttribute(code).toString();
        } else {
            String urlForOpenId = "https://api.weixin.qq.com/sns/oauth2/access_token?appid=" + WxPayConfig.APPID + "&secret=" + WxPayConfig.APPSECRET + "&code=" + code + "&grant_type=authorization_code";
            result = HttpUtil.getHttpResponse(urlForOpenId, null);
            request.getSession().setAttribute(code, result);
        }
        JSONObject jsonObject = JSONObject.fromObject(result);
        if (jsonObject.containsKey("errcode")) {
            throw new RuntimeException("get openId error：" + result);
        }
        String access_token = jsonObject.getString("access_token");
        String openid = jsonObject.getString("openid");

        String urlForOpenId = "https://api.weixin.qq.com/sns/userinfo?access_token=" + access_token + "&openid=" + openid + "&lang=zh_CN";
        String userInfo = HttpUtil.getHttpResponse(urlForOpenId, null);
        JSONObject userJsonObject = JSONObject.fromObject(userInfo);

        String nickname = userJsonObject.get("nickname").toString();
        String sex = userJsonObject.get("sex").toString();
        String city = userJsonObject.get("city").toString();
        String headimgurl = userJsonObject.get("headimgurl").toString();
        String unionid = userJsonObject.get("unionid").toString();
        MyUser myUser = authenticate(unionid);
        WxCalledRecord wxCalledRecord = new WxCalledRecord();
        wxCalledRecord.setCallback(redirect);
        wxCalledRecord.setDataKey("unionid");
        wxCalledRecord.setData(unionid);
        wxCalledRecord.setCreateDatetime(new Date());
        baseManager.saveOrUpdate(WxCalledRecord.class.getName(), wxCalledRecord);
        if (myUser == null) {
            Consumer consumer;
            LinkedHashMap<String, Object> param = new LinkedHashMap<>();
            param.put("unionid", unionid);
            try {
                consumer = (Consumer) baseManager.getUniqueObjectByConditions("select obj from " + Consumer.class.getName() + " obj where obj.unionid=:unionid and obj.status!='0'", param);
            } catch (Exception e) {
                consumer = (Consumer) baseManager.listObject("select obj from " + Consumer.class.getName() + " obj where obj.unionid=:unionid and obj.status!='0'", param).get(0);
            }
            if (consumer == null) {
                consumer = new Consumer();
            }
            consumer.setUnionid(unionid);
            consumer.setName(nickname);
            consumer.setUsername(unionid);
            consumer.setPassword(StringUtil.encodePassword(nickname, "sha"));
            consumer.setCreateDatetime(new Date(System.currentTimeMillis()));
            consumer.setStatus("1");
            consumer.setBalance(new BigDecimal(0));
            consumer.setAccountExpired(false);
            consumer.setAccountLocked(false);
            consumer.setCredentialsExpired(false);
            consumer.setEnabled(true);
            consumer.setCityName(city);
            consumer.setPictureUrl(headimgurl);
            consumer.setSex(Integer.parseInt(sex));
            baseManager.saveOrUpdate(Consumer.class.getName(), consumer);
            authenticate(unionid);
        }
        redirect = URLDecoder.decode(redirect, "UTF-8");
        return "redirect:" + redirect;
    }


    private MyUser authenticate(String unionid) {
        MyUser myUser;
        System.out.println(AuthorizationUtil.isAuthenticated());
        LinkedHashMap<String, Object> param = new LinkedHashMap<>();
        param.put("unionid", unionid);
        Consumer consumer = null;
        try {
            consumer = (Consumer) baseManager.getUniqueObjectByConditions("select obj from " + Consumer.class.getName() + " obj where obj.unionid=:unionid and obj.status!='0'", param);
        } catch (Exception e) {
            consumer = (Consumer) baseManager.listObject("select obj from " + Consumer.class.getName() + " obj where obj.unionid=:unionid and obj.status!='0'", param).get(0);
        }
        if (consumer != null) {
            myUser = (MyUser) baseManager.getObject(MyUser.class.getName(), consumer.getId());
        } else {
            return null;
        }
        AuthenticationManager am = new SampleAuthenticationManager();
        try {
            Authentication authentication = new UsernamePasswordAuthenticationToken(myUser, myUser.getPassword());
            Authentication result = am.authenticate(authentication);
            SecurityContextHolder.getContext().setAuthentication(result);
        } catch (AuthenticationException e) {
            System.out.println("Authentication failed: " + e.getMessage());
        }
        return myUser;
    }


    @RequestMapping({"/authenticate.do"})
    @ResponseBody
    public MyUser authenticate(HttpServletRequest request) {
        String unionid = request.getParameter("unionid");
        return authenticate(unionid);
    }

    private static class SampleAuthenticationManager implements AuthenticationManager {
        static final List<GrantedAuthority> AUTHORITIES = new ArrayList<>();

        static {
            AUTHORITIES.add(new SimpleGrantedAuthority("ROLE_USER"));
        }

        public Authentication authenticate(Authentication auth) throws AuthenticationException {
            return new UsernamePasswordAuthenticationToken(auth.getPrincipal(),
                    auth.getCredentials(), AUTHORITIES);
        }
    }


    /**
     * 获取微信用户的身份信息，该操作不用授权 （参数同获取基本信息的接口一样）
     *
     * @param request
     * @return
     */
    @RequestMapping({"/getInfo.do"})
    public String getWxInfo(HttpServletRequest request) {
        String callback = request.getParameter("callback"); //mall.efeiyi.com   mall.efeiyi.com?name=xxxx
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

    /**
     * 获取微信用户的基本信息（昵称头像之类的 需要用户授权给公众账号）
     *
     * @param request
     * @return
     */
    @RequestMapping({"/getUserBaseInfo.do"})
    public String getWxBaseInfo(HttpServletRequest request) {
        String callback = request.getParameter("callback"); //回掉接口，接口中直接获取需要的参数即可（注：不需要带http前缀；需要URLEncode一下）
        String dataKey = request.getParameter("dataKey"); //需要从微信中获取的数据的key 例如 nickname
        String requestSource = request.getParameter("source");  //请求来源（没有可以不传）
        String consumerId = request.getParameter("consumerId"); //当前微信用户对应的efeiyi用户，如果没有可以不传
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


    /**
     * 初始化微信签名（jssdk）
     *
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping({"/init.do"})
    @ResponseBody
    public String initWxConfig(HttpServletRequest request) throws Exception {
        String timestamp = request.getParameter("timestamp"); //时间戳
        String nonceStr = request.getParameter("nonceStr");  //随机字符串
        String callUrl = request.getParameter("callUrl");  //访问接口的当前页面请求路径
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
        signature = StringUtil.encodePassword(signature, "SHA1");
        return signature;
    }

    @RequestMapping({"/wxTest.do"})
    public String wxTest(HttpServletRequest request) {
        return "/wxTest";
    }


}