package com.efeiyi.ec.website.base.controller;

import com.efeiyi.ec.organization.model.Consumer;
import com.efeiyi.ec.organization.model.MyUser;
import com.efeiyi.ec.organization.model.Panel;
import com.efeiyi.ec.product.model.ProductModel;
import com.efeiyi.ec.tenant.model.BigTenant;
import com.efeiyi.ec.website.order.model.WxPayConfig;
import com.efeiyi.ec.website.organization.service.IConsumerService;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.p.model.WxCalledRecord;
import com.ming800.core.util.HttpUtil;
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
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by Administrator on 2016/11/22 0022.
 */
@Controller
public class YuanquController {


    @Autowired
    private BaseManager baseManager;

    @Autowired
    private IConsumerService consumerService;


    @RequestMapping({"/qrcode/sample/{dataType}/{dataId}"})
    public String appRedirectSampleUrl(@PathVariable String dataType, @PathVariable String dataId) throws Exception {
        String redirect = "";
        if (dataType.equals("0")) {
            BigTenant bigTenant = (BigTenant) baseManager.getObject(BigTenant.class.getName(), dataId);
            redirect = "http://www.efeiyi.com/app/tenant_details.html?tenantId=" + dataId + "&title=" + URLEncoder.encode(bigTenant.getName(), "utf-8");
        } else if (dataType.equals("1")) {
            ProductModel productModel = (ProductModel) baseManager.getObject(ProductModel.class.getName(), dataId);
            redirect = "http://www.efeiyi.com/app/product_details.html?productId=" + dataId + "&title=" + URLEncoder.encode(productModel.getName(), "utf-8");
        } else if (dataType.equals("2")) {
            Panel panel = (Panel) baseManager.getObject(Panel.class.getName(), dataId);
            redirect = "http://www.efeiyi.com/app/pannel_details.html.html?panelId=" + dataId + "&title=" + URLEncoder.encode(panel.getName(), "utf-8");
        }
        return "redirect:" + redirect;
    }


    @RequestMapping({"/wl"})
    public String login(HttpServletRequest request) throws Exception {
        String result;
        String redirect = request.getParameter("state");
        String code = request.getParameter("code");
        if (code == null || "".equals(code)) {
            return "redirect:http://www.efeiyi.com/qrcode/sample/" + URLDecoder.decode(redirect, "UTF-8");
        }
        String wxOpenIdUrl = "https://api.weixin.qq.com/sns/oauth2/access_token?appid=" + WxPayConfig.APPID + "&secret=" + WxPayConfig.APPSECRET + "&code=" + code + "&grant_type=authorization_code";
        result = HttpUtil.getHttpResponse(wxOpenIdUrl, null);
        JSONObject jsonObject = JSONObject.fromObject(result);
        String wxInfoUrl = "https://api.weixin.qq.com/sns/userinfo?access_token=" + jsonObject.getString("access_token") + "&openid=" + jsonObject.getString("openid") + "&lang=zh_CN";
        String userInfo = HttpUtil.getHttpResponse(wxInfoUrl, null);
        baseManager.saveOrUpdate(WxCalledRecord.class.getName(), new WxCalledRecord("wxInfo", userInfo, redirect));
        authenticate(userInfo);
        return "redirect:http://www.efeiyi.com/qrcode/sample/" + URLDecoder.decode(redirect, "UTF-8");
    }


    private MyUser authenticate(String userInfo) {
        JSONObject wxInfo = JSONObject.fromObject(userInfo);
        Consumer consumer = consumerService.getConsumerOrNullByUnionid(wxInfo.get("unionid").toString());
        MyUser myUser = consumerService.getMyUserOrNullByConsumer(consumer);
        if (myUser == null) {
            consumer = consumerService.saveOrUpdateConsumer(wxInfo.get("nickname").toString(), wxInfo.get("unionid").toString(), wxInfo.get("city").toString(), wxInfo.get("headimgurl").toString(), Integer.parseInt(wxInfo.get("sex").toString()));
            myUser = consumerService.getMyUserOrNullByConsumer(consumer);
        }
        try {
            AuthenticationManager am = new SampleAuthenticationManager();
            Authentication authentication = new UsernamePasswordAuthenticationToken(myUser, myUser.getPassword());
            Authentication result = am.authenticate(authentication);
            SecurityContextHolder.getContext().setAuthentication(result);
        } catch (Exception e) {
            return null;
        }
        return myUser;
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

}
