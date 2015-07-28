package com.efeiyi.ec.personal.master.controller;

import com.efeiyi.ec.tenant.model.Tenant;
import com.efeiyi.ec.tenant.model.TenantNews;
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
public class TenantInfoController extends BaseTenantController {

    @Autowired
    private BaseManager baseManager;

    /**
     * 传承人资讯列表
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/listTenantInfo")
    public String listTenantInfo(HttpServletRequest request,Model model) throws Exception {
        Tenant tenant = super.getTenantfromDomain(request);
        XQuery xQuery = new XQuery("plistTenantInfo_default",request);
        xQuery.put("tenant_id", tenant.getId());
        xQuery.addRequestParamToModel(model,request);
        model.addAttribute("tenant", tenant);
        List tenantInfoList = baseManager.listPageInfo(xQuery).getList();
        model.addAttribute("tenantInfoList",tenantInfoList);

        XQuery xQuery1 = new XQuery("listWordValue_default",request);
        List list = baseManager.listObject(xQuery1);
        model.addAttribute("tagList",list);

       return "/tenantInfo/tenantInfoList";
    }

    /**
     * 获取传承人资讯
     * @param model
     * @return
     */
    @RequestMapping("/{tenantInfoId}")
    public  String getTenantInfo(@PathVariable String tenantInfoId, HttpServletRequest request , Model model) throws Exception {
        TenantNews tenantNews = (TenantNews) baseManager.getObject(TenantNews.class.getName(),tenantInfoId);
        model.addAttribute("tenantNews",tenantNews);
        return "/tenantInfo/tenantInfoView";
    }
}
