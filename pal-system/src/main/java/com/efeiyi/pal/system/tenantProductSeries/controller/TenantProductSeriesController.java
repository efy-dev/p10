package com.efeiyi.pal.system.tenantProductSeries.controller;

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

/**
 * Created by Administrator on 2015/8/23.
 * 商户-商品系列 Controller
 */

@Controller
@RequestMapping("/TenantProductSeries")
public class TenantProductSeriesController {

    @Autowired
    private BaseManager baseManager;

    @RequestMapping("/saveTenantProductSeries.do")
    public ModelAndView saveTenantProductSeries(ModelMap modelMap, HttpServletRequest request) throws Exception{

        String tenantProductSeriesId = request.getParameter("id");
        if (tenantProductSeriesId == null || tenantProductSeriesId.equals("")) {
            throw new Exception("商户系列溯源信息Id不能为空");
        }
        TenantProductSeries tenantProductSeries = (TenantProductSeries) baseManager.getObject(TenantProductSeries.class.getName(), tenantProductSeriesId);

        tenantProductSeries = setBasePropertyValue(request, tenantProductSeries);
        tenantProductSeries = getRelationAttributeObject(request, tenantProductSeries);
        baseManager.saveOrUpdate(TenantProductSeries.class.getName(), tenantProductSeries);

        modelMap.put("object", tenantProductSeries.getProductSeries());
        String resultPage = "redirect:/basic/xm.do?qm=viewProductSeries&ps=ps&id=" + tenantProductSeries.getProductSeries().getId();

        return new ModelAndView(resultPage, modelMap);
    }

    /**
     * 获取Form表单基本信息
     * @param request 获取页面参数
     * @param tenantProductSeries 商户商品系列
     * @return tenantProductSeries 商户商品系列
     */
    private TenantProductSeries setBasePropertyValue(HttpServletRequest request, TenantProductSeries tenantProductSeries){

        String craft = request.getParameter("craft");
        String region = request.getParameter("region");
        String status = request.getParameter("status");

        tenantProductSeries.setStatus(status);
        tenantProductSeries.setCraft(craft);
        tenantProductSeries.setRegion(region);

        return tenantProductSeries;
    }

    /**
     * 获取关联属性的对象
     * @param request 获取页面参数
     * @param tenantProductSeries 商户商品系列
     * @return tenantProductSeries 商户商品系列
     */
    private TenantProductSeries getRelationAttributeObject(HttpServletRequest request, TenantProductSeries tenantProductSeries){

        String productSeriesId = request.getParameter("productSeries.id");
        ProductSeries productSeries = (ProductSeries) baseManager.getObject(ProductSeries.class.getName(), productSeriesId);

        String tenantId = request.getParameter("tenant.id");
        Tenant tenant = (Tenant) baseManager.getObject(Tenant.class.getName(), tenantId);

        String tenantCertificationId = request.getParameter("tenantCertification.id");
        TenantCertification tenantCertification = (TenantCertification) baseManager.getObject(TenantCertification.class.getName(), tenantCertificationId);

        tenantProductSeries.setProductSeries(productSeries);
        tenantProductSeries.setTenant(tenant);
        tenantProductSeries.setTenantCertification(tenantCertification);

        return tenantProductSeries;
    }

}
