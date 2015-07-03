package com.efeiyi.ec.personal.controller;

import com.efeiyi.ec.tenant.model.Tenant;
import com.efeiyi.ec.tenant.model.TenantHonor;
import com.efeiyi.ec.tenant.model.TenantIntroduction;
import com.ming800.core.base.controller.BaseController;
import com.ming800.core.base.service.BaseManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.LinkedHashMap;
import java.util.List;

/**
 * Created by AC丶man on 2015/6/29.
 */
@RestController
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
        Tenant tenant = (Tenant) baseManager.getObject(Tenant.class.getName(),tenantId);
        model.addAttribute("entity",tenant);
        return new ModelAndView("/tenant/tenantView" , model);
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

    /**
     * 获取传承人的某个殊荣
     * @param honorId
     * @param model
     * @return
     */
    @RequestMapping("/getTenantHonor.do")
    public ModelAndView getTenantHonor(String honorId , ModelMap model){
       TenantHonor honor = (TenantHonor) baseManager.getObject(TenantHonor.class.getName(),honorId);
        model.addAttribute("entity",honor);
        return new ModelAndView("/tenant/tenantHonor/tenantHonorView",model);
    }

    /**
     * 获取传承人ID对应的所有殊荣
     * @param tenantId
     * @param model
     * @return
     */
    @RequestMapping("/tenantHonorList.do")
    public ModelAndView listTenantHonor(HttpServletRequest request ,String tenantId ,ModelMap model){
        Tenant tenant = (Tenant) baseManager.getObject(Tenant.class.getName(),tenantId);
        model.addAttribute("tenant",tenant);
        String condition = request.getParameter("condition");
        LinkedHashMap<String, Object> queryParamMap = new LinkedHashMap<>();
        queryParamMap.put("tenantId",tenantId);
        StringBuffer sb = new StringBuffer("from TenantHonor h where h.tenant.id = (:tenantId)");
        /**
         * 根据页面传递查询参数来选择展示的数据
         */
        if(Long.valueOf(condition) > 0){
            sb.append(" and LEFT(create_date,4)='(:condition)'");
            queryParamMap.put("condition",condition);
        }
        sb.append(" order by h.createDate DESC");
        baseManager.listObject(sb.toString(), queryParamMap);
        return new ModelAndView("",model);
    }

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
        return new ModelAndView("/tenant/tenantIntroduction/tenantIntroductionView",model);
    }

    /**
     * 获取传承人简介(列表)
     * @param tenantId
     * @param model
     * @return
     */
    @RequestMapping("/tenantIntroductionList.do")
    public ModelAndView listTenantIntroduction(String tenantId , ModelMap model){
        /*String queryHql = "from TenantIntroduction i left join fetch i.tenant t where t.id = ?";
        LinkedHashMap<String , Object> queryParamMap = new LinkedHashMap<>();
        queryParamMap.put("tenantId",tenantId);
        baseManager.listObject(queryHql,queryParamMap);*/
        return new ModelAndView("",model);
    }




}
