package com.efeiyi.ec.website.tenant.controller;

import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * Created by Administrator on 2015/8/18.
 */
@Controller
public class TenantController {

    @Autowired
    private BaseManager baseManager;

    @RequestMapping({"/tenant/listProduct"})
    public String listProduct(HttpServletRequest request,Model model) throws Exception {
        XQuery xQuery = new XQuery("plistProduct_default", request);
        xQuery.addRequestParamToModel(model,request);
        List productList =baseManager.listObject(xQuery);
        model.addAttribute("productList", productList);
        return "/tenant/productList";
    }
}
