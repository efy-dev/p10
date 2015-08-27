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
        tenant = setTenantBaseProperty(tenant, request);
        tenant = getRelationAttributeObject(tenant, request, type);
        baseManager.saveOrUpdate(Tenant.class.getName(), tenant);

        modelMap.put("object", tenant);
        String resultPage = "redirect:/basic/xm.do?qm=viewTenant&tenant=tenant&id=" + tenant.getId();
        return new ModelAndView(resultPage);
    }

    @RequestMapping("/saveTenantProductSeries.do")
    public ModelAndView saveTenantProductSeries(ModelMap modelMap, HttpServletRequest request) throws Exception {
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
    public ModelAndView delTenantProductSeries(ModelMap modelMap, HttpServletRequest request) throws Exception {
        String tenantProductSeriesId = request.getParameter("tenantProductSeriesId");
        TenantProductSeries tenantProductSeries = (TenantProductSeries) baseManager.getObject(TenantProductSeries.class.getName(), tenantProductSeriesId);
        String tenantId = request.getParameter("tenantId");
        Tenant tenant = (Tenant) baseManager.getObject(Tenant.class.getName(), tenantId);

        tenantProductSeries.setStatus("0");
        baseManager.saveOrUpdate(TenantProductSeries.class.getName(), tenantProductSeries);

        modelMap.put("object", tenant);
        String resultPage = "redirect:/basic/xm.do?qm=viewTenant&tenant=tenant&id=" + tenant.getId();
        return new ModelAndView(resultPage);
    }

    /**
     * 获取tenant的Form表单基本数据
     * @param tenant
     * @param request
     * @return
     */
    private Tenant setTenantBaseProperty(Tenant tenant, HttpServletRequest request) {
        String name = request.getParameter("name");
        String status = request.getParameter("status");
        String province = request.getParameter("province");
        String city = request.getParameter("city");
        String address = request.getParameter("address");

        tenant.setName(name);
        tenant.setStatus(status);
        tenant.setProvince(province);
        tenant.setCity(city);
        tenant.setAddress(address);

        return tenant;
    }

    /**
     * 获取关联属性的对象
     * @param tenant
     * @param request
     * @return
     */
    private Tenant getRelationAttributeObject(Tenant tenant, HttpServletRequest request, String type){
//        String provinceId = request.getParameter("province.id");
//        String addressId = request.getParameter("address.id");
//
//        AddressProvince province = (AddressProvince) baseManager.getObject(AddressProvince.class.getName(), provinceId);
//        AddressDistrict address = (AddressDistrict) baseManager.getObject(AddressDistrict.class.getName(), addressId);
//
//        tenant.setProvince(province);
//        tenant.setAddress(address);
//        if (type.equals("new")){
//            List<TenantCertification> tenantCertificationList = new ArrayList<>();
//            List<TenantProductSeries> tenantProductSeriesList = new ArrayList<>();
//            tenant.setTenantCertificationList(tenantCertificationList);
//            tenant.setTenantProductSeriesList(tenantProductSeriesList);
//        }
        return tenant;
    }

}
