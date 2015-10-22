package com.efeiyi.ec.website.product.controller;

import com.efeiyi.ec.group.model.GroupProduct;
import com.efeiyi.ec.product.model.Product;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * Created by Administrator on 2015/10/20.
 */
@Controller
@RequestMapping("/product")
public class GroupProductController {
    @Autowired
    private BaseManager baseManager;

    /**
     * 团购产品列表
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/groupProduct.do")
    public String listProduct(HttpServletRequest request, Model model) throws Exception {
        XQuery xQuery = new XQuery("listGroupProduct_default",request);
        xQuery.put("status","1");
        List<Object> groupProductList = baseManager.listObject(xQuery);
        model.addAttribute("groupProductList",groupProductList);
        return "/groupProduct/groupProductList";
    }
    /**
     * 开团详情页
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/groupProduct/{groupProductId}")
    public String groupProductDetails(@PathVariable String groupProductId ,HttpServletRequest request, Model model) throws Exception {
        GroupProduct groupProduct = (GroupProduct) baseManager.getObject(GroupProduct.class.getName(), groupProductId);
        model.addAttribute("groupProduct", groupProduct);
        return "/groupProduct/groupProductDetails";
    }




}
