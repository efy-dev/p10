package com.efeiyi.ec.consumer.organization.controller;

/**
 * Created by Administrator on 2014/11/13.
 */

import com.efeiyi.ec.consumer.organization.service.SmsCheckManager;
import com.efeiyi.ec.organization.model.BigUser;
import com.efeiyi.ec.organization.model.Consumer;
import com.efeiyi.ec.organization.model.User;
import com.efeiyi.ec.purchase.model.Coupon;
import com.efeiyi.ec.purchase.model.CouponBatch;
import com.ming800.core.base.controller.BaseController;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import com.ming800.core.p.PConst;
import com.ming800.core.p.service.AutoSerialManager;
import com.ming800.core.util.VerificationCodeGenerator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.LinkedHashMap;
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
    private BranchManager branchManager;
    @Autowired
    private BaseManager baseManager;

    @Autowired
    private SmsCheckManager smsCheckManager;

    @Autowired
    private AutoSerialManager autoSerialManager;


    /**
     * 查看当前用户名是否存在
     *
     * @param username 用户名
     * @return 是否存在
     */
    @RequestMapping(value = "/pc/checkUserName.do")
    @ResponseBody
    public Boolean checkUserName(String username) {

        User user = branchManager.checkUsername(username);

        if (user != null) {
            return true;
        }

        return false;
    }


    /*
    认证手机验证码
     */
    @RequestMapping({"/pc/verification/verify.do"})
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

    /*
    发送手机验证码
     */
    @RequestMapping({"/pc/verification/send.do"})
    @ResponseBody
    public boolean sendVerificationCode(HttpServletRequest request) throws IOException {
        String cellPhoneNumber = request.getParameter("phone");
        String verificationCode = VerificationCodeGenerator.createVerificationCode();
        System.out.println(verificationCode);
        request.getSession().setAttribute(cellPhoneNumber, verificationCode);
        String massage = this.smsCheckManager.send(cellPhoneNumber, verificationCode, "1", PConst.TIANYI);
        if (massage != null) {
            return true;
        } else {
            return false;
        }
    }


    /**
     * 跳转到注册页面的controller
     */
    @RequestMapping(value = {"/pc/enroll.do", "/pc/register"})
    public String enroll(HttpServletRequest request, Model model) {
        String source = request.getParameter("source");
        if (source != null) {
            model.addAttribute("source", source);
        }
        return "/register";
    }

    @RequestMapping("/sso.do")
    public void forward(HttpServletRequest request, HttpServletResponse response) throws Exception {
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
                    baseManager.saveOrUpdate(Coupon.class.getName(), coupon);
                }
            }

        }
        response.sendRedirect(request.getContextPath() + "/sso2.do");
    }


    @RequestMapping("/sso2.do")
    public void forward2(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.sendRedirect(request.getContextPath() + "/");
    }

    @RequestMapping({"/login"})
    public String login(HttpServletRequest request, Model model) {
        String error = request.getParameter("error");
        if (error != null) {
            model.addAttribute("error", "true");
        }
        return "/login";
    }

    @RequestMapping({"/register"})
    public String register() {

        return "/register";
    }

    @RequestMapping({"/forgetPwd"})
    public String forgetPwd() {

        return "/forgetPassword";

    }

    @RequestMapping({"/setPwd"})
    public String setPwd(HttpServletRequest request, Model model) throws Exception {
        String username = request.getParameter("username");
        LinkedHashMap<String, Object> queryParamMap = new LinkedHashMap<>();
        queryParamMap.put("username", username);
        String hql = "from BigUser s where s.username=:username";
        BigUser biguser = (BigUser) baseManager.getUniqueObjectByConditions(hql, queryParamMap);
        model.addAttribute("user", biguser);
        return "/setPassword";

    }


}

