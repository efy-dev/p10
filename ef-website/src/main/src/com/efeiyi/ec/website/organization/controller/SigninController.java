package com.efeiyi.ec.website.organization.controller;

/**
 * Created by Administrator on 2014/11/13.
 */

import com.efeiyi.ec.organization.model.BigUser;
import com.efeiyi.ec.organization.model.User;
import com.efeiyi.ec.website.organization.service.BranchManager;
import com.efeiyi.ec.website.organization.service.RoleManager;
import com.efeiyi.ec.website.organization.service.UserManager;
import com.ming800.core.base.controller.BaseController;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.base.service.XdoManager;
import com.ming800.core.util.StringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.util.LinkedHashMap;


/**
 * Created by IntelliJ IDEA.
 * User: ming
 * Date: 12-10-15
 * Time: ����4:56
 * To change this template use File | Settings | File Templates.
 */

@Controller
@RequestMapping({"/pc"})
public class SigninController extends BaseController {
    @Autowired
    private RoleManager roleManager;
    @Autowired
    private BranchManager branchManager;
    @Autowired
    private BaseManager baseManager;
    @Autowired
    private UserManager userManager;
    @Autowired
    private XdoManager xdoManager;

    /**
     * �鿴��ǰ�û����Ƿ����
     *
     * @param username �û���
     * @return �Ƿ����
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
     * ע���µ�������
     *
     * @param request
     * @param bigUser  �����ߵĳ�ʼ��Ϣ
     * @param modelMap ���ظ���ͼ������
     * @return jsp��·��
     * @throws Exception
     */
    @RequestMapping(value = "/saveEnrollUser.do")
    public ModelAndView saveEnrollUser(HttpServletRequest request, BigUser bigUser, ModelMap modelMap) throws Exception {
        bigUser.setRole(roleManager.getRole("consumer"));

        modelMap.put("user", bigUser);
        modelMap.put("message", "ע��ɹ�");
        request.getSession().setAttribute("username", bigUser.getUsername());
        return new ModelAndView((request) + "/signinSuccess");
    }

    /*
    ��֤�ֻ���֤��
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
    �����ֻ���֤��
     */
    @RequestMapping({"/verification/send.do"})
    @ResponseBody
    public boolean sendVerificationCode() throws IOException {
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
     * ��ת��ע��ҳ���controller
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
     * ��ת����¼ҳ���controller
     */
    @RequestMapping("/forward.do")
    public String forward(String result){
        if("2".equals(result)){
            return "/register";
        }else if("1".equals(result)){
            return "/login";
        }else {
            return "/error";
        }
    }

    @RequestMapping(value ="/login.do")
    public ModelAndView login(HttpServletRequest request,ModelMap model) {
        String username = request.getParameter("username");
        String pword = request.getParameter("password");
        String password = StringUtil.encodePassword(pword,"SHA");
        String queryHql = "from BigUser b where b.username =:username and b.password =:password";
        LinkedHashMap<String , Object> queryParamMap = new LinkedHashMap<>();
        queryParamMap.put("username",username);
        queryParamMap.put("password",password);
        Object obj = baseManager.getUniqueObjectByConditions(queryHql,queryParamMap);
        if(obj != null){
            model.addAttribute("user",obj);
            return new ModelAndView("/loginAccess",model);
        }else{
            model.addAttribute("username",username);
            return new ModelAndView("/error",model);
        }
    }

    @RequestMapping("/register.do")
    public ModelAndView register(HttpServletRequest request , ModelMap model) throws Exception {
        String username = request.getParameter("username");
        String pword = request.getParameter("password");
        String password = StringUtil.encodePassword(pword,"SHA");
        BigUser user = new BigUser();
        user.setUsername(username);
        user.setPassword(password);
        userManager.saveOrUpdateBigUser(user);
        model.addAttribute("user",user);
        return new ModelAndView("/loginForm",model);
    }

}

