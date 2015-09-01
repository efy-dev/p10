package com.efeiyi.ec.website.tenant.controller;

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

    @RequestMapping({"/tenant/view"})
    public String listProduct(HttpServletRequest request,Model model) throws Exception {
         XQuery xQuery = new XQuery("plistProductModel_default1", request,20);
        String conditions = request.getParameter("conditions");
        String tenantId = conditions.substring(18,conditions.length());
        xQuery.addRequestParamToModel(model,request);
        PageInfo pageInfo =baseManager.listPageInfo(xQuery);
        model.addAttribute("productModelList", pageInfo.getList());
        model.addAttribute("tenantId",tenantId);
        return "/tenant/productPList";
    }

    @RequestMapping({"/tenantOfMobile/view"})
    public String listProductOfMobile(HttpServletRequest request,Model model) throws Exception {
        XQuery xQuery = new XQuery("listProductModel_default1", request);
        String tenantId = request.getParameter("product.tenant.id");
        xQuery.put("product_tenant_id",tenantId);
        List list = baseManager.listObject(xQuery);
        Tenant tenant = (Tenant) baseManager.getObject(Tenant.class.getName(), tenantId);
        model.addAttribute("productModelList", list);
        model.addAttribute("tenant",tenant);
        return "/tenant/productList";
    }

}
