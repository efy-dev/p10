package com.efeiyi.pal.system.organization.controller;

import com.efeiyi.pal.organization.model.Tenant;
import com.efeiyi.pal.organization.model.TenantCertification;
import com.efeiyi.pal.organization.model.TenantSource;
import com.ming800.core.base.service.BaseManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Created by Administrator on 2015/8/6.
 */

@Controller
@RequestMapping("/tenantCertification")
public class TenantCertificationController {

    @Autowired
    private BaseManager baseManager;

    @RequestMapping("/newTenantCertification.do")
    public ModelAndView newTenantSource(ModelMap modelMap, HttpServletRequest request) throws Exception{
        String tenantId = request.getParameter("tenantId");
        if (tenantId == null || tenantId.trim().equals("")) {
            throw new Exception("商户id不能为空!");
        }
        Tenant tenant = (Tenant) baseManager.getObject(Tenant.class.getName(), tenantId);

        modelMap.put("tenant", tenant);
        String resultPage = "/tenantCertification/tenantCertificationForm";
        return new ModelAndView(resultPage);
    }

    @RequestMapping("/saveTenantCertification.do")
    public ModelAndView saveTenantCertification(ModelMap modelMap, HttpServletRequest request) throws Exception {
        TenantCertification tenantCertification = new TenantCertification();

        String tenantCertificationId = request.getParameter("id");
        String type = "new";
        if (tenantCertificationId != null && !tenantCertificationId.equals("")) {
            type = "edit";
            tenantCertification = (TenantCertification) baseManager.getObject(TenantCertification.class.getName(), tenantCertificationId);
        }

        tenantCertification = setTenantCertificationBaseProperty(tenantCertification, request);

        tenantCertification = getRelationAttributeObject(tenantCertification, request);
        baseManager.saveOrUpdate(tenantCertification.getClass().getName(), tenantCertification);

        String resultPage = "redirect:/basic/xm.do?qm=viewTenant&id="+tenantCertification.getTenant().getId();
        return new ModelAndView(resultPage);
    }

    @RequestMapping("/removeTenantCertification.do")
    public ModelAndView removeTenantSource(ModelMap modelMap, HttpServletRequest request) throws Exception{
        String tenantCertificationId = request.getParameter("tenantCertificationId");
        if (tenantCertificationId == null || tenantCertificationId.trim().equals("")) {
            throw new Exception("认证信息id不能为空!");
        }
        TenantCertification tenantCertification = (TenantCertification) baseManager.getObject(TenantCertification.class.getName(), tenantCertificationId);
        tenantCertification.setStatus("0");
        baseManager.saveOrUpdate(tenantCertification.getClass().getName(), tenantCertification);

        String resultPage = "redirect:/basic/xm.do?qm=viewTenant&id="+tenantCertification.getTenant().getId();
        return new ModelAndView(resultPage);
    }

    /**
     * 获取tenantSource的Form表单基本数据
     * @param tenantCertification
     * @param request
     * @return
     */
    private TenantCertification setTenantCertificationBaseProperty(TenantCertification tenantCertification, HttpServletRequest request) throws Exception {
        String name = request.getParameter("name");
        String org = request.getParameter("org");
        String status = request.getParameter("status");
        String level = request.getParameter("level");

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM" );
        Date date = sdf.parse(request.getParameter("theDate"));

        tenantCertification.setName(name);
        tenantCertification.setOrg(org);
        tenantCertification.setTheDate(date);
        tenantCertification.setLevel(level);
        tenantCertification.setStatus(status);

        return tenantCertification;
    }

    /**
     * 获取关联属性的对象
     * @param tenantCertification
     * @param request
     * @return
     */
    private TenantCertification getRelationAttributeObject(TenantCertification tenantCertification, HttpServletRequest request){
        String tenantId = request.getParameter("tenant.id");
        Tenant tenant = (Tenant) baseManager.getObject(Tenant.class.getName(), tenantId);
        tenantCertification.setTenant(tenant);

        return tenantCertification;
    }

}