package com.efeiyi.pal.system.product.controller;

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

public class ProductSeriesHandler implements DoHandler {

    private BaseManager baseManager = (BaseManager) ApplicationContextUtil.getApplicationContext().getBean("baseManagerImpl");
    private XdoManager xdoManager = (XdoManager) ApplicationContextUtil.getApplicationContext().getBean("xdoManagerImpl");
    private XdoDao xdoDao = (XdoDao) ApplicationContextUtil.getApplicationContext().getBean("xdoDaoSupport");

    @Override
    public ModelMap handle(ModelMap modelMap, HttpServletRequest request) throws Exception {

        ProductSeries productSeries = new ProductSeries();

        String labelBatchId = request.getParameter("id");
        String type = "new";
        if (labelBatchId != null && !labelBatchId.equals("")) {
            type = "edit";
            productSeries = (ProductSeries) baseManager.getObject(ProductSeries.class.getName(), labelBatchId);
        }
        Do tempDo = (Do) modelMap.get("tempDo");
        productSeries = (ProductSeries) XDoUtil.processSaveOrUpdateTempObject(tempDo, productSeries, productSeries.getClass(), request, type, xdoDao);

        modelMap.put("object", productSeries);
        return modelMap;
    }

}
