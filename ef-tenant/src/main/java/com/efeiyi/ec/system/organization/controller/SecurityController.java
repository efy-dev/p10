package com.efeiyi.ec.system.organization.controller;

import com.efeiyi.ec.organization.model.MyUser;
import com.efeiyi.ec.system.organization.util.AuthorizationUtil;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

/**
 * Created by Administrator on 2015/7/14.
 */
@Controller
public class SecurityController {


    @RequestMapping({"/login.do"})
    public String login(HttpServletRequest request,Model model){
        model.addAttribute("username",request.getParameter("username"));
        return "/login";

    }

    @RequestMapping({"/main.do"})
    public String main(Model model,HttpServletRequest request){
        if(AuthorizationUtil.getMyUser().getBigTenant()==null){
            model.addAttribute("review","1");
        }else {
            model.addAttribute("review", AuthorizationUtil.getMyUser().getBigTenant().getReview());
            model.addAttribute("TENANT", AuthorizationUtil.getMyUser().getBigTenant());
        }

        return "/main";
    }

}
