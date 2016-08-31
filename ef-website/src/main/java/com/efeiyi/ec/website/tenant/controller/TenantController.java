package com.efeiyi.ec.website.tenant.controller;

import com.efeiyi.ec.master.model.Master;
import com.efeiyi.ec.product.model.ProductModel;
import com.efeiyi.ec.tenant.model.Tenant;
import com.efeiyi.ec.tenant.model.TenantMaster;
import com.efeiyi.ec.website.base.util.NormalUtil;
import com.efeiyi.ec.wiki.model.Artistry;
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
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2015/8/18.
 */
@Controller
public class TenantController {

    @Autowired
    private BaseManager baseManager;

    @RequestMapping({"/tenant/{tenantId}"})
    public String listProduct(@PathVariable String tenantId, HttpServletRequest request, Model model) throws Exception {
        XQuery xQuery = new XQuery("plistProductModel_default1", request);
        xQuery.put("product_tenant_id", tenantId);
        String queryHql = "from " + TenantMaster.class.getName() + " t where t.tenant.id =:tenantId and t.status ='1' order by t.id desc";
        LinkedHashMap<String, Object> queryParamMap = new LinkedHashMap<>();
        queryParamMap.put("tenantId", tenantId);
        List<TenantMaster> list1 = baseManager.listObject(queryHql, queryParamMap);
        xQuery.addRequestParamToModel(model, request);
        List<ProductModel> productModelList = baseManager.listPageInfo(xQuery).getList();
        Map<ProductModel, String> map = new HashMap<>();
        Tenant tenant = (Tenant) baseManager.getObject(Tenant.class.getName(), tenantId);
        List<TenantMaster> tenantMasterList = tenant.getTenantMasterList();
        if (tenantMasterList != null && !tenantMasterList.isEmpty()) {
            Master master = tenantMasterList.get(0).getMaster();
            if (master != null) {
                String hql = "select obj from Artistry obj where obj.project.id=:projectId";
                LinkedHashMap<String, Object> param = new LinkedHashMap<>();
                param.put("projectId", master.getMasterProjectList().get(0).getProject().getId());
                List<Artistry> artistries = baseManager.listObject(hql, param);
                if (artistries != null && !artistries.isEmpty()) {
                    model.addAttribute("artistry", artistries.get(0));
                }
            }
        }
        model.addAttribute("productModelList", productModelList);
        model.addAttribute("tenantId", tenantId);
        model.addAttribute("tenant", tenant);
        model.addAttribute("map", map);
        model.addAttribute("tenantMasterList", list1);
        return "/tenant/productPList";
    }

    @RequestMapping({"/tenantOfMobile/{tenantId}"})
    public String listProductOfMobile(@PathVariable String tenantId, HttpServletRequest request, Model model) throws Exception {
        XQuery xQuery = new XQuery("listProductModel_default1", request);
        XQuery xQuery1 = new XQuery("listTenantMaster_default", request);
        xQuery1.put("tenant_id", tenantId);
        xQuery.put("product_tenant_id", tenantId);
        List<ProductModel> productModelList = baseManager.listPageInfo(xQuery).getList();
        Map<ProductModel, String> map = new HashMap<>();
        List list1 = baseManager.listObject(xQuery1);
        Tenant tenant = (Tenant) baseManager.getObject(Tenant.class.getName(), tenantId);
        model.addAttribute("productModelList", productModelList);
        model.addAttribute("tenant", tenant);
        model.addAttribute("tenantMasterList", list1);
        model.addAttribute("map", map);
        return "/tenant/productList";
    }


}
