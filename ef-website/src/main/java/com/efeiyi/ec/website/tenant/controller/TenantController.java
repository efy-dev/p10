package com.efeiyi.ec.website.tenant.controller;

import com.efeiyi.ec.product.model.ProductModel;
import com.efeiyi.ec.tenant.model.Tenant;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.Page;
import com.ming800.core.does.model.PageInfo;
import com.ming800.core.does.model.XQuery;
import com.ming800.core.p.service.AutoSerialManager;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * Created by Administrator on 2015/8/18.
 */
@Controller
public class TenantController {

    @Autowired
    private BaseManager baseManager;

    @RequestMapping({"/tenant/{tenantId}"})
    public String listProduct(@PathVariable String tenantId, HttpServletRequest request, Model model) throws Exception {
        XQuery xQuery = new XQuery("plistProductModel_default1",request,12);
        xQuery.put("product_tenant_id",tenantId);
        XQuery xQuery1 = new XQuery("listTenantMaster_default",request);
        xQuery1.put("tenant_id",tenantId);
        xQuery.addRequestParamToModel(model,request);
        List<ProductModel> list = baseManager.listPageInfo(xQuery).getList();
        Tenant tenant = (Tenant) baseManager.getObject(Tenant.class.getName(),tenantId);
        List list1 = baseManager.listObject(xQuery1);
        model.addAttribute("productModelList", list);
        model.addAttribute("tenantId",tenantId);
        model.addAttribute("tenant",tenant);
        model.addAttribute("tenantMasterList",list1);
        return "/tenant/productPList";
    }

    @RequestMapping({"/tenantOfMobile/{tenantId}"})
    public String listProductOfMobile(@PathVariable String tenantId,HttpServletRequest request,Model model) throws Exception {
        XQuery xQuery = new XQuery("listProductModel_default1", request);
        XQuery xQuery1 = new XQuery("listTenantMaster_default",request);
        xQuery1.put("tenant_id",tenantId);
        xQuery.put("product_tenant_id",tenantId);
        List list = baseManager.listObject(xQuery);
        List list1 = baseManager.listObject(xQuery1);
        Tenant tenant = (Tenant) baseManager.getObject(Tenant.class.getName(), tenantId);
        model.addAttribute("productModelList", list);
        model.addAttribute("tenant",tenant);
        model.addAttribute("tenantMasterList",list1);
        return "/tenant/productList";
    }

}
