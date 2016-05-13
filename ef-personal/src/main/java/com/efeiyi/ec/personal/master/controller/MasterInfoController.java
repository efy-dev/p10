package com.efeiyi.ec.personal.master.controller;

import com.efeiyi.ec.master.model.Master;
import com.efeiyi.ec.master.model.MasterNews;
import com.efeiyi.ec.tenant.model.Tenant;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * Created by AC丶man on 2015/7/17.
 */
@Controller
@RequestMapping("/info")
public class MasterInfoController extends BaseMasterController {

    @Autowired
    private BaseManager baseManager;

    /**
     * 传承人资讯列表
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/list")
    public String listTenantInfo(HttpServletRequest request,Model model) throws Exception {
        Master master = super.getMasterfromDomain(request);
        XQuery xQuery = new XQuery("plistMasterNew_default",request);
        xQuery.put("master_id", master.getId());
        xQuery.addRequestParamToModel(model,request);
        model.addAttribute("tenant", master);
        List masterInfoList = baseManager.listPageInfo(xQuery).getList();
        model.addAttribute("tenantInfoList",masterInfoList);

        XQuery xQuery1 = new XQuery("listWordValue_default",request);
        List list = baseManager.listObject(xQuery1);
        model.addAttribute("tagList",list);
        model.addAttribute("pageMsg","4");
       return "/tenantInfo/tenantInfoList";
    }

    /**
     * 获取传承人资讯
     * @param model
     * @return
     */
    @RequestMapping("/{tenantInfoId}")
    public  String getTenantInfo(@PathVariable String tenantInfoId, HttpServletRequest request , Model model) throws Exception {
        MasterNews masterNews = (MasterNews) baseManager.getObject(MasterNews.class.getName(),tenantInfoId);
        model.addAttribute("masterNews",masterNews);
        model.addAttribute("pageMsg","7");
        return "/tenantInfo/tenantInfoView";
    }
}
