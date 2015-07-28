package com.efeiyi.ec.personal.master.controller;


import com.efeiyi.ec.product.model.Product;
import com.efeiyi.ec.tenant.model.Tenant;
import com.efeiyi.ec.tenant.model.TenantProject;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * Created by AC丶man on 2015/7/17.
 */

@Controller
@RequestMapping("/work")
public class MasterWorkController extends BaseMasterController {

    @Autowired
    private BaseManager baseManager;


    /**
     * 获取传承人作品列表
     * @param model
     * @return
     */
    @RequestMapping("/listMasterWork")
    public String listTenantProduct(HttpServletRequest request ,Model model) throws Exception {
        Tenant tenant = getTenantfromDomain(request);
        XQuery xQuery = new XQuery("plistMasterWork_default",tenant.getId(),request.getParameter("sort"),request);
        xQuery.put("master_id",tenant.getId());
        xQuery.addRequestParamToModel(model, request);
        List WorkList = baseManager.listPageInfo(xQuery).getList();
        model.addAttribute("tenant", tenant);
        model.addAttribute("tenantWorkList",WorkList);
        return "/tenantWork/tenantWorkList";

    }
    /**
     * 获取传承人作品详情
     * @param modelMap
     * @return
     */
    @RequestMapping("/{tenantWorkId}")
    public ModelAndView getProduct(HttpServletRequest request,@PathVariable String tenantWorkId,ModelMap modelMap){
        Product product = (Product)baseManager.getObject(Product.class.getName(), tenantWorkId);
        modelMap.addAttribute("product", product);
        return new ModelAndView("/tenantWork/tenantWorkView",modelMap);

    }
}
