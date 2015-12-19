package com.efeiyi.ec.system.zero.company.handler;

import com.efeiyi.ec.product.model.ProductModel;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import com.ming800.core.does.service.DoHandler;
import com.ming800.core.util.ApplicationContextUtil;
import org.springframework.ui.ModelMap;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * Created by Administrator on 2015/12/17.
 * 企业礼品卡Form表单 Handler
 */
public class PurchaseOrderGiftFormHandler implements DoHandler {

    private BaseManager baseManager = (BaseManager) ApplicationContextUtil.getApplicationContext().getBean("baseManagerImpl");

    @Override
    public ModelMap handle(ModelMap modelMap, HttpServletRequest request) throws Exception {
        //获取商品列表
        XQuery xQuery = new XQuery("listProductModel_companyDefault",request);
        List<ProductModel> productModelList = baseManager.listObject(xQuery);
        modelMap.put("productModelList", productModelList);
        return modelMap;
    }
}
