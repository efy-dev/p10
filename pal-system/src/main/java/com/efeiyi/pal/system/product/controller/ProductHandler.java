package com.efeiyi.pal.system.product.controller;

import com.efeiyi.pal.organization.model.Tenant;
import com.efeiyi.pal.product.model.Product;
import com.efeiyi.pal.product.model.ProductSeries;
import com.ming800.core.base.dao.XdoDao;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.base.service.XdoManager;
import com.ming800.core.base.util.XDoUtil;
import com.ming800.core.does.model.Do;
import com.ming800.core.does.service.DoHandler;
import com.ming800.core.util.ApplicationContextUtil;
import org.springframework.ui.ModelMap;

import javax.servlet.http.HttpServletRequest;

/**
 * Created by Administrator on 2015/7/23.
 */

public class ProductHandler implements DoHandler {

    private BaseManager baseManager = (BaseManager) ApplicationContextUtil.getApplicationContext().getBean("baseManagerImpl");
    private XdoManager xdoManager = (XdoManager) ApplicationContextUtil.getApplicationContext().getBean("xdoManagerImpl");
    private XdoDao xdoDao = (XdoDao) ApplicationContextUtil.getApplicationContext().getBean("xdoDaoSupport");

    @Override
    public ModelMap handle(ModelMap modelMap, HttpServletRequest request) throws Exception {

        Product product = new Product();

        String labelBatchId = request.getParameter("id");
        String type = "new";
        if (labelBatchId != null && !labelBatchId.equals("")) {
            type = "edit";
            product = (Product) baseManager.getObject(Product.class.getName(), labelBatchId);
        }
        Do tempDo = (Do) modelMap.get("tempDo");
        product = (Product) XDoUtil.processSaveOrUpdateTempObject(tempDo, product, product.getClass(), request, type, xdoDao);

        product = getRelationAttributeObject(product, request);

        modelMap.put("object", product);
        return modelMap;
    }

    /**
     * 获取关联属性的对象
     * @param product
     * @param request
     * @return
     */
    private Product getRelationAttributeObject(Product product, HttpServletRequest request){
        ProductSeries productSeries = null;
        Tenant tenant = null;

        String productSeriesId = request.getParameter("productSeries.id");
        if (productSeriesId != null && !productSeriesId.trim().equals("")){
            productSeries = (ProductSeries) baseManager.getObject(ProductSeries.class.getName(), productSeriesId);
        }

        if (productSeries != null){
            tenant = productSeries.getTenant();
        }

//        String tenantId = request.getParameter("tenant.id");
//        Tenant tenant = (Tenant) baseManager.getObject(Tenant.class.getName(), tenantId);
        product.setTenant(tenant);
        product.setProductSeries(productSeries);
        return product;
    }

}
