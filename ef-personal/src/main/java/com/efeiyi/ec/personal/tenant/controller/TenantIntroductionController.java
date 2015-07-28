package com.efeiyi.ec.personal.tenant.controller;

import com.efeiyi.ec.master.model.Master;
import com.efeiyi.ec.master.model.MasterAttachment;
import com.efeiyi.ec.master.model.MasterIntroduction;
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
        Master master = getTenantfromDomain(request);
        //拼写查询参数(conditions)
        String conditions = "introduction.master.id:"+ master.getId();

        XQuery xQuery = new XQuery("listTenantIntroduction_default",conditions,null,null);
        xQuery.put("tenant_id", master.getId());
        xQuery.addRequestParamToModel(model,request);
        XQuery xQuery1 = new XQuery("listAttachment_default",conditions,null,null);
        xQuery1.addRequestParamToModel(model,request);
        List<MasterIntroduction> list = baseManager.listObject(xQuery);
        List<MasterAttachment> list1 = baseManager.listObject(xQuery1);


        for (MasterIntroduction masterIntroduction :list){
            if ("1".equals(masterIntroduction.getType())){
                model.addAttribute("jbxxIntroduction", masterIntroduction);
            }
            if ("2".equals(masterIntroduction.getType())){
                List dsryList = new ArrayList();
                for (MasterAttachment masterAttachment :list1){
                    if ((masterAttachment.getIntroduction().getId()).equals(masterIntroduction.getId())){
                        dsryList.add(masterAttachment);
                    }
                }
                model.addAttribute("dsryList", dsryList);
            }
            if ("3".equals(masterIntroduction.getType())){
                List cbzzList = new ArrayList();
                for (MasterAttachment masterAttachment :list1){
                    if ((masterAttachment.getIntroduction().getId()).equals(masterIntroduction.getId())){
                        cbzzList.add(masterAttachment);
                    }
                }
                model.addAttribute("cbzzList", cbzzList);
            }
            if ("4".equals(masterIntroduction.getType())){
                model.addAttribute("tenantIntroduction", masterIntroduction);
            }
        }
        model.addAttribute("tenant", master);
        model.addAttribute("list",list);
        return "/masterIntroduction/tenantIntroductionList";
    }

}
