package com.efeiyi.ec.website.product.controller;

import com.efeiyi.ec.product.model.Product;
import com.efeiyi.ec.product.model.ProductFavorite;
import com.efeiyi.ec.website.organization.util.AuthorizationUtil;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import com.ming800.core.does.model.XSaveOrUpdate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * Created by Administrator on 2015/7/8.
 */
@Controller
@RequestMapping("/product")
public class ProductController {

    @Autowired
    private BaseManager baseManager;

    @RequestMapping(value = "/productList.do")
    public ModelAndView listProduct(HttpServletRequest request, ModelMap model) throws Exception{
        String id= request.getParameter("id");
        XQuery xQuery = new XQuery("listProduct_default",request);
        List productList = baseManager.listObject(xQuery);
        model.addAttribute("productList",productList);
        return  new ModelAndView("/pc/product/productList",model);
    }


    @RequestMapping("/product/plist.do")
    public String plistProduct(HttpServletRequest request, Model model) throws Exception{
        XQuery xQuery = new XQuery("plistProduct_default",request);
        xQuery.addRequestParamToModel(model,request);
        List productList = baseManager.listPageInfo(xQuery).getList();
        model.addAttribute("productList",productList);
        return "/pc/product/productpList";
    }

    @RequestMapping(value = "/getProduct.do")
    public String getProduct(HttpServletRequest request, Model model) {
        String id = request.getParameter("id");
        Product product = (Product) baseManager.getObject(Product.class.getName(), id);
        model.addAttribute("product", product);
        return "/pc/product/productView";
    }


    @RequestMapping({"/addProductFavorite.do"})
    @ResponseBody
    public boolean addProductFavorite(HttpServletRequest request) throws Exception{
        XSaveOrUpdate xSaveOrUpdate = new XSaveOrUpdate("saveOrUpdateProductFavorite" ,request);
        xSaveOrUpdate.getParamMap().put("user_id", AuthorizationUtil.getMyUser().getId());
        baseManager.saveOrUpdate(xSaveOrUpdate);
        return true;
    }


    @RequestMapping({"/removeProductFavorite.do"})
    @ResponseBody
    public boolean removeProductFavorite(HttpServletRequest request) throws Exception{
        baseManager.remove(ProductFavorite.class.getName(),request.getParameter("productFavoriteId"));
        return true;
    }

    @RequestMapping({"/favorite/list"})
    public List<Object> listProductFavorite(HttpServletRequest request) throws Exception{
        XQuery xQuery = new XQuery("plistProductFavorite_default",request);
        List<Object> objectList = baseManager.listObject(xQuery);
        return objectList;
    }




}
