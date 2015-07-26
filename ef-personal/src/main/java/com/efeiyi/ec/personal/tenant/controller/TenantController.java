package com.efeiyi.ec.personal.tenant.controller;

import com.efeiyi.ec.tenant.model.Tenant;
import com.ming800.core.base.controller.BaseController;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.LinkedHashMap;
import java.util.List;

/**
 * Created by AC丶man on 2015/6/29.
 */
@Controller
@RequestMapping("/tenant")
public class TenantController extends BaseTenantController {

    @Autowired
    BaseManager baseManager;

    /**
     * 获取某传承人的详情页
     * @param
     *
     * @return
     */
    @RequestMapping("/ten")
    public ModelAndView getTenant( HttpServletRequest request  , Model model)throws Exception{
        Tenant tenant = getTenantfromDomain(request);
        String queryHql = "from TenantWork t where t.tenant.id = :tenantId";
        LinkedHashMap<String , Object> queryParamMap = new LinkedHashMap<>();
        queryParamMap.put("tenantId",tenant.getId());
        List list = baseManager.listObject(queryHql,queryParamMap);
        model.addAttribute("tenantWorkList",list);
        model.addAttribute("tenant", tenant);
        return new ModelAndView("/tenant/tenantView");
    }

    /**
     * 获取所有传承人
     * @param model
     * @return
     */
    /*@RequestMapping("/tenantList")
    public ModelAndView listTenant(HttpServletRequest request , ModelMap modelMap)throws Exception{
        XQuery xQuery = new XQuery("listTenantRecommended_default",request);
        List list = baseManager.listObject(xQuery);
        modelMap.addAttribute("recommendedList",list);
        return new ModelAndView("/pc/tenant/tenantList",modelMap);
    }*/
    @RequestMapping("/tenantList")
    public String listTenant(HttpServletRequest request,Model model)throws Exception{
        /*Tenant tenant = getTenantfromDomain(request);*/
        XQuery xQuery = new XQuery("listTenantProject_default",request);
        /*xQuery.put("tenant_id",tenant.getId());*/
        List list = baseManager.listObject(xQuery);
        model.addAttribute("list",list);
        return "/tenant/tenantList";
    }

    @ResponseBody
    @RequestMapping("/getTenant.do")
    public Object getTenant(HttpServletRequest request) throws Exception{
        return getTenantfromDomain(request);
    }


}
