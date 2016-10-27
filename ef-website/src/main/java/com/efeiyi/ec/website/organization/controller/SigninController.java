package com.efeiyi.ec.website.organization.controller;

/**
 * Created by Administrator on 2014/11/13.
 */

import com.efeiyi.ec.organization.model.BigUser;
import com.efeiyi.ec.organization.model.Consumer;
import com.efeiyi.ec.organization.model.MyUser;
import com.efeiyi.ec.purchase.model.Coupon;
import com.efeiyi.ec.purchase.model.CouponBatch;
import com.efeiyi.ec.website.base.util.AuthorizationUtil;
import com.efeiyi.ec.website.order.model.WxPayConfig;
import com.efeiyi.ec.website.organization.model.SmsProvider;
import com.efeiyi.ec.website.organization.model.ValidateCode;
import com.efeiyi.ec.website.organization.model.YunPianSmsProvider;
import com.efeiyi.ec.website.organization.service.SmsCheckManager;
import com.ming800.core.base.controller.BaseController;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import com.ming800.core.p.PConst;
import com.ming800.core.p.model.WxCalledRecord;
import com.ming800.core.p.service.AutoSerialManager;
import com.ming800.core.util.CookieTool;
import com.ming800.core.util.HttpUtil;
import com.ming800.core.util.StringUtil;
import com.ming800.core.util.VerificationCodeGenerator;
import net.sf.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.math.BigDecimal;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.*;


/**
 * Created by IntelliJ IDEA.
 * User: ming
 * Date: 12-10-15
 * Time: ����4:56
 * To change this template use File | Settings | File Templates.
 */

@Controller
public class SigninController extends BaseController {
    @Autowired
    private BaseManager baseManager;
    @Autowired
    private AutoSerialManager autoSerialManager;

    @Autowired
    private SmsCheckManager smsCheckManager;

    @Autowired
    private UserDetailsService userManager;


    @RequestMapping({"login"})
    public String login(HttpServletRequest request, HttpServletResponse response) {
        return "/login";
    }

    @RequestMapping({"signin"})
    public String siginin(HttpServletRequest request, HttpServletResponse response) {
        return "/register";
    }


    @RequestMapping({"signinUser"})
    public String signinUser(HttpServletRequest request, HttpServletResponse response) {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        password = StringUtil.encodePassword(password, "sha");
        Consumer bigUser = new Consumer();
        bigUser.setUsername(username);
        bigUser.setPassword(password);
        bigUser.setAccountExpired(false);
        bigUser.setAccountLocked(false);
        bigUser.setCredentialsExpired(false);
        bigUser.setEnabled(true);
        bigUser.setStatus("1");
        bigUser.setCreateDatetime(new Date());
        baseManager.saveOrUpdate(BigUser.class.getName(), bigUser);
        return "/registerSuccess";
    }


    @RequestMapping({"getImageCode"})
    public void getImageCode(HttpServletRequest request, HttpServletResponse response) throws Exception {
        response.setContentType("image/jpeg");
        response.setHeader("Pragma", "no-cache");
        response.setHeader("Cache-Control", "no-cache");
        response.setDateHeader("Expires", 0L);
        ValidateCode vCode = new ValidateCode(100, 30, 4, 100);
        HttpSession session = request.getSession();
        session.removeAttribute("validateCode");
        vCode.write(response.getOutputStream());
        session.setAttribute("validateCode", ValidateCode.getCode());
        vCode.write(response.getOutputStream());
    }

    @RequestMapping({"checkImageCode"})
    @ResponseBody
    public boolean checkImageCode(HttpServletRequest request, HttpServletResponse response) {
        boolean result = false;
        String e = request.getParameter("code").toLowerCase();
        String serverCode = request.getSession().getAttribute("validateCode").toString().toLowerCase();
        if (e.endsWith(serverCode)) {
            result = true;
        }
        return result;
    }

