package com.efeiyi.ec.system.gift.controller;

import com.efeiyi.ec.gift.model.IndustrySolution;
import com.efeiyi.ec.gift.model.ProductGift;
import com.efeiyi.ec.gift.model.ProductGiftIndustrySolution;
import com.efeiyi.ec.product.model.Product;
import com.efeiyi.ec.product.model.ProductModel;
import com.ming800.core.base.service.BaseManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

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


    //关联商品批量处理方法
    @RequestMapping({"/dealProductGift.do"})
    @ResponseBody
    public String dealProductGift() {
        List<ProductModel> productModels = baseManager.listObject("select obj from ProductModel obj where obj.status!=0");
        List<ProductGift> productGiftList = new ArrayList<>();
        int testNum = 0;
        for (ProductModel productModel : productModels) {
            try {

                ProductGift productGift = new ProductGift();
                productGift.setStatus("1");
                productGift.setCreateDatetime(new Date());
                if (productModel.getProduct().getProductModelList().size() > 1) {
                    productGift.setName(productModel.getProduct().getName() + "[" + productModel.getName() + "]");
                } else {
                    productGift.setName(productModel.getName());
                }
                productGift.setProductModel(productModel);
                productGift.setProject(productModel.getProduct().getProject());
                productGift.setProjectCategory(productModel.getProduct().getProject().getProjectCategory());
                productGiftList.add(productGift);
            } catch (Exception e) {
                testNum += 1;
                continue;
            }
        }

        for (ProductGift productGift : productGiftList) {
            baseManager.saveOrUpdate(ProductGift.class.getName(), productGift);
        }
        List<ProductGift> productGifts = baseManager.listObject("select obj from ProductGift obj where obj.status!=0");
        return productGifts.size() + ":" + testNum + ":" + productGiftList.size();

    }
}
