package com.efeiyi.ec.website.organization.controller;

/**
 * Created by Administrator on 2014/11/13.
 */

import com.efeiyi.ec.organization.model.Consumer;
import com.efeiyi.ec.organization.model.MyUser;
import com.efeiyi.ec.purchase.model.Coupon;
import com.efeiyi.ec.purchase.model.CouponBatch;
import com.efeiyi.ec.website.organization.model.SmsProvider;
import com.efeiyi.ec.website.organization.model.YunPianSmsProvider;
import com.efeiyi.ec.website.base.util.AuthorizationUtil;
import com.ming800.core.base.controller.BaseController;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import com.ming800.core.p.service.AutoSerialManager;
import com.ming800.core.util.CookieTool;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;


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
        CookieTool.addCookie(response, "userinfo", myUser.getId(), 10000000, ".efeiyi.com");
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
            String phoneNumber  =  consumer.getUsername();
            HashMap map = null;
            smsProvider.post(phoneNumber,map,"1186309");
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
        String redirect = "http://www.efeiyi.com/wx/getInfo.do?callback=" + callback + "&dataKey=" + dataKey;
        return "redirect:" + redirect;
    }

    @RequestMapping({"/wx/bind"})
    public String getWxOpenId(HttpServletRequest request, Model model) throws Exception {
        String unionid = request.getParameter("unionid");
        model.addAttribute("unionid", unionid);
        return "/wxRedirect";
    }


}

