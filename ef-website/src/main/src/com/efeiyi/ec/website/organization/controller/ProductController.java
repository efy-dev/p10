package com.efeiyi.ec.website.organization.controller;

import com.efeiyi.ec.organization.model.User;
import com.ming800.core.base.controller.BaseController;
import com.ming800.core.base.service.BaseManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Created by ACÿºman on 2015/6/17.
 */
@RestController
@RequestMapping("/product")
public class ProductController extends BaseController {

   /* @Autowired
    private ProductManager productManager;*/
    @Autowired
    private BaseManager baseManager;

    /**
     * ÃÌº”…Ã∆∑
     */

    @RequestMapping(value = "/addProduct.do")
    public ModelAndView saveProduct(HttpServletRequest request ,HttpServletResponse response){
        User user = new User();
        /*String id = String.valueOf(request.getParameter("id"));
        if (id != null && id != ""){
            Product product = (Product) baseManager.getObject("Product",id);
            if(product == null){
                Product p = new Product();
                p.setName(String.valueOf(request.getParameter("name")));
                String str = String.valueOf(request.getParameter("price"));
                p.setPrice(BigDecimal.valueOf(Double.valueOf(str)));
                String cid = (String) request.getParameter("category");
                if (cid != null && cid != ""){
                    ProductCategory pc = (ProductCategory) baseManager.getObject("ProductCategory",cid);
                    if(pc != null){
                        p.setCategory(pc);
                    }else{
                        p.setCategory(null);
                    }
                }
                p.setPicture_url(String.valueOf(request.getParameter("picture_url")));
                p.setSerial(String.valueOf(request.getParameter("serial")));
                String tid = String.valueOf(request.getParameter("tenant"));
                if(tid != null && tid != ""){
                    Tenant ten = (Tenant) baseManager.getObject("Tenant",tid);
                    if (ten != null){
                        p.setTenant(ten);
                    }else{
                        p.setTenant(null);
                    }
                }
            }
        }else{

        }*/
        /*baseManager.saveOrUpdate("Product",p);*/
        return new ModelAndView("/");
    }

    public ModelAndView deleteProduct(){

        return new ModelAndView();
    }


}
