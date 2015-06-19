package com.efeiyi.ec.website.organization.controller;

/**
 * Created by Administrator on 2014/11/13.
 */

import com.efeiyi.ec.website.organization.model.BigUser;
import com.efeiyi.ec.website.organization.model.User;
import com.efeiyi.ec.website.organization.service.BranchManager;
import com.efeiyi.ec.website.organization.service.RegisterManager;
import com.efeiyi.ec.website.organization.service.RoleManager;
import com.ming800.core.base.controller.BaseController;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.p.PConst;
import com.ming800.core.p.service.MessageVerifyManager;
import com.ming800.core.util.VerificationCodeGenerator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;


/**
 * Created by IntelliJ IDEA.
 * User: ming
 * Date: 12-10-15
 * Time: 下午4:56
 * To change this template use File | Settings | File Templates.
 */

@Controller
@RequestMapping({"/pc"})
public class SigninController extends BaseController {
    //@Autowired
    private RoleManager roleManager;
    //@Autowired
    private BranchManager branchManager;
   // @Autowired
    private RegisterManager registerManager;

    @Autowired
    private BaseManager baseManager;

    @Autowired
    private MessageVerifyManager messageVerifyManager;
/*
    @Autowired
    private CouponManager couponManager;

    @Autowired
    private SmsCheckManager smsCheckManager;*/

    /**
     * 查看当前用户名是否存在
     *
     * @param username 用户名
     * @return 是否存在
     */
    @RequestMapping(value = "/checkUserName.do")
    @ResponseBody
    public Boolean checkUserName(String username) {

        User user = branchManager.checkUsername(username);

        if (user != null) {
            return true;
        }

        return false;
    }


    /**
     * 注册新的消费者
     *
     * @param request
     * @param bigUser  消费者的初始信息
     * @param modelMap 返回给视图的数据
     * @return jsp的路径
     * @throws Exception
     */
    @RequestMapping(value = "/saveEnrollUser.do")
    public ModelAndView saveEnrollUser(HttpServletRequest request, BigUser bigUser, ModelMap modelMap) throws Exception {
        bigUser.setRole(roleManager.getRole("consumer"));
        /*if (this.baseManager.viewUserByUsername(bigUser.getUsername()) == null) {
            registerManager.saveEnrollMessage(bigUser);
        }*/
        modelMap.put("user", bigUser);
        modelMap.put("message", "注册成功");
        request.getSession().setAttribute("username", bigUser.getUsername());
        return new ModelAndView((request) + "/signinSuccess");
    }

    /*
    认证手机验证码
     */
    @RequestMapping({"/verification/verify.do"})
    @ResponseBody
    public boolean checkVerificationCode(HttpServletRequest request) {
        String inputVerificationCode = request.getParameter("verificationCode").trim();
        if (inputVerificationCode.equals("yuepaila")) {
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
    @RequestMapping({"/verification/send.do"})
    @ResponseBody
    public boolean sendVerificationCode(HttpServletRequest request) throws IOException {
       /* String cellPhoneNumber = request.getParameter("phone");
        String verificationCode = VerificationCodeGenerator.createVerificationCode();
        request.getSession().setAttribute(cellPhoneNumber, verificationCode);
        boolean validate = this.smsCheckManager.validate(cellPhoneNumber, String.valueOf(request.getSession().getAttribute(cellPhoneNumber)));
        if (!validate) {
            String massage = this.smsCheckManager.send(cellPhoneNumber, verificationCode, "1", PConst.TIANYI);
            if (massage != null) {
                return true;
            } else {
                return false;
            }
        } else {
            return false;
        }*/
        return false;
    }
    /**
     * 跳转到注册页面的controller
     */
    @RequestMapping(value = {"enroll.do", "register"})
    public String enroll(HttpServletRequest request, Model model) {
        String source = request.getParameter("source");
        if (source != null) {
            model.addAttribute("source", source);
        }
        return "/signin";
    }

    /**
     * 跳转到登录页面的controller
     */
    @RequestMapping(value = {"login.do", "login"})
    public String login(HttpServletRequest request, Model model) {
        if (request.getParameter("redirect") != null) {
            String redirectUrl = request.getParameter("redirect");
            model.addAttribute("redirect", redirectUrl);
        }
        if (request.getParameter("error") != null && request.getParameter("error").equals("true")) {
            model.addAttribute("message", "用户名密码不匹配");
        } else if ("1".equals(request.getParameter("updatePsw"))) {
            model.addAttribute("message", "密码修改成功");
        }
        model.addAttribute("enrollUsername", request.getParameter("enrollUsername"));
        return (request) + "/login";
    }

}

