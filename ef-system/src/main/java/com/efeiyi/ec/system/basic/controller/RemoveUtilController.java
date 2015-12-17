package com.efeiyi.ec.system.basic.controller;

import com.efeiyi.ec.organization.model.BigUser;
import com.efeiyi.ec.tenant.model.BigTenant;
import com.efeiyi.ec.wiki.model.ProductPraise;
import com.ming800.core.base.service.BaseManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;

/**
 * Created by Administrator on 2015/7/13.
 */
@Controller
public class RemoveUtilController {
    @Autowired
    private BaseManager baseManager;
    @RequestMapping("/remove.do")
    @ResponseBody
    public String removeObject(HttpServletRequest request)throws  Exception{
        String id = request.getParameter("id");
        baseManager.remove(BigUser.class.getName(), "ibxgandy0000h3ja");

        return "true";
    }

}
