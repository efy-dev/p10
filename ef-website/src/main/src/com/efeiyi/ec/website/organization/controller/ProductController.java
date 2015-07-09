package com.efeiyi.ec.website.organization.controller;


import com.efeiyi.ec.product.model.Product;
import com.efeiyi.ec.website.organization.service.ProductManger;
import com.ming800.core.base.controller.BaseController;
import com.ming800.core.base.service.BaseManager;

import com.ming800.core.does.model.XQuery;
import com.ming800.core.does.model.XSaveOrUpdate;
import com.thoughtworks.xstream.mapper.Mapper;
import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.List;


/**
 * Created by AC丶man on 2015/6/17.
 */
@Controller
@RequestMapping("/product")
public class ProductController extends BaseController {

    @Autowired
    private ProductManger productManger;
    @Autowired
    private BaseManager baseManager;

    /**
     * 商品的编辑
     */

    @RequestMapping(value = "/getProduct.do")
    public ModelAndView getProduct(HttpServletRequest request, ModelMap model) {
        String id = request.getParameter("pid");
        Product product = (Product) baseManager.getObject("com.efeiyi.ec.organzation.model.Product", id);
        model.addAttribute("product", product);
        return new ModelAndView("/product", model);
    }

    @RequestMapping(value = "/deleteProduct.do")
    public ModelAndView deleteProduct(HttpServletRequest request, ModelMap model) {
        String id = request.getParameter("id");
        baseManager.delete("com.efeiyi.ec.organzation.model.Product", id);
        model.addAttribute("result", 1);
        return new ModelAndView("/yemain", model);
    }

    @RequestMapping(value = "/removeProduct.do")
    public ModelAndView removeProduct(HttpServletRequest request, ModelMap model) {
        String id = request.getParameter("id");
        baseManager.remove("com.efeiyi.ec.orgnzation.model.product", id);
        model.addAttribute("result", 1);
        return new ModelAndView("/yemian", model);
    }

    @RequestMapping(value = "/saveProduct.do")
    public ModelAndView saveProduct(HttpServletRequest request, ModelMap model) {
        String id = request.getParameter("id");
        baseManager.saveOrUpdate("com.efeiyi.orgnzation.model.Product", id);
        model.addAttribute("result", 1);
        return new ModelAndView("/yemian", model);
    }

    @RequestMapping(value = "/productlist.do")
    public ModelAndView getProductList(HttpServletRequest request, ModelMap model) {
        List<Product> productlist = productManger.getProduct();
        model.addAttribute("productlist", productlist);

        return new ModelAndView("/pc/product/productlist", model);


    }


    /**
     * 列出所有的产品
     *
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/product/list")
    public String listProduct(HttpServletRequest request, Model model) throws Exception {
        //在查询的时候首先需要创建XQeury对象
        XQuery xQuery = new XQuery("listPCProduct_default", request);
        List<Object> productList = baseManager.listObject(xQuery);
        model.addAttribute("productlist", productList);
        return "/pc/product/productlist";
    }


    /**
     * 分页列出固定数量的产品，通过配置PageEntity来改变数量 这里需要所有的列表页面的数据数量保持一致
     *
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/product/plist")
    public String plistProduct(HttpServletRequest request, Model model) throws Exception {
        //在查询的时候首先需要创建XQeury对象
        XQuery xQuery = new XQuery("plistPCProduct_default", request);
        List<Object> productList = baseManager.listPageInfo(xQuery).getList();
        model.addAttribute("productlist", productList);
        xQuery.addRequestParamToModel(model, request);
        return "/pc/product/productplist";
    }


    /**
     * 保存产品的样例
     */
    @RequestMapping({"/product/saveOrUpdate"})
    @ResponseBody
    public boolean saveOrUpdateProduct(HttpServletRequest request) {
        try {
            XSaveOrUpdate xSaveOrUpdate = new XSaveOrUpdate("saveOrUpdatePCProduct", request);
            baseManager.saveOrUpdate(xSaveOrUpdate);
            return true;
        } catch (Exception e) {
            return false;
        }
    }


    /**
     * 保存产品的样例
     */
    @RequestMapping({"/product/form"})
    public String formProduct(HttpServletRequest request) {
        return "/pc/product/productform";
    }


}