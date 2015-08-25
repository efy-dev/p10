package com.efeiyi.ec.system.organization.controller;

import com.efeiyi.ec.system.organization.service.SignManager;
import com.efeiyi.ec.tenant.model.Tenant;
import com.ming800.core.base.controller.BaseController;
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
    public String Register(Tenant tenant,Model model,String tenantType){
        try {
            model.addAttribute("username",tenant.getUsername());
            signManager.tenantRegister(tenant,tenantType);
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

}
