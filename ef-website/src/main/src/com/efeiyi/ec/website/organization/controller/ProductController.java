package com.efeiyi.ec.website.organization.controller;


import com.efeiyi.ec.website.organization.service.ProductManger;
import com.efeiyi.ec.website.product.model.Product;
import com.ming800.core.base.controller.BaseController;
import com.ming800.core.base.service.BaseManager;

import com.thoughtworks.xstream.mapper.Mapper;
import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.List;


/**
 * Created by ACØ¼man on 2015/6/17.
 */
@RestController
@RequestMapping("/product")
public class ProductController extends BaseController {

   @Autowired
    private ProductManger productManger;
    @Autowired
    private BaseManager baseManager;

    /**
     * ÉÌÆ·µÄ±à¼­
     */

    @RequestMapping(value = "/getProduct.do")
    public ModelAndView getProduct(HttpServletRequest request, ModelMap model){
        String id = request.getParameter("pid");
        Product product = (Product) baseManager.getObject("com.efeiyi.ec.organzation.model.Product",id);
        model.addAttribute("product",product);
        return new ModelAndView("/product",model);
    }
    @RequestMapping(value= "/deleteProduct.do")
    public ModelAndView deleteProduct(HttpServletRequest request, ModelMap model){
       String id =request.getParameter("id");
       baseManager.delete("com.efeiyi.ec.organzation.model.Product",id);
       model.addAttribute("result",1);
       return new ModelAndView("/yemain",model);
    }
    @RequestMapping(value= "/removeProduct.do")
    public ModelAndView removeProduct(HttpServletRequest request,ModelMap model){
       String id = request.getParameter("id");
       baseManager.remove("com.efeiyi.ec.orgnzation.model.product",id);
       model.addAttribute("result",1);
       return new ModelAndView("/yemian",model);
    }
    @RequestMapping(value = "/saveProduct.do")
    public ModelAndView saveProduct(HttpServletRequest request,ModelMap model){
        String id =request.getParameter("id");
        baseManager.saveOrUpdate("com.efeiyi.orgnzation.model.Product",id);
        model.addAttribute("result",1);
        return new ModelAndView("/yemian",model);
    }
   @RequestMapping(value = "/productlist.do")
   public ModelAndView getProductList(HttpServletRequest request,ModelMap model){
       List<Product> productlist = productManger.getProduct();
        model.addAttribute("productlist",productlist);

           return new ModelAndView("/pc/product/productlist",model);


   }

}
