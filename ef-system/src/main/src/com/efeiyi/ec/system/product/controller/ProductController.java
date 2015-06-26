package com.efeiyi.ec.system.product.controller;



import com.efeiyi.ec.product.model.Product;
import com.ming800.core.base.controller.BaseController;
import com.ming800.core.base.service.BaseManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Iterator;
import java.util.List;

/**
 * Created by Administrator on 2015/6/18.
 */
@Controller
@RequestMapping("/product")
public class ProductController extends BaseController {
    @Autowired
    private BaseManager baseManager;

    @RequestMapping("/listProduct.do")
    public ModelAndView getProductList(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {

        List<Product> list = baseManager.listObject("from Product");
        for (Iterator<Product> i = list.iterator();i.hasNext();){
            Product product = i.next();
            System.out.println(product.getName());

        }
        modelMap.put("listProduct", list);
        return new ModelAndView("/pc/product/productList", modelMap);
    }


}
