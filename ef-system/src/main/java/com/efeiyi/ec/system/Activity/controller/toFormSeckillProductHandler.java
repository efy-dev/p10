package com.efeiyi.ec.system.Activity.controller;

import com.efeiyi.ec.product.model.ProductModel;
import com.efeiyi.ec.tenant.model.Tenant;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import com.ming800.core.does.service.DoHandler;
import com.ming800.core.util.ApplicationContextUtil;
import org.springframework.ui.ModelMap;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * Created by Administrator on 2015/7/20.
 */
public class toFormSeckillProductHandler implements DoHandler {

    private BaseManager baseManager = (BaseManager) ApplicationContextUtil.getApplicationContext().getBean("baseManagerImpl");

    @Override
    public ModelMap handle(ModelMap modelMap, HttpServletRequest request) throws Exception {

        XQuery xQuery = new XQuery("listMSProductModel_default",request);
        List<ProductModel> productModelList = baseManager.listObject(xQuery);
        modelMap.put("productModelList",productModelList);
        return modelMap;
    }
}
