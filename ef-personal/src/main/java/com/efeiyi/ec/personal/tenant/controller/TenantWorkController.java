package com.efeiyi.ec.personal.tenant.controller;


import com.efeiyi.ec.product.model.Product;
import com.efeiyi.ec.master.model.Master;
import com.efeiyi.ec.master.model.MasterProject;
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
import java.util.LinkedHashMap;
import java.util.List;

/**
 * Created by AC丶man on 2015/7/17.
 */

@Controller
@RequestMapping("/work")
public class TenantWorkController extends BaseTenantController {

    @Autowired
    private BaseManager baseManager;


    /**
     * 获取传承人作品列表
     * @param model
     * @return
     */
    @RequestMapping("/listTenantWork")
    public String listTenantProduct(HttpServletRequest request ,Model model) throws Exception {
        /*String conditions = request.getParameter("conditions");
        String tenantId = conditions.substring(10,conditions.length());*/
        Master master = getTenantfromDomain(request);
        LinkedHashMap<String,Object> queryParamMap = new LinkedHashMap<>();
        XQuery xQuery = new XQuery("plistTenantWork_default", master.getId(),request.getParameter("sort"),request);
        xQuery.put("tenant_id", master.getId());
        xQuery.addRequestParamToModel(model, request);
        List tenantWorkList = baseManager.listPageInfo(xQuery).getList();

        model.addAttribute("tenant", master);
        model.addAttribute("tenantWorkList",tenantWorkList);
        XQuery xQuery1 = new XQuery("listProject_default",request);
        xQuery1.put("tenant_id", master.getId());
        List<MasterProject> masterProjectList = baseManager.listObject(xQuery1);
        model.addAttribute("tenantProjectList", masterProjectList);

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
