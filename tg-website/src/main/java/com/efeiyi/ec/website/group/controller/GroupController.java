package com.efeiyi.ec.website.group.controller;

import com.efeiyi.ec.organization.model.MyUser;
import com.efeiyi.ec.website.organization.util.AuthorizationUtil;
import com.ming800.core.base.service.BaseManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

/**
 * Created by Administrator on 2015/10/21.
 */
@Controller
@RequestMapping("/group")
public class GroupController {

    @Autowired
    private BaseManager baseManager;

    @RequestMapping(value = "/createGroup.do")
    public String listProduct(HttpServletRequest request, Model model) throws Exception{
       /* MyUser currentUser = AuthorizationUtil.getMyUser();
        if(currentUser != null){

        }*/
        return "";
    }
}
