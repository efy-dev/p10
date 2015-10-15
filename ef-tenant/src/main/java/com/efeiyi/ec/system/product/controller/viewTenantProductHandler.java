package com.efeiyi.ec.system.product.controller;

import com.efeiyi.ec.product.model.Product;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.base.service.XdoManager;
import com.ming800.core.does.model.Do;
import com.ming800.core.does.service.DoHandler;
import com.ming800.core.does.service.MultipartHandler;
import com.ming800.core.p.service.AliOssUploadManager;
import com.ming800.core.util.ApplicationContextUtil;
import org.springframework.ui.ModelMap;
import org.springframework.web.multipart.MultipartRequest;

import javax.servlet.http.HttpServletRequest;

/**
 * Created by Administrator on 2015/7/16.
 */
public class viewTenantProductHandler implements DoHandler {

    private AliOssUploadManager aliOssUploadManager = (AliOssUploadManager) ApplicationContextUtil.getApplicationContext().getBean("aliOssUploadManagerImpl");
    private BaseManager baseManager = (BaseManager) ApplicationContextUtil.getApplicationContext().getBean("baseManagerImpl");

    @Override
    public ModelMap handle(ModelMap modelMap, HttpServletRequest request) throws Exception {
//        if(request.getParameter("id")!="" && request.getParameter("id")!=null){
//            String id = request.getParameter("id");
//            Product product = (Product)baseManager.getObject(Product.class.getName(),id);
//            product.setStatus("2");
//            baseManager.saveOrUpdate(Product.class.getName(),product);
//        }
        modelMap.put("view",request.getParameter("view"));
        return modelMap;
    }
}
