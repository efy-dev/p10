package com.efeiyi.pal.system.product.controller;

import com.efeiyi.pal.organization.model.Tenant;
import com.efeiyi.pal.product.model.ProductSeries;
import com.efeiyi.pal.product.model.ProductSeriesPropertyName;
import com.efeiyi.pal.product.model.TenantProductSeries;
import com.ming800.core.base.dao.XdoDao;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.base.service.XdoManager;
import com.ming800.core.base.util.XDoUtil;
import com.ming800.core.does.model.Do;
import com.ming800.core.p.service.AutoSerialManager;
import com.ming800.core.util.ApplicationContextUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;

/**
 * Created by Administrator on 2015/7/30.
 */

@Controller
@RequestMapping("/productSeries")
public class ProductSeriesController {

    @Autowired
    private AutoSerialManager autoSerialManager;

    private BaseManager baseManager = (BaseManager) ApplicationContextUtil.getApplicationContext().getBean("baseManagerImpl");
    private XdoManager xdoManager = (XdoManager) ApplicationContextUtil.getApplicationContext().getBean("xdoManagerImpl");
    private XdoDao xdoDao = (XdoDao) ApplicationContextUtil.getApplicationContext().getBean("xdoDaoSupport");

    @RequestMapping("/saveProductSeries.do")
    public ModelAndView saveProductSeries(ModelMap modelMap, HttpServletRequest request) throws Exception {
        ProductSeries productSeries = new ProductSeries();

        String productSeriesId = request.getParameter("id");
        String type = "new";
        if (productSeriesId != null && !productSeriesId.equals("")) {
            type = "edit";
            productSeries = (ProductSeries) baseManager.getObject(ProductSeries.class.getName(), productSeriesId);
        }
        productSeries = setProductSeriesProperty(productSeries, request);

        productSeries = getRelationAttributeObject(productSeries, request, type);
        baseManager.saveOrUpdate(productSeries.getClass().getName(), productSeries);

        modelMap.put("productSeries", productSeries);
//        modelMap.put("PSPNListSize", productSeries.getProductSeriesPropertyNameList().size());
//        String resultPage = "redirect:/basic/xm.do?qm=formProductSeriesPropertyName&conditions=productSeries.id:" + productSeries.getId();

//        String resultPage = "/productSeriesPropertyName/productSeriesPropertyNameListForm";
        String resultPage = "redirect:/basic/xm.do?qm=viewProductSeries&ps=ps&id=" + productSeries.getId();
        return new ModelAndView(resultPage, modelMap);
    }

    /**
     * 获取关联属性的对象
     * @param productSeries
     * @param request
     * @param type
     * @return
     */
    private ProductSeries getRelationAttributeObject(ProductSeries productSeries, HttpServletRequest request, String type){
//        String tenantId = request.getParameter("tenant.id");
//        Tenant tenant = (Tenant) baseManager.getObject(Tenant.class.getName(), tenantId);

        if (type.equals("new")){
            List<ProductSeriesPropertyName> productSeriesPropertyNameList = new ArrayList();
            productSeries.setProductSeriesPropertyNameList(productSeriesPropertyNameList);
//            productSeries.setTenantSet(new HashSet<Tenant>());
            productSeries.setTenantProductSeriesList(new ArrayList<TenantProductSeries>());
        }

//        productSeries.setTenant(tenant);

        return productSeries;
    }

    /**
     * 获取Form表单基本数据
     * @param productSeries
     * @param request
     * @return
     */
    private ProductSeries setProductSeriesProperty(ProductSeries productSeries, HttpServletRequest request) throws Exception{
        String name = request.getParameter("name");
//        String serial = request.getParameter("serial");
        String status = request.getParameter("status");

        String serial = autoSerialManager.nextSerial("serial");

        productSeries.setName(name);
        productSeries.setSerial(serial);
        productSeries.setStatus(status);

        return productSeries;
    }

}
