package com.efeiyi.ec.system.gift.controller;

import com.efeiyi.ec.gift.model.ProductGift;
import com.efeiyi.ec.gift.model.ProductGiftTag;
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
        Object productGift = modelMap.get("object");
        XQuery xQuery = new XQuery("listProductGiftTag_default", request);
        xQuery.put("productGift_id", ((ProductGift) productGift).getId());
        List<ProductGiftTag> productGiftTagList = baseManager.listObject(xQuery);
        modelMap.put("productGiftTagList",productGiftTagList);

        XQuery labelQuery = new XQuery("plistGiftTag_default", request);
        List<Product> tagList = (List<Product>) baseManager.listObject(labelQuery);
        modelMap.put("tagList", tagList);
        return modelMap;
    }
}
