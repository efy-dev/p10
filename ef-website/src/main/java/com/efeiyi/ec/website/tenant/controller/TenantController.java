package com.efeiyi.ec.website.tenant.controller;

import com.efeiyi.ec.product.model.ProductModel;
import com.efeiyi.ec.tenant.model.Tenant;
import com.efeiyi.ec.tenant.model.TenantMaster;
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
        XQuery xQuery = new XQuery("plistProductModel_default1",request);
        xQuery.put("product_tenant_id",tenantId);

        String queryHql = "from "+TenantMaster.class.getName()+" t where t.tenant.id =:tenantId and t.status ='1' order by t.id desc";
        LinkedHashMap<String , Object> queryParamMap = new LinkedHashMap<>();
        queryParamMap.put("tenantId",tenantId);
        List<TenantMaster> list1 = baseManager.listObject(queryHql,queryParamMap);
        xQuery.addRequestParamToModel(model,request);
        List<ProductModel> productModelList = baseManager.listPageInfo(xQuery).getList();
        Map<ProductModel,String> map = new HashMap<>();
        if(productModelList!=null&&productModelList.size()>0){
            for(ProductModel productModelTemp:productModelList){
                StringBuilder s = new StringBuilder(productModelTemp.getProduct().getName());
                if(productModelTemp.getProduct().getProductModelList().size()==1){
                    map.put(productModelTemp,s.toString());
                }else{
                    s.append("[").append(productModelTemp.getName());
                    if(s.toString().length()>14){
                        s = new StringBuilder(s.substring(0,14));
                        s.append("...").append("]");
                    }else{
                        s.append("]");
                    }
                    map.put(productModelTemp,s.toString());
                }
            }
        }
        Tenant tenant = (Tenant) baseManager.getObject(Tenant.class.getName(),tenantId);
        model.addAttribute("productModelList", productModelList);
        model.addAttribute("tenantId",tenantId);
        model.addAttribute("tenant",tenant);
        model.addAttribute("map",map);
        model.addAttribute("tenantMasterList",list1);
        return "/tenant/productPList";
    }

    @RequestMapping({"/tenantOfMobile/{tenantId}"})
    public String listProductOfMobile(@PathVariable String tenantId,HttpServletRequest request,Model model) throws Exception {
        XQuery xQuery = new XQuery("listProductModel_default1", request);
        XQuery xQuery1 = new XQuery("listTenantMaster_default",request);
        xQuery1.put("tenant_id",tenantId);
        xQuery.put("product_tenant_id",tenantId);
        List<ProductModel> productModelList = baseManager.listPageInfo(xQuery).getList();
        Map<ProductModel,String> map = new HashMap<>();
        if(productModelList!=null&&productModelList.size()>0){
            for(ProductModel productModelTemp:productModelList){
                StringBuilder s = new StringBuilder(productModelTemp.getProduct().getName());
                if(productModelTemp.getProduct().getProductModelList().size()==1){
                    map.put(productModelTemp,s.toString());
                }else{
                    s.append("[").append(productModelTemp.getName());
                    if(s.toString().length()>14){
                        s = new StringBuilder(s.substring(0,14));
                        s.append("...").append("]");
                    }else{
                        s.append("]");
                    }
                    map.put(productModelTemp,s.toString());
                }
            }
        }
        List list1 = baseManager.listObject(xQuery1);
        Tenant tenant = (Tenant) baseManager.getObject(Tenant.class.getName(), tenantId);
        model.addAttribute("productModelList", productModelList);
        model.addAttribute("tenant",tenant);
        model.addAttribute("tenantMasterList",list1);
        model.addAttribute("map",map);
        return "/tenant/productList";
    }

}
