package com.efeiyi.ec.system.gift.controller;

import com.efeiyi.ec.gift.model.IndustrySolution;
import com.efeiyi.ec.gift.model.ProductGiftIndustrySolution;
import com.efeiyi.ec.product.model.Product;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import com.ming800.core.does.service.DoHandler;
import com.ming800.core.util.ApplicationContextUtil;
import org.springframework.ui.ModelMap;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * Created by Administrator on 2016/5/5 0005.
 */
public class ProductGiftIndustrySolutionHandler implements DoHandler {

    private BaseManager baseManager = (BaseManager) ApplicationContextUtil.getApplicationContext().getBean("baseManagerImpl");

    public ModelMap handle(ModelMap modelMap, HttpServletRequest request) throws Exception {

        Object object = modelMap.get("object"); //industrySolution
        //通过这个solution获得所有与它关联的礼品
        XQuery xQuery = new XQuery("listProductGiftIndustrySolution_default", request);
        xQuery.put("industrySolution_id", ((IndustrySolution) object).getId());
        List<ProductGiftIndustrySolution> productGiftIndustrySolutionList = baseManager.listObject(xQuery);
        modelMap.put("giftList", productGiftIndustrySolutionList);
        return modelMap;
    }
}
