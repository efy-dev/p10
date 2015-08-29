package com.efeiyi.pal.system.product.controller;

import com.efeiyi.pal.product.model.ProductSeries;
import com.efeiyi.pal.system.product.service.ProductSeriesServiceManager;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.service.DoHandler;
import com.ming800.core.util.ApplicationContextUtil;
import org.springframework.ui.ModelMap;

import javax.servlet.http.HttpServletRequest;

/**
 * Created by Administrator on 2015/8/28.
 *
 */

public class ProductSeriesRemoveHandler implements DoHandler {

    private BaseManager baseManager = (BaseManager) ApplicationContextUtil.getApplicationContext().getBean("baseManagerImpl");
    private ProductSeriesServiceManager productSeriesServiceManager = (ProductSeriesServiceManager) ApplicationContextUtil.getApplicationContext().getBean("productSeriesServiceManagerImpl");

    @Override
    public ModelMap handle(ModelMap modelMap, HttpServletRequest request) throws Exception {

        String productSeriesId = request.getParameter("id");
        if (productSeriesId == null || "".equals(productSeriesId)) {
            throw new Exception("非遗项目Id不能为空");
        }
        ProductSeries productSeries = (ProductSeries) baseManager.getObject(ProductSeries.class.getName(), productSeriesId);
        productSeriesServiceManager.removeTenantProductSeriesByProductSeries(productSeries);

        modelMap.put("object", productSeries);
        return modelMap;
    }
}
