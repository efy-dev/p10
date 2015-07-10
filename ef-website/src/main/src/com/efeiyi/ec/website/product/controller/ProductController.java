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
     * �г����еĲ�Ʒ
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/productList.do")
    public ModelAndView listProduct(HttpServletRequest request, ModelMap model) throws Exception{
        //�ڲ�ѯ��ʱ��������Ҫ����XQeury����
        XQuery xQuery = new XQuery("listProduct_default",request);
        List<Object> productList = baseManager.listObject(xQuery);
        model.addAttribute("productList",productList);
        return  new ModelAndView("/pc/product/productList",model);
    }


    /**
     * ��ҳ�г��̶������Ĳ�Ʒ��ͨ������PageEntity���ı����� ������Ҫ��֤���е��б�ҳ���������������һ��
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/product/plist")
    public String plistProduct(HttpServletRequest request, Model model) throws Exception{
        //�ڲ�ѯ��ʱ��������Ҫ����XQeury����
        XQuery xQuery = new XQuery("plistPCProduct_default",request);
        List<Object> productList = baseManager.listObject(xQuery);
        model.addAttribute("productList",productList);
        xQuery.addRequestParamToModel(model,request);
        return "/pc/productplist";
    }

}
