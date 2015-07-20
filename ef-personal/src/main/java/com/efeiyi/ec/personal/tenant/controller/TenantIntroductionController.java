package com.efeiyi.ec.personal.tenant.controller;

import com.efeiyi.ec.tenant.model.Tenant;
import com.efeiyi.ec.tenant.model.TenantAttachment;
import com.efeiyi.ec.tenant.model.TenantIntroduction;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
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
     * @param request
     * @param modelMap
     * @return
     */
    @RequestMapping("/tenantIntroductionList.do")
    public ModelAndView listTenantIntroduction( ModelMap modelMap, HttpServletRequest request ) throws Exception{
        String tenantId = request.getParameter("tenantId");
        String queryHql = "from Tenant t left join fetch t.originProvince p where t.id = :tenantId";
        LinkedHashMap<String,Object> queryParamMap = new LinkedHashMap<>();
        queryParamMap.put("tenantId",tenantId);
        Tenant tenant = (Tenant) baseManager.getUniqueObjectByConditions(queryHql,queryParamMap);
        XQuery xQuery = new XQuery("listTenantIntroduction_default",request);
        XQuery xQuery1 = new XQuery("listAttachment_default",request);
        List<TenantIntroduction> list = baseManager.listObject(xQuery);
        List<TenantAttachment> list1 = baseManager.listObject(xQuery1);
        for (TenantIntroduction tenantIntroduction:list){
            if ("da-shi-rong-yu".equals(tenantIntroduction.getTitle())){
                List list2 = new ArrayList();
                for (TenantAttachment tenantAttachment:list1){
                    if ((tenantAttachment.getIntroduction().getId()).equals(tenantIntroduction.getId())){
                        list2.add(tenantAttachment);
                    }
                }
                modelMap.addAttribute("list2", list2);
            }
            if ("chu-ban-zhu-zuo".equals(tenantIntroduction.getTitle())){
                List list3 = new ArrayList();
                for (TenantAttachment tenantAttachment:list1){
                    if ((tenantAttachment.getIntroduction().getId()).equals(tenantIntroduction.getId())){
                        list3.add(tenantAttachment);
                    }
                }
                modelMap.addAttribute("list3", list3);
            }
            if ("yi-shu-nian-biao".equals(tenantIntroduction.getTitle())){
                List list4 = new ArrayList();
                for (TenantAttachment tenantAttachment:list1){
                    if ((tenantAttachment.getIntroduction().getId()).equals(tenantIntroduction.getId())){
                        list4.add(tenantAttachment);
                    }
                }
                modelMap.addAttribute("list4", list4);
            }
        }
        modelMap.addAttribute("tenant",tenant);
        modelMap.addAttribute("list",list);
        return new ModelAndView( "/tenantIntroduction/tenantIntroductionList",modelMap);
    }

}
