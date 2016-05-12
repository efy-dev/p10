package com.efeiyi.ec.personal.master.controller;

/**
 * Created by Administrator on 2014/11/13.
 */

import com.efeiyi.ec.organization.model.MyUser;
import com.efeiyi.ec.organization.model.Professional;
import com.efeiyi.ec.personal.AuthorizationUtil;
import com.efeiyi.ec.personal.master.service.SignManager;
import com.ming800.core.base.controller.BaseController;
import com.ming800.core.util.StringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;


/**
 * Created by IntelliJ IDEA.
 * User: ming
 * Date: 12-10-15
 * Time: ����4:56
 * To change this template use File | Settings | File Templates.
 */

@Controller
@RequestMapping("/sign")
public class   SigninController extends BaseController {
    @Autowired
    private SignManager signManager;

    /**
     * 判断注册还是登陆
     * 跳转注册页面
     */
    @RequestMapping("/toRegister.do")
    public String forward(String result) {

        return "/register";
    }

    @RequestMapping("/Register.do")
    public String Register(Professional professional, Model model){
        try {
            model.addAttribute("username",professional.getUsername());
            signManager.tenantRegister(professional);
        }catch (Exception e){
            e.printStackTrace();
            System.out.print("注册失败!");
        }
        return  "/login";
    }

    @RequestMapping("/checkUsername.do")
    @ResponseBody
    public boolean checkUsername(String username){

        boolean flag = true;
        try{
            flag = signManager.checkUsername(username);
        }catch (Exception e){
            e.printStackTrace();
        }
        return  flag;
    }

    @RequestMapping("/toChangePassword.do")
    public String toChangePassword(Model model){
        MyUser user = AuthorizationUtil.getMyUser();
        model.addAttribute("userId",user.getId());
        return  "/changePassword";
    }

    @RequestMapping("/checkPassword.do")
    @ResponseBody
    public boolean checkPassword(String password){
        String s = StringUtil.encodePassword(password,"sha");
        MyUser user = AuthorizationUtil.getMyUser();

        boolean flag = true;
        if(!s.equals(user.getPassword())){
            flag = false;
        }

        return  flag;
    }

    @RequestMapping("/SavePassword.do")
    @ResponseBody
    public boolean SavePassword(String password){
        String s = StringUtil.encodePassword(password,"sha");
        MyUser user = AuthorizationUtil.getMyUser();
        boolean flag = true;
        try {
            user.setPassword(s);
            baseManager.saveOrUpdate(MyUser.class.getName(),user);
        }catch (Exception e){
            flag = false;
        }
        return  flag;
    }

    @RequestMapping("/sso.do")
    public String forward(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String  callUrl = request.getParameter("callUrl");
        String  userId = request.getParameter("userId");
        if(callUrl!=null && !"".equals(callUrl)){
            return "redirect:" + callUrl;
        }
        if(AuthorizationUtil.getMyUser()==null || AuthorizationUtil.getMyUser().getId() == null){
            //response.sendRedirect(request.getContextPath() + "/sso2.do");
            return "redirect:/sso2.do";
        }else{
            return "redirect:"+request.getContextPath();
        }

    }
    @RequestMapping("/sso2.do")
    public void forward2(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.sendRedirect(request.getContextPath() + "/");
    }
}

