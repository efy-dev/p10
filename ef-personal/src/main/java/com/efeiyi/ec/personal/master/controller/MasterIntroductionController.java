package com.efeiyi.ec.personal.master.controller;

import com.efeiyi.ec.master.model.MasterIntroductionAttachment;
import com.efeiyi.ec.master.model.MasterIntroduction;
import com.efeiyi.ec.tenant.model.Tenant;
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
public class MasterIntroductionController extends BaseMasterController {

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
        String conditions = "introduction.master.id:"+tenant.getId();

        XQuery xQuery = new XQuery("listMasterIntroduction_default",conditions,null,null);
        xQuery.put("master_id",tenant.getId());
        xQuery.addRequestParamToModel(model,request);
        XQuery xQuery1 = new XQuery("listMasterIntroductionAttachment_default",conditions,null,null);
        xQuery1.addRequestParamToModel(model,request);
        List<MasterIntroduction> list = baseManager.listObject(xQuery);
        List<MasterIntroductionAttachment> list1 = baseManager.listObject(xQuery1);


        for (MasterIntroduction masterIntroduction:list){
            if ("1".equals(masterIntroduction.getType())){
                model.addAttribute("jbxxIntroduction", masterIntroduction);
            }
            if ("2".equals(masterIntroduction.getType())){
                List dsryList = new ArrayList();
                for (MasterIntroductionAttachment attachment:list1){
                    if ((attachment.getIntroduction().getId()).equals(masterIntroduction.getId())){
                        dsryList.add(attachment);
                    }
                }
                model.addAttribute("dsryList", dsryList);
            }
            if ("3".equals(masterIntroduction.getType())){
                List cbzzList = new ArrayList();
                for (MasterIntroductionAttachment attachment:list1){
                    if ((attachment.getIntroduction().getId()).equals(masterIntroduction.getId())){
                        cbzzList.add(attachment);
                    }
                }
                model.addAttribute("cbzzList", cbzzList);
            }
            if ("4".equals(masterIntroduction.getType())){
                model.addAttribute("masterIntroduction", masterIntroduction);
            }
        }
        model.addAttribute("tenant",tenant);
        model.addAttribute("list",list);
        model.addAttribute("pageMsg","2");
        return "/tenantIntroduction/tenantIntroductionList";
    }

}
