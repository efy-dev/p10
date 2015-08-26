package com.efeiyi.pal.system.organization.controller;

import com.efeiyi.pal.organization.model.Tenant;
import com.efeiyi.pal.organization.model.TenantCertification;
import com.efeiyi.pal.product.model.ProductSeries;
import com.efeiyi.pal.product.model.TenantProductSeries;
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

//    @RequestMapping("/saveTenant.do")
//    public ModelAndView saveTenant(ModelMap modelMap, HttpServletRequest request) throws Exception {
//        Tenant tenant = new Tenant();
//
//        String tenantId = request.getParameter("id");
//        String type = "new";
//        if (tenantId != null && !tenantId.equals("")) {
//            type = "edit";
//            tenant = (Tenant) baseManager.getObject(Tenant.class.getName(), tenantId);
//        }
//
//        tenant = setTenantBaseProperty(tenant, request);
//
//        tenant = getRelationAttributeObject(tenant, request, type);
//        baseManager.saveOrUpdate(tenant.getClass().getName(), tenant);
//
////        productSeries = (ProductSeries) baseManager.getObject(ProductSeries.class.getName(), productSeries.getId());
//
//        modelMap.put("tenant", tenant);
////        modelMap.put("PPVList", product.getProductPropertyValueList());
////        modelMap.put("PSPNList", product.getProductSeries().getProductSeriesPropertyNameList());
////        modelMap.put("PSPNListSize", product.getProductSeries().getProductSeriesPropertyNameList().size());
////        String resultPage = "redirect:/basic/xm.do?qm=formProductSeriesPropertyName&conditions=productSeries.id:" + productSeries.getId();
//
//        String resultPage = "/productPropertyValue/productPropertyValueListForm";
//
//        return new ModelAndView(resultPage);
//    }

//    @RequestMapping("/selectProductSeries.do")
//    public ModelAndView selectProductSeries(ModelMap modelMap, HttpServletRequest request) throws Exception {
//        String tenantId = request.getParameter("tenantId");
//        if (tenantId == null || tenantId.trim().equals("")) {
//            throw new Exception("商户id不能为空!");
//        }
//        Tenant tenant = (Tenant) baseManager.getObject(Tenant.class.getName(), tenantId);
//        String message = "请不要选择已存在的商品系列!";
//
//        modelMap.put("tenant", tenant);
//        modelMap.put("message", message);
//        String resultPage = "/tenant/tenantProductSeriesForm";
//        return new ModelAndView(resultPage);
//    }

    @RequestMapping("/saveTenantProductSeries.do")
    public ModelAndView saveTenantProductSeries(ModelMap modelMap, HttpServletRequest request) throws Exception {
        String tenantId = request.getParameter("tenant.id");
        String productSeriesId = request.getParameter("productSeries.id");
        Tenant tenant = (Tenant) baseManager.getObject(Tenant.class.getName(), tenantId);
        ProductSeries productSeries = (ProductSeries) baseManager.getObject(ProductSeries.class.getName(), productSeriesId);

//        boolean tag = false;
//        for (TenantProductSeries tps:tenant.getTenantProductSeriesList()){
//            if (tps.getProductSeries().equals(productSeries)){
//                tag = true;
//                break;
//            }
//        }
//
//        if (!tag){
//            TenantProductSeries tenantProductSeries = new TenantProductSeries();
//            tenantProductSeries.setTenant(tenant);
//            tenantProductSeries.setProductSeries(productSeries);
//            tenantProductSeries.setStatus("1");
//            baseManager.saveOrUpdate(TenantProductSeries.class.getName(), tenantProductSeries);
//        }
        TenantProductSeries tenantProductSeries = new TenantProductSeries();
        tenantProductSeries.setTenant(tenant);
        tenantProductSeries.setProductSeries(productSeries);
        tenantProductSeries.setStatus("1");
        if (!tenant.getTenantProductSeriesList().contains(tenantProductSeries)){
            baseManager.saveOrUpdate(TenantProductSeries.class.getName(), tenantProductSeries);
        }


//        if (!tenant.getProductSeriesSet().contains(productSeries)){
//            tenant.getProductSeriesSet().add(productSeries);
//            baseManager.saveOrUpdate(Tenant.class.getName(), tenant);

//            modelMap.put("object", tenant);
//            String resultPage = "/tenant/tenantView";
//            return new ModelAndView(resultPage);
//        }
//        else {
//            String message = "该商品系列已存在!请重新选择";
//
//            modelMap.put("tenant", tenant);
//            modelMap.put("message", message);
//            String resultPage = "/tenant/tenantProductSeriesForm";
//            return new ModelAndView(resultPage);
//        }

//        modelMap.put("object", tenant);
//        String resultPage = "/tenant/tenantView";
        String resultPage = "redirect:/basic/xm.do?qm=viewTenant&tenant=tenant&id=" + tenant.getId();
        return new ModelAndView(resultPage);

    }

    @RequestMapping("/delTenantProductSeries.do")
    public ModelAndView delTenantProductSeries(ModelMap modelMap, HttpServletRequest request) throws Exception {
        String tenantProductSeriesId = request.getParameter("tenantProductSeriesId");
        TenantProductSeries tenantProductSeries = (TenantProductSeries) baseManager.getObject(TenantProductSeries.class.getName(), tenantProductSeriesId);
        String tenantId = request.getParameter("tenantId");
        Tenant tenant = (Tenant) baseManager.getObject(Tenant.class.getName(), tenantId);
//        String productSeriesId = request.getParameter("productSeriesId");
//        ProductSeries productSeries = (ProductSeries) baseManager.getObject(ProductSeries.class.getName(), productSeriesId);

//        tenant.getProductSeriesSet().remove(productSeries);
//        baseManager.saveOrUpdate(Tenant.class.getName(), tenant);
        tenantProductSeries.setStatus("0");
        baseManager.saveOrUpdate(TenantProductSeries.class.getName(), tenantProductSeries);

        modelMap.put("object", tenant);
//        String resultPage = "/tenant/tenantView";
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
