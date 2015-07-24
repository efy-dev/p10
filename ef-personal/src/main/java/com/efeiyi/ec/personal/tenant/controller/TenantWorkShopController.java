package com.efeiyi.ec.personal.tenant.controller;

import com.efeiyi.ec.tenant.model.TenantWorkShop;
import com.ming800.core.base.service.BaseManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import java.util.LinkedHashMap;

/**
 * Created by AC丶man on 2015/7/17.
 */

@Controller
@RequestMapping("/tenantWorkShop")
public class TenantWorkShopController {

    @Autowired
    private BaseManager baseManager;


    /**
     * 获取传承人工作坊
     * @param model
     * @return
     */
    @RequestMapping("/{tenantId}")
    public ModelAndView getTenantWorkShop(@PathVariable String tenantId , Model model){
        LinkedHashMap<String, Object> queryParamMap = new LinkedHashMap<>();
        String queryHql = "from TenantWorkShop t where t.tenant.id = :tenantId";
        queryParamMap.put("tenantId",tenantId);
        TenantWorkShop productWorkShop = (TenantWorkShop) baseManager.getUniqueObjectByConditions(queryHql, queryParamMap);
        model.addAttribute("productWorkShop", productWorkShop);
        return new ModelAndView("/pc/tenantWorkShop/tenantWorkShopView");
    }


}
