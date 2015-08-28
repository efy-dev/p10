package com.efeiyi.pal.system.organization.controller;

import com.efeiyi.pal.organization.model.Tenant;
import com.efeiyi.pal.product.model.ProductSeries;
import com.efeiyi.pal.product.model.TenantProductSeries;
import com.ming800.core.base.service.BaseManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;

/**
 * Created by Administrator on 2015/8/6.
 */

@Controller
@RequestMapping("/tenant")
public class TenantController {

    @Autowired
    private BaseManager baseManager;

    @RequestMapping("/saveTenant.do")
    public ModelAndView saveTenant(ModelMap modelMap, HttpServletRequest request) throws Exception {
        Tenant tenant = new Tenant();

        String labelBatchId = request.getParameter("id");
        String type = "new";
        if (labelBatchId != null && !labelBatchId.equals("")) {
            type = "edit";
            tenant = (Tenant) baseManager.getObject(Tenant.class.getName(), labelBatchId);
        }
        tenant = setTenantBaseProperty(tenant, request, type);
        baseManager.saveOrUpdate(Tenant.class.getName(), tenant);

        modelMap.put("object", tenant);
        String resultPage = "redirect:/basic/xm.do?qm=viewTenant&tenant=tenant&id=" + tenant.getId();
        return new ModelAndView(resultPage);
    }

    @RequestMapping("/saveTenantProductSeries.do")
    public ModelAndView saveTenantProductSeries(HttpServletRequest request) throws Exception {
        String tenantId = request.getParameter("tenant.id");
        String productSeriesId = request.getParameter("productSeries.id");
        Tenant tenant = (Tenant) baseManager.getObject(Tenant.class.getName(), tenantId);
        ProductSeries productSeries = (ProductSeries) baseManager.getObject(ProductSeries.class.getName(), productSeriesId);

        TenantProductSeries tenantProductSeries = new TenantProductSeries();
        tenantProductSeries.setTenant(tenant);
        tenantProductSeries.setProductSeries(productSeries);
        tenantProductSeries.setStatus("1");
        if (!tenant.getTenantProductSeriesList().contains(tenantProductSeries)){
            baseManager.saveOrUpdate(TenantProductSeries.class.getName(), tenantProductSeries);
        }

        String resultPage = "redirect:/basic/xm.do?qm=viewTenant&tenant=tenant&id=" + tenant.getId();
        return new ModelAndView(resultPage);

    }

    @RequestMapping("/delTenantProductSeries.do")
    public ModelAndView delTenantProductSeries(HttpServletRequest request) throws Exception {
        String tenantProductSeriesId = request.getParameter("tenantProductSeriesId");
        TenantProductSeries tenantProductSeries = (TenantProductSeries) baseManager.getObject(TenantProductSeries.class.getName(), tenantProductSeriesId);
        String tenantId = request.getParameter("tenantId");
        Tenant tenant = (Tenant) baseManager.getObject(Tenant.class.getName(), tenantId);

        tenantProductSeries.setStatus("0");
        baseManager.saveOrUpdate(TenantProductSeries.class.getName(), tenantProductSeries);

        String resultPage = "redirect:/basic/xm.do?qm=viewTenant&tenant=tenant&id=" + tenant.getId();
        return new ModelAndView(resultPage);
    }

    /**
     * 获取tenant的Form表单基本数据
     * @param tenant
     * @param request
     * @param type
     * @return
     */
    private Tenant setTenantBaseProperty(Tenant tenant, HttpServletRequest request, String type) {
        String name = request.getParameter("name");
        String status = request.getParameter("status");
        String province = request.getParameter("province");
        String city = request.getParameter("city");
        String address = request.getParameter("address");

        tenant.setName(name);
        tenant.setProvince(province);
        tenant.setCity(city);
        tenant.setAddress(address);
        tenant.setStatus(status);
        if ("new".equals(type)){
            tenant.setStatus("1");
        }

        return tenant;
    }

}