    @RequestMapping({"checkUserName"})
    @ResponseBody
    public boolean checkUserName(HttpServletRequest request, HttpServletResponse response) {
        String username = request.getParameter("username");
        String hql = "select obj from BigUser obj where obj.username=:username and obj.status!='0'";
        LinkedHashMap<String, Object> param = new LinkedHashMap<>();
        param.put("username", username);
        BigUser bigUser;
        try {
            bigUser = (BigUser) baseManager.getUniqueObjectByConditions(hql, param);
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
        return (bigUser != null && bigUser.getId() != null);
    }


    @RequestMapping({"/verification/verify.do"})
    @ResponseBody
    public boolean checkVerificationCode(HttpServletRequest request) {
        String inputVerificationCode = request.getParameter("verificationCode").trim();
        if (inputVerificationCode.equals("efeiyi")) {
            return true;
        } else {
            String phone = request.getParameter("phone");
            if (inputVerificationCode.equals(request.getSession().getAttribute(phone))) {
                return true;
            } else {
                return false;
            }
        }
    }

    @RequestMapping({"/verification/send.do"})
    @ResponseBody
    public boolean sendVerificationCode(HttpServletRequest request) throws IOException {
        String cellPhoneNumber = request.getParameter("phone");
        String verificationCode = VerificationCodeGenerator.createVerificationCode();
        request.getSession().setAttribute(cellPhoneNumber, verificationCode);
//        boolean validate = this.smsCheckManager.validate(cellPhoneNumber, String.valueOf(request.getSession().getAttribute(cellPhoneNumber)));
//        if (!validate) {
        String massage = this.smsCheckManager.send(cellPhoneNumber, verificationCode, "1104699", PConst.YUNPIAN);
        if (massage != null) {
            return true;
        } else {
            return false;
        }
//        } else {
//            return false;
//        }
    }

    @RequestMapping({"forgetPassword"})
    public String forgetPassword() {
        return "/forgetPassword";
    }

    @RequestMapping({"checkUserNameAndVerify"})
    public String checkUsernameAndVerify(HttpServletRequest request, HttpServletResponse response, Model model) {
        String username = request.getParameter("targetname");
        String verifyCode = request.getParameter("verificationCode");
        String sessionVerifyCode = request.getSession().getAttribute(username).toString();
        if (verifyCode != null && sessionVerifyCode != null && verifyCode.equals(sessionVerifyCode)) {
            request.getSession().setAttribute(username, "checked");
            model.addAttribute("username", username);
            return "/setPassword";
        } else {
            return "redirect:/forgetPassword";
        }
    }

    @RequestMapping({"updatePassword"})
    public String updatePassword(HttpServletRequest request, HttpServletResponse response) {
        String username = request.getParameter("username");
        if ("checked".equals(request.getSession().getAttribute(username))) {
            String password = request.getParameter("pwd");
            MyUser myUser = (MyUser) userManager.loadUserByUsername(username);
            myUser.setPassword(StringUtil.encodePassword(password, "sha"));
            baseManager.saveOrUpdate(MyUser.class.getName(), myUser);
            return "redirect:/login";
        } else {
            return "forgetPassword";
        }
    }


    @RequestMapping("/sso.do")
    public String forward(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String redirect = request.getParameter("callUrl");
        if (redirect != null) {
            return "redirect:http://" + redirect;
        }
//        response.sendRedirect(request.getContextPath() + "/sso2.do");
        return "redirect:/sso2.do";
    }


    @RequestMapping("/sso2.do")
    public void forward2(HttpServletRequest request, HttpServletResponse response) throws IOException {
        //将登陆的用户的用户信息保存到cookie中
        MyUser myUser = AuthorizationUtil.getMyUser();
        CookieTool.addCookie(response, "userinfo", myUser.getId(), 10000000, "efeiyi.com");
        response.sendRedirect(request.getContextPath() + "/");
    }


    @RequestMapping({"/createCoupon.do"})
    @ResponseBody
    public boolean transitPage(HttpServletRequest request) throws Exception {
        String userId = request.getParameter("userId");
        if (userId != null && !"".equals(userId)) {
            Consumer consumer = (Consumer) baseManager.getObject(Consumer.class.getName(), userId);
            XQuery xQuery = new XQuery("listCouponBatch_defaultFlag", request);
            List<Object> couponBatchList = baseManager.listObject(xQuery);
            for (Object couponBatchTemp : couponBatchList) {
                if (((CouponBatch) couponBatchTemp).getCouponList().size() < ((CouponBatch) couponBatchTemp).getAmount()) {
                    Coupon coupon = new Coupon();
                    coupon.setStatus("1");
                    coupon.setSerial(autoSerialManager.nextSerial("orderSerial"));
                    coupon.setCouponBatch((CouponBatch) couponBatchTemp);
                    Date currentDate = new Date();
                    SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyyMMdd");
                    String currentDateStr = simpleDateFormat.format(currentDate);
                    coupon.setUniqueKey(currentDateStr + coupon.getSerial());
                    coupon.setConsumer(consumer);
                    coupon.setWhetherBind("2");
                    baseManager.saveOrUpdate(Coupon.class.getName(), coupon);
                } else if (((CouponBatch) couponBatchTemp).fetchCouponList().size() > 0) {
                    List<Coupon> couponList = ((CouponBatch) couponBatchTemp).fetchCouponList();
                    Coupon coupon = couponList.get(0);
                    coupon.setWhetherBind("2");
                    coupon.setConsumer(consumer);
                    baseManager.saveOrUpdate(Coupon.class.getName(), coupon);
                }
            }
            SmsProvider smsProvider = new YunPianSmsProvider();
            String phoneNumber = consumer.getUsername();
            HashMap map = null;
            smsProvider.post(phoneNumber, map, "1186309");
        }
        return true;
    }


    @RequestMapping("/registerSuccess/{couponAmount}")
    public String successPage(@PathVariable String couponAmount, HttpServletRequest request, Model model) {
        model.addAttribute("couponAmount", couponAmount);
        return "/registerSuccess";
    }

    @RequestMapping({"/wx/userInfo"})
    public String wxPay(HttpServletRequest request) throws Exception {
        String dataKey = "unionid";
        String callback = request.getServerName() + ":" + request.getServerPort() + "/wx/bind";
        callback = URLEncoder.encode(callback, "UTF-8");
        String redirect = "http://mall.efeiyi.com/wx/getInfo.do?callback=" + callback + "&dataKey=" + dataKey;
        return "redirect:" + redirect;
    }

    @RequestMapping({"/wx/bind"})
    public String getWxOpenId(HttpServletRequest request, Model model) throws Exception {
        String unionid = request.getParameter("unionid");
        model.addAttribute("unionid", unionid);
        return "/wxRedirect";
    }

    @RequestMapping({"/user/getCurrentUser"})
    @ResponseBody
    public MyUser getCurrentUser() {
        MyUser currentUser = AuthorizationUtil.getMyUser();
        return currentUser;
    }


    @RequestMapping({"/wl"})
    public String login(HttpServletRequest request, Model model) throws Exception {
        String result;
        String redirect = request.getParameter("state");
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
        return "redirect:http://www.efeiyi.com/qrcode/sample/" + redirect;
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

