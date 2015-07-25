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
public class TenantIntroductionController {

    @Autowired
    private BaseManager baseManager;

    /**
     * 获取传承人简介(列表)
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/{tenantId}")
    public String listTenantIntroduction(@PathVariable String tenantId, Model model, HttpServletRequest request ) throws Exception{
        //拼写查询参数(conditions)
        String conditions = "introduction.tenant.id:"+tenantId;

        Tenant tenant = (Tenant) baseManager.getObject(Tenant.class.getName(), tenantId);
        XQuery xQuery = new XQuery("listTenantIntroduction_default",conditions,null,null);
        xQuery.addRequestParamToModel(model,request);
        XQuery xQuery1 = new XQuery("listAttachment_default",conditions,null,null);
        xQuery1.addRequestParamToModel(model,request);
        List<TenantIntroduction> list = baseManager.listObject(xQuery);
        List<TenantAttachment> list1 = baseManager.listObject(xQuery1);


        for (TenantIntroduction tenantIntroduction:list){
            if ("ji-ben-xin-xi".equals(tenantIntroduction.getTitle())){
                List jbxxList = new ArrayList();
                for (TenantAttachment tenantAttachment:list1){
                    if ((tenantAttachment.getIntroduction().getId()).equals(tenantIntroduction.getId())){
                        jbxxList.add(tenantAttachment);
                    }
                }
                model.addAttribute("jbxxList", jbxxList);
            }
            if ("da-shi-rong-yu".equals(tenantIntroduction.getTitle())){
                List dsryList = new ArrayList();
                for (TenantAttachment tenantAttachment:list1){
                    if ((tenantAttachment.getIntroduction().getId()).equals(tenantIntroduction.getId())){
                        dsryList.add(tenantAttachment);
                    }
                }
                model.addAttribute("dsryList", dsryList);
            }
            if ("chu-ban-zhu-zuo".equals(tenantIntroduction.getTitle())){
                List cbzzList = new ArrayList();
                for (TenantAttachment tenantAttachment:list1){
                    if ((tenantAttachment.getIntroduction().getId()).equals(tenantIntroduction.getId())){
                        cbzzList.add(tenantAttachment);
                    }
                }
                model.addAttribute("cbzzList", cbzzList);
            }
            if ("yi-shu-nian-biao".equals(tenantIntroduction.getTitle())){
                List ysnbList = new ArrayList();
                for (TenantAttachment tenantAttachment:list1){
                    if ((tenantAttachment.getIntroduction().getId()).equals(tenantIntroduction.getId())){
                        ysnbList.add(tenantAttachment);
                    }
                }
                model.addAttribute("ysnbList", ysnbList);
            }
        }
        model.addAttribute("tenant",tenant);
        model.addAttribute("list",list);
        return "/tenantIntroduction/tenantIntroductionList";
    }

}
