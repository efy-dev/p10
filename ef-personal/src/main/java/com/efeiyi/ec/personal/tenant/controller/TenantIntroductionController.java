package com.efeiyi.ec.personal.tenant.controller;

import com.efeiyi.ec.tenant.model.Tenant;
import com.efeiyi.ec.tenant.model.TenantAttachment;
import com.efeiyi.ec.tenant.model.TenantIntroduction;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by AC丶man on 2015/7/17.
 */
@Controller
@RequestMapping("/introduction")
public class TenantIntroductionController extends BaseTenantController {

    @Autowired
    private BaseManager baseManager;

    /**
     * 获取传承人简介(列表)
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/intro")
    public String listTenantIntroduction( Model model, HttpServletRequest request ) throws Exception{
        Tenant tenant = getTenantfromDomain(request);
        //拼写查询参数(conditions)
        String conditions = "introduction.tenant.id:"+tenant.getId();

        XQuery xQuery = new XQuery("listTenantIntroduction_default",conditions,null,null);
        xQuery.put("tenant_id",tenant.getId());
        xQuery.addRequestParamToModel(model,request);
        XQuery xQuery1 = new XQuery("listAttachment_default",conditions,null,null);
        xQuery1.addRequestParamToModel(model,request);
        List<TenantIntroduction> list = baseManager.listObject(xQuery);
        List<TenantAttachment> list1 = baseManager.listObject(xQuery1);


        for (TenantIntroduction tenantIntroduction:list){
            if ("1".equals(tenantIntroduction.getType())){
                model.addAttribute("jbxxIntroduction", tenantIntroduction);
            }
            if ("2".equals(tenantIntroduction.getType())){
                List dsryList = new ArrayList();
                for (TenantAttachment tenantAttachment:list1){
                    if ((tenantAttachment.getIntroduction().getId()).equals(tenantIntroduction.getId())){
                        dsryList.add(tenantAttachment);
                    }
                }
                model.addAttribute("dsryList", dsryList);
            }
            if ("3".equals(tenantIntroduction.getType())){
                List cbzzList = new ArrayList();
                for (TenantAttachment tenantAttachment:list1){
                    if ((tenantAttachment.getIntroduction().getId()).equals(tenantIntroduction.getId())){
                        cbzzList.add(tenantAttachment);
                    }
                }
                model.addAttribute("cbzzList", cbzzList);
            }
            if ("4".equals(tenantIntroduction.getType())){
                List ysnbList = new ArrayList();
                ysnbList.add(tenantIntroduction);
                model.addAttribute("ysnbList", ysnbList);
            }
        }
        model.addAttribute("tenant",tenant);
        model.addAttribute("list",list);
        return "/tenantIntroduction/tenantIntroductionList";
    }

}
