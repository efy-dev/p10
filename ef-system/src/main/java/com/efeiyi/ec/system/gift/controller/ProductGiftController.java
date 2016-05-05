package com.efeiyi.ec.system.gift.controller;

import com.efeiyi.ec.annotation.HttpServiceModel;
import com.efeiyi.ec.gift.model.IndustrySolution;
import com.efeiyi.ec.gift.model.ProductGift;
import com.efeiyi.ec.gift.model.ProductGiftIndustrySolution;
import com.ming800.core.base.service.BaseManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;

/**
 * Created by Administrator on 2016/5/5 0005.
 */
@Controller
public class ProductGiftController {

    @Autowired
    private BaseManager baseManager;

    @RequestMapping("/productGiftIndustrySolution/saveOrUpdate.do")
    @ResponseBody
    public boolean createProductGiftIndustrySolution(HttpServletRequest request) {
        try {
            String industryId = request.getParameter("industryId");
            String giftId = request.getParameter("giftId");
            ProductGiftIndustrySolution productGiftIndustrySolution = new ProductGiftIndustrySolution();
            productGiftIndustrySolution.setIndustrySolution((IndustrySolution) baseManager.getObject(IndustrySolution.class.getName(), industryId));
            productGiftIndustrySolution.setProductGift((ProductGift) baseManager.getObject(ProductGift.class.getName(), giftId));
            productGiftIndustrySolution.setStatus("1");
            baseManager.saveOrUpdate(ProductGiftIndustrySolution.class.getName(), productGiftIndustrySolution);
            return true;
        } catch (Exception e) {
            return false;
        }
    }
}
