package com.efeiyi.ec.personal.tenant.controller;

import com.efeiyi.ec.tenant.model.*;
import com.ming800.core.base.controller.BaseController;
import com.ming800.core.base.service.BaseManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import java.util.ArrayList;
import java.util.LinkedHashMap;
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
     * @param tenantId
     * @param model
     * @return
     */
    @RequestMapping("/getTenant.do")
    public ModelAndView getTenant(String tenantId , ModelMap model){
        LinkedHashMap queryParamMap = new LinkedHashMap();
        Tenant tenant = (Tenant) baseManager.getObject(Tenant.class.getName(),tenantId);
        String queryHql = "from TenantProduct p where p.tenant.id = :tenantId order by p.createDateTime desc";
        queryParamMap.put("tenantId",tenantId);
        List productList = baseManager.listObject(queryHql, queryParamMap);
        List listProduct = new ArrayList();
        for(int i = 0;i<productList.size();i++){
            if (i>2){
                break;
            }
            listProduct.add(productList.get(i));
        }
        model.addAttribute("entity",tenant);
        model.addAttribute("productList", listProduct);
        return new ModelAndView("/tenant/tenantView", model);
    }

    /**
     * 获取所有传承人
     * @param model
     * @return
     */
    @RequestMapping("/tenantList.do")
    public ModelAndView listTenant(ModelMap model){
        String queryHql = "from Tenant";
        List list = baseManager.listObject(queryHql);
        if (list != null && list.size() > 0){
            model.addAttribute("tenantList",list);
        }
        return new ModelAndView("/tenant/tenantList",model);
    }



}
