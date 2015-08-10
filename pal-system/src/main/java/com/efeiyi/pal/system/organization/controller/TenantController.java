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
import java.util.ArrayList;
import java.util.List;

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

        String tenantId = request.getParameter("id");
        String type = "new";
        if (tenantId != null && !tenantId.equals("")) {
            type = "edit";
            tenant = (Tenant) baseManager.getObject(Tenant.class.getName(), tenantId);
        }

        tenant = setTenantBaseProperty(tenant, request);

        tenant = getRelationAttributeObject(tenant, request, type);
        baseManager.saveOrUpdate(tenant.getClass().getName(), tenant);

//        productSeries = (ProductSeries) baseManager.getObject(ProductSeries.class.getName(), productSeries.getId());

        modelMap.put("tenant", tenant);
//        modelMap.put("PPVList", product.getProductPropertyValueList());
//        modelMap.put("PSPNList", product.getProductSeries().getProductSeriesPropertyNameList());
//        modelMap.put("PSPNListSize", product.getProductSeries().getProductSeriesPropertyNameList().size());
//        String resultPage = "redirect:/basic/xm.do?qm=formProductSeriesPropertyName&conditions=productSeries.id:" + productSeries.getId();

        String resultPage = "/productPropertyValue/productPropertyValueListForm";

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
        String masterName = request.getParameter("masterName");
        String status = request.getParameter("status");
        String type = request.getParameter("type");
        String province = request.getParameter("province");
        String city = request.getParameter("city");
        String address = request.getParameter("address");

        tenant.setName(name);
        tenant.setMasterName(masterName);
        tenant.setStatus(status);
        tenant.setType(type);
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
        if (type.equals("new")){
            List<TenantSource> tenantSourceList = new ArrayList<TenantSource>();
            List<TenantCertification> tenantCertificationList = new ArrayList<TenantCertification>();
            tenant.setTenantSourceList(tenantSourceList);
            tenant.setTenantCertificationList(tenantCertificationList);
        }
        return tenant;
    }

}
