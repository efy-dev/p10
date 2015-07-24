package com.efeiyi.ec.personal.tenant.controller;

import com.efeiyi.ec.tenant.model.Tenant;
import com.efeiyi.ec.tenant.model.TenantAttachment;
import com.efeiyi.ec.tenant.model.TenantIntroduction;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
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
     * 获取传承人简介(列表)
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/listTenantIntroduction.do")
    public String listTenantIntroduction( Model model, HttpServletRequest request ) throws Exception{
        String conditions = request.getParameter("conditions");
        String tenantId = conditions.substring(23,conditions.length());
        Tenant tenant = (Tenant) baseManager.getObject(Tenant.class.getName(), tenantId);
        XQuery xQuery = new XQuery("listTenantIntroduction_default",request);
        xQuery.addRequestParamToModel(model,request);
        XQuery xQuery1 = new XQuery("listAttachment_default",request);
        xQuery1.addRequestParamToModel(model,request);
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
                model.addAttribute("list2", list2);
            }
            if ("chu-ban-zhu-zuo".equals(tenantIntroduction.getTitle())){
                List list3 = new ArrayList();
                for (TenantAttachment tenantAttachment:list1){
                    if ((tenantAttachment.getIntroduction().getId()).equals(tenantIntroduction.getId())){
                        list3.add(tenantAttachment);
                    }
                }
                model.addAttribute("list3", list3);
            }
        }
        model.addAttribute("tenant",tenant);
        model.addAttribute("list",list);
        return "/pc/tenantIntroduction/tenantIntroductionList";
    }

}
