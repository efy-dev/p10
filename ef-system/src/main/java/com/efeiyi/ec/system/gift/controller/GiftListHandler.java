package com.efeiyi.ec.system.gift.controller;

import com.efeiyi.ec.gift.model.ProductGift;
import com.efeiyi.ec.gift.model.ProductGiftTag;
import com.efeiyi.ec.product.model.Product;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.PageInfo;
import com.ming800.core.does.model.XQuery;
import com.ming800.core.does.service.DoHandler;
import com.ming800.core.util.ApplicationContextUtil;
import org.apache.solr.common.util.Hash;
import org.springframework.ui.ModelMap;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2016/5/16 0016.
 */
public class GiftListHandler implements DoHandler {

    private BaseManager baseManager = (BaseManager) ApplicationContextUtil.getApplicationContext().getBean("baseManagerImpl");

    @Override
    public ModelMap handle(ModelMap modelMap, HttpServletRequest request) throws Exception {
        PageInfo pageInfo = (PageInfo) modelMap.get("pageInfo");
        List<ProductGift> productGiftList = pageInfo.getList();
        Map<String, List<ProductGiftTag>> result = new HashMap<>();
        for (ProductGift productGift : productGiftList) {
            List<ProductGiftTag> productGiftTagList = baseManager.listObject("select obj from ProductGiftTag obj where obj.status=1 and obj.productGift.id='" + productGift.getId() + "'");
            result.put(productGift.getId(), productGiftTagList);
        }
        modelMap.put("productGiftTagMap", result);
        return modelMap;
    }

}
