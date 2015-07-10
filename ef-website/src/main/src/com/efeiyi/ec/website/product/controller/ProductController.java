package com.efeiyi.ec.website.product.controller;

import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
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

    /**
     * 列出所有的产品
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/productList.do")
    public ModelAndView listProduct(HttpServletRequest request, ModelMap model) throws Exception{
        //在查询的时候首先需要创建XQeury对象
        XQuery xQuery = new XQuery("listProduct_default",request);
        List<Object> productList = baseManager.listObject(xQuery);
        model.addAttribute("productList",productList);
        return  new ModelAndView("/pc/product/productList",model);
    }


    /**
     * 分页列出固定数量的产品，通过配置PageEntity来改变数量 这里需要保证所有的列表页面的数据数量保持一致
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/product/plist")
    public String plistProduct(HttpServletRequest request, Model model) throws Exception{
        //在查询的时候首先需要创建XQeury对象
        XQuery xQuery = new XQuery("plistPCProduct_default",request);
        List<Object> productList = baseManager.listObject(xQuery);
        model.addAttribute("productList",productList);
        xQuery.addRequestParamToModel(model,request);
        return "/pc/productplist";
    }

}
