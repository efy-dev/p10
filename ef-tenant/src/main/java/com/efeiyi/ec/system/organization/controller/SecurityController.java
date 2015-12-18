package com.efeiyi.ec.system.organization.controller;

import com.efeiyi.ec.organization.model.MyUser;
import com.efeiyi.ec.system.organization.util.AuthorizationUtil;
import com.efeiyi.ec.tenant.model.TenantReview;
import com.ming800.core.base.dao.XdoDao;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * Created by Administrator on 2015/7/14.
 */
@Controller
public class SecurityController {

    @Autowired
    private BaseManager baseManager;

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
            try {
                XQuery xQuery = new XQuery("listTenantReview_default",request);
                List<TenantReview> tenantReviewList = baseManager.listObject(xQuery);
                model.addAttribute("tenantReviewList",tenantReviewList);

            }catch (Exception e){

            }

        }

        return "/main";
    }
    @RequestMapping({"/help.do"})
    public String help(Model model,HttpServletRequest request){

        return "/help";
    }
}
