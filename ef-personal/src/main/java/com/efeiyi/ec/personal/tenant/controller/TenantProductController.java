package com.efeiyi.ec.personal.tenant.controller;


import com.efeiyi.ec.product.model.ProductDescription;
import com.efeiyi.ec.product.model.ProductPicture;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.LinkedHashMap;
import java.util.List;

/**
 * Created by AC丶man on 2015/7/17.
 */

@Controller
@RequestMapping("/tenantWork")
public class TenantProductController {

    @Autowired
    private BaseManager baseManager;


    /**
     * 获取传承人作品列表
     * @param model
     * @return
     */
    @RequestMapping("/tenantWorkList.do")
    public String listTenantProduct(HttpServletRequest request ,Model model) throws Exception {

        XQuery xQuery = new XQuery("plistTenantWork_default",request);
        xQuery.addRequestParamToModel(model, request);
        List tenantWorkList = baseManager.listPageInfo(xQuery).getList();
        model.addAttribute("tenantWorkList",tenantWorkList);

        return "/tenantWork/tenantWorkList";

    }
    /**
     * 获取传承人作品详情
     * @param modelMap
     * @return
     */
    @RequestMapping("/getProduct.do")
    public ModelAndView getProduct(HttpServletRequest request ,ModelMap modelMap){
        String productId = request.getParameter("productId");
        String queryHql = "from ProductDescription p where p.product.id = :productId";
        String queryHql1 = "from ProductPicture pr where pr.product.id = :productId";
        LinkedHashMap<String,Object> queryParamMap = new LinkedHashMap<>();
        queryParamMap.put("productId", productId);
        //Product product = (Product)baseManager.getObject(Product.class.getName(), productId);
        ProductDescription productDescription = (ProductDescription) baseManager.getUniqueObjectByConditions(queryHql, queryParamMap);
        ProductPicture productPicture = (ProductPicture) baseManager.getUniqueObjectByConditions(queryHql1, queryParamMap);
        modelMap.addAttribute("productDescription",productDescription);
        modelMap.addAttribute("productPicture", productPicture);
        return new ModelAndView("/tenantWork/tenantWorkView",modelMap);

    }

}
