package com.efeiyi.ec.personal.tenant.controller;

import com.efeiyi.ec.tenant.model.Tenant;
import com.ming800.core.base.controller.BaseController;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * Created by AC丶man on 2015/6/29.
 */
@Controller
@RequestMapping("/tenant")
public class TenantController extends BaseController {

    @Autowired
    BaseManager baseManager;

    /**
     * 获取某传承人的详情页
     * @param model
     * @return
     */
    @RequestMapping("/getTenant.do")
    public ModelAndView getTenant(HttpServletRequest request , ModelMap model)throws Exception{
        String tenantId = request.getParameter("tenantId");
        Tenant tenant = (Tenant) baseManager.getObject(Tenant.class.getName(),tenantId);
        model.addAttribute("entity", tenant);
        return new ModelAndView("/tenant/tenantView", model);
    }

    /**
     * 获取所有传承人
     * @param model
     * @return
     */
    @RequestMapping("/tenantList.do")
    public ModelAndView listTenant(HttpServletRequest request , ModelMap model)throws Exception{
        XQuery xQuery = new XQuery("listTenant_default",request);
        List list = baseManager.listObject(xQuery);
        model.addAttribute("list",list);
        return new ModelAndView("/tenant/tenantList",model);
    }



}
