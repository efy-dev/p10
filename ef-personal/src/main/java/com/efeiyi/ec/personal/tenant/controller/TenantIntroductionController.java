package com.efeiyi.ec.personal.tenant.controller;

import com.efeiyi.ec.tenant.model.TenantIntroduction;
import com.ming800.core.base.service.BaseManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import java.util.LinkedHashMap;
import java.util.List;

/**
 * Created by AC丶man on 2015/7/17.
 */
@Controller
@RequestMapping("/tenantIntroduction")
public class TenantIntroductionController {

    @Autowired
    private BaseManager baseManager;

    /**
     * 获取传承人简介
     * @param introductionId
     * @param model
     * @return
     */
    @RequestMapping("/getTenantIntroduction.do")
    public ModelAndView getTenantIntroduction(String introductionId ,ModelMap model){
        TenantIntroduction introduction = (TenantIntroduction) baseManager.getObject(TenantIntroduction.class.getName(),introductionId);
        model.addAttribute("entity",introduction);
        return new ModelAndView("/tenantIntroduction/tenantIntroductionView",model);
    }

    /**
     * 获取传承人简介(列表)
     * @param tenantId
     * @param model
     * @return
     */
    @RequestMapping("/tenantIntroductionList.do")
    public ModelAndView listTenantIntroduction(String tenantId , ModelMap model){
        String queryHql = "from TenantIntroduction i where i.tenant.id = :tenantId";
        String queryHql1 = "from TenantHonor h where h.tenant.id = :tenantId";
        String queryHql2 = "from TenantWork t where t.tenant.id = :tenantId";
        LinkedHashMap<String , Object> queryParamMap = new LinkedHashMap<>();
        queryParamMap.put("tenantId",tenantId);
        List list = baseManager.listObject(queryHql, queryParamMap);
        List list1 = baseManager.listObject(queryHql1,queryParamMap);
        List list2 = baseManager.listObject(queryHql2, queryParamMap);
        model.addAttribute("tenantIntroductionList",list);
        model.addAttribute("tenantHonorList", list1);
        model.addAttribute("tenantWorkList", list2);
        return new ModelAndView("/tenantIntroduction/tenantIntroductionList",model);
    }

}
