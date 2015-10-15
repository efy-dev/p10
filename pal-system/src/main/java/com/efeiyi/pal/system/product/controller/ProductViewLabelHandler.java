package com.efeiyi.pal.system.product.controller;

import com.efeiyi.pal.product.model.Product;
import com.efeiyi.pal.system.product.service.ProductServiceManager;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.service.DoHandler;
import com.ming800.core.util.ApplicationContextUtil;
import org.springframework.ui.ModelMap;

import javax.servlet.http.HttpServletRequest;

/**
 * Created by Administrator on 2015/8/22.
 * 商品查看 Handler
 */
public class ProductViewLabelHandler implements DoHandler {

    private ProductServiceManager productServiceManager = (ProductServiceManager) ApplicationContextUtil.getApplicationContext().getBean("productServiceManagerImpl");
    private BaseManager baseManager = (BaseManager) ApplicationContextUtil.getApplicationContext().getBean("baseManagerImpl");

    @Override
    public ModelMap handle(ModelMap modelMap, HttpServletRequest request) throws Exception {

        String productId = request.getParameter("id");
        if (productId == null || productId.equals("")) {
            throw new Exception("商品Id为空");
        }
        Product product = (Product) baseManager.getObject(Product.class.getName(), productId);

        boolean tag = false;
        if (product != null){
            tag = productServiceManager.getDeliverLabelByProduct(product);
        }

        modelMap.put("tag", tag);
        modelMap.put("object", product);
        return modelMap;
    }
}
