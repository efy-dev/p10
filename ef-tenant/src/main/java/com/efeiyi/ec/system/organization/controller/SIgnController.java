package com.efeiyi.ec.system.organization.controller;

import com.efeiyi.ec.organization.model.MyUser;
import com.efeiyi.ec.organization.model.Professional;
import com.efeiyi.ec.system.organization.service.SignManager;
import com.efeiyi.ec.system.organization.util.AuthorizationUtil;
import com.efeiyi.ec.tenant.model.Tenant;
import com.ming800.core.base.controller.BaseController;
import com.ming800.core.util.StringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * Created by IntelliJ IDEA.
 * User: ming
 * Date: 12-10-15
 * Time: 下午4:56
 * To change this template use File | Settings | File Templates.
 */

@Controller
@RequestMapping("/sign")
public class SIgnController extends BaseController {


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
    public String Register(Professional professional,Model model,String tenantType){
        try {
            model.addAttribute("username",professional.getUsername());
            signManager.tenantRegister(professional,tenantType);
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

}
