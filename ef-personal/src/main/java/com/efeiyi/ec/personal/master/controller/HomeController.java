package com.efeiyi.ec.personal.master.controller;

import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * Created by AC丶man on 2015/7/26.
 */
@Controller
public class HomeController {

    @Autowired
    private BaseManager baseManager;

    /**
     * 获取所有传承人
     * @param model
     * @return
     */
    @RequestMapping("/index")
    public String index(HttpServletRequest request,Model model)throws Exception{
        /*Tenant tenant = getTenantfromDomain(request);*/
        XQuery xQuery = new XQuery("listTenantProject_default",request);
        /*xQuery.put("tenant_id",tenant.getId());*/
        List list = baseManager.listObject(xQuery);
        model.addAttribute("list",list);
        model.addAttribute("pageMsg","0");
        return "/tenant/tenantList";
    }
}
