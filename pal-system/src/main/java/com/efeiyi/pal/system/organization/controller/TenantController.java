package com.efeiyi.pal.system.organization.controller;

import com.efeiyi.pal.organization.model.AddressCity;
import com.efeiyi.pal.organization.model.AddressDistrict;
import com.efeiyi.pal.organization.model.AddressProvince;
import com.efeiyi.pal.organization.model.Tenant;
import com.efeiyi.pal.product.model.ProductSeries;
import com.efeiyi.pal.product.model.TenantProductSeries;
import com.efeiyi.pal.system.product.service.ProductSeriesServiceManager;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.util.ApplicationContextUtil;
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
    private ProductSeriesServiceManager productSeriesServiceManager = (ProductSeriesServiceManager) ApplicationContextUtil.getApplicationContext().getBean("productSeriesServiceManagerImpl");


    @RequestMapping("/saveTenant.do")
    public ModelAndView saveTenant(ModelMap modelMap, HttpServletRequest request) throws Exception {
        Tenant tenant = new Tenant();

        String tenantId = request.getParameter("id");
        String type = "new";
        if (tenantId != null && !"".equals(tenantId.trim())) {
            type = "edit";
            tenant = (Tenant) baseManager.getObject(Tenant.class.getName(), tenantId);
        }
        tenant = setTenantBaseProperty(tenant, request, type);
        tenant = getRelationProperty(tenant, request);
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

        productSeriesServiceManager.removeTenantProductSeries(tenantProductSeries);

        String resultPage = "redirect:/basic/xm.do?qm=viewTenant&tenant=tenant&id=" + tenantProductSeries.getTenant().getId();
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

        tenant.setName(name);
        tenant.setStatus(status);
        if ("new".equals(type)){
            tenant.setStatus("1");
        }

        return tenant;
    }

    /**
     * 获取关联对象
     * @param tenant
     * @param request
     * @return
     */
    private Tenant getRelationProperty(Tenant tenant, HttpServletRequest request){
        String provinceId = request.getParameter("province.id");
        String cityId = request.getParameter("city.id");
        String districtId = request.getParameter("district.id");

        AddressProvince province = (AddressProvince) baseManager.getObject(AddressProvince.class.getName(), provinceId);
        AddressCity city = (AddressCity) baseManager.getObject(AddressCity.class.getName(), cityId);
        AddressDistrict district = (AddressDistrict) baseManager.getObject(AddressDistrict.class.getName(), districtId);

        tenant.setProvince(province);
        tenant.setCity(city);
        tenant.setDistrict(district);

        return tenant;
    }

}
