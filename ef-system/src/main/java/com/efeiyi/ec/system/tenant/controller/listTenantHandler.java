package com.efeiyi.ec.system.tenant.controller;

import com.efeiyi.ec.product.model.Product;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.service.DoHandler;
import com.ming800.core.p.service.AutoSerialManager;
import com.ming800.core.util.ApplicationContextUtil;
import org.springframework.ui.ModelMap;

import javax.servlet.http.HttpServletRequest;

/**
 * Created by Administrator on 2015/7/20.
 */
public class listTenantHandler implements DoHandler {

    private BaseManager baseManager = (BaseManager) ApplicationContextUtil.getApplicationContext().getBean("baseManagerImpl");

    @Override
    public ModelMap handle(ModelMap modelMap, HttpServletRequest request) throws Exception {

        System.out.print(request.getParameter("productId"));
        Product product = (Product)baseManager.getObject(Product.class.getName(),request.getParameter("productId"));
        if(product.getTenant()!=null){
            modelMap.put("tenantId",product.getTenant().getId());
        }else {
            modelMap.put("tenantId","0");
        }

        modelMap.put("productId",request.getParameter("productId"));
        return modelMap;
    }
}
