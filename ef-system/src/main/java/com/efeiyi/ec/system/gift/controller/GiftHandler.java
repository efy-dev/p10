package com.efeiyi.ec.system.gift.controller;

import com.efeiyi.ec.product.model.Product;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import com.ming800.core.does.service.DoHandler;
import com.ming800.core.util.ApplicationContextUtil;
import org.springframework.ui.ModelMap;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * Created by Administrator on 2016/4/21.
 */
public class GiftHandler implements DoHandler {
    private BaseManager baseManager = (BaseManager) ApplicationContextUtil.getApplicationContext().getBean("baseManagerImpl");

    @Override
    public ModelMap handle(ModelMap modelMap, HttpServletRequest request) throws Exception {
        XQuery xQuery = new XQuery("plistGiftProduct_default", request);
        List<Product> productList = (List<Product>) baseManager.listObject(xQuery);
        modelMap.put("productList", productList);

        XQuery labelQuery = new XQuery("plistGiftTag_default", request);
        List<Product> tagList = (List<Product>) baseManager.listObject(labelQuery);
        modelMap.put("tagList", tagList);
        return modelMap;
    }
}
