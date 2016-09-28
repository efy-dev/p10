package com.efeiyi.ec.website.tenant.controller;

import com.efeiyi.ec.master.model.Master;
import com.efeiyi.ec.organization.model.Image;
import com.efeiyi.ec.organization.model.Panel;
import com.efeiyi.ec.organization.model.User;
import com.efeiyi.ec.product.model.ProductModel;
import com.efeiyi.ec.product.model.ProductModelColumn;
import com.efeiyi.ec.tenant.model.*;
import com.efeiyi.ec.wiki.model.Artistry;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.PageInfo;
import com.ming800.core.does.model.XQuery;
import com.ming800.core.taglib.PageEntity;
import net.sf.json.JSONObject;
import org.hibernate.context.TenantIdentifierMismatchException;
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

    @RequestMapping({"/tenant/getTenantById"})
    @ResponseBody
    public Object getTenantById(HttpServletRequest request) {
        try {
            String id = request.getParameter("id");
            LinkedHashMap<String, Object> param = new LinkedHashMap<>();
            param.put("tenantId", id);
            String imageHql = "select obj from Image obj where obj.owner=:tenantId and obj.type='2'";
            Image image = (Image) baseManager.getUniqueObjectByConditions(imageHql, param);
            BigTenant tenant = (BigTenant) baseManager.getObject(BigTenant.class.getName(), id);
            if (image != null) {
                tenant.setAudio(image.getSrc());
            }
            return tenant;
        } catch (Exception e) {
            e.printStackTrace();
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("code", "1");
            return jsonObject;
        }
    }

    @RequestMapping({"/tenant/getColumnListByTenant"})
    @ResponseBody
    public Object getColumnListByTenant(HttpServletRequest request) {
        try {
            String id = request.getParameter("id");
            String hql = "select obj from " + TenantColumn.class.getName() + " obj where obj.bigTenant.id=:id";
            LinkedHashMap<String, Object> param = new LinkedHashMap<>();
            param.put("id", id);
            return baseManager.listObject(hql, param);
        } catch (Exception e) {
            e.printStackTrace();
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("code", "1");
            return jsonObject;
        }
    }

    @RequestMapping({"/tenant/getTenantPraiseListByTenant"})
    @ResponseBody
    public Object getTenantPraiseListByTenant(HttpServletRequest request) {
        try {
            String id = request.getParameter("id");
            String hql = "select obj from " + TenantPraise.class.getName() + " obj where obj.tenant.id=:id";
            LinkedHashMap<String, Object> param = new LinkedHashMap<>();
            param.put("id", id);
            return baseManager.listObject(hql, param);
        } catch (Exception e) {
            e.printStackTrace();
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("code", "1");
            return jsonObject;
        }
    }

    @RequestMapping({"/tenant/saveOrCanelTenantPraise"})
    @ResponseBody
    public Object saveOrCanelTenantPraise(HttpServletRequest request) {
        JSONObject jsonObject = new JSONObject();
        try {
            String userId = request.getParameter("userId");
            String tenantId = request.getParameter("tenantId");
            String delFlag = request.getParameter("delFlag");
            String hql = "select obj  FROM "+TenantPraise.class.getName()+" obj WHERE obj.tenant.id=:tenant_id AND obj.user.id=:user_id";
            if ("0".equals(delFlag)) {
                User user = (User) baseManager.getObject(User.class.getName(), userId);
                Tenant tenant = (Tenant) baseManager.getObject(Tenant.class.getName(), tenantId);
                TenantPraise tenantPraise = new TenantPraise();
                tenantPraise.setTenant(tenant);
                tenantPraise.setUser(user);
                baseManager.saveOrUpdate(TenantPraise.class.getName(), tenantPraise);
                jsonObject.put("code", "2");
            } else if ("1".equals(delFlag)) {
                LinkedHashMap<String, Object> param = new LinkedHashMap<>();
                param.put("tenant_id", tenantId);
                param.put("user_id", userId);
                TenantPraise tenantPraise = (TenantPraise) baseManager.getUniqueObjectByConditions(hql, param);
                String tenantPraiseId = tenantPraise == null ? "" : tenantPraise.getId();
                baseManager.delete(TenantPraise.class.getName(), tenantPraiseId);
                jsonObject.put("code", "3");
            }else{
                jsonObject.put("code", "4");
            }
            return jsonObject;
        } catch (Exception e) {
            e.printStackTrace();
            jsonObject.put("code", "1");
            return jsonObject;
        }
    }

    @RequestMapping({"/tenant/getTenantList"})
    @ResponseBody
    public Object getTenantList(HttpServletRequest request) {
        try {
            JSONObject jsonObject = JSONObject.fromObject(request.getParameter("param"));
            int limit = Integer.parseInt(request.getParameter("limit"));
            int offset = Integer.parseInt(request.getParameter("offset"));
            LinkedHashMap<String, Object> param = new LinkedHashMap<>();
            LinkedHashMap<String, Object> param_img = new LinkedHashMap<>();
            StringBuilder hql = new StringBuilder("select obj from BigTenant obj where obj.tenantType='111' and obj.status!='0' ");
            StringBuilder hql_img = new StringBuilder("select o from Image o where o.owner=:owner and o.status!='0' and o.type='2' and o.name='audio' ");
            for (Object key : jsonObject.keySet()) {
                hql.append("and ");
                hql.append("obj.");
                hql.append(key.toString());
                hql.append("=:");
                hql.append(key.toString());
                hql.append(" ");
                param.put(key.toString(), jsonObject.get(key));
            }
            PageEntity pageEntity = new PageEntity();
            pageEntity.setSize(limit);
            pageEntity.setrIndex(offset);
            PageInfo pageInfo = baseManager.listPageInfo(hql.toString(), pageEntity, param);
            List<BigTenant> bigTenants = pageInfo.getList();
            if (null != bigTenants && bigTenants.size() > 0) {
                for (BigTenant bigTenant : bigTenants) {
                    String id = bigTenant.getId();
                    param_img.put("owner", id);
                    Image image = (Image) baseManager.getUniqueObjectByConditions(hql_img.toString(), param_img);
                    String src = image == null ? "" : image.getSrc();
                    bigTenant.setAudio(src);
                }
            }
            return bigTenants;
        } catch (Exception e) {
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("code", "1");
            return jsonObject;
        }
    }

    @RequestMapping({"/tenant/getImageTextListByTenant"})
    @ResponseBody
    public Object getImageTextListByTenant(HttpServletRequest request) {
        try {
            String id = request.getParameter("id");
            String hql = "select obj from " + Panel.class.getName() + " obj where obj.owner=:id";
            LinkedHashMap<String, Object> param = new LinkedHashMap<>();
            param.put("id", id);
            return baseManager.listObject(hql, param);
        } catch (Exception e) {
            e.printStackTrace();
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("code", "1");
            return jsonObject;
        }
    }

    @RequestMapping({"/tenant/getImageTextById"})
    @ResponseBody
    public Object getImageTextById(HttpServletRequest request) {
        try {
            String id = request.getParameter("id");
            return baseManager.getObject(Panel.class.getName(), id);
        } catch (Exception e) {
            e.printStackTrace();
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("code", "1");
            return jsonObject;
        }
    }


    @RequestMapping({"/tenant/getRecommendList"})
    @ResponseBody
    public Object getRecommendList(HttpServletRequest request) {
//        try {
        JSONObject jsonObject = JSONObject.fromObject(request.getParameter("param"));
        int limit = Integer.parseInt(request.getParameter("limit"));
        int offset = Integer.parseInt(request.getParameter("offset"));
        LinkedHashMap<String, Object> param = new LinkedHashMap<>();
        StringBuilder hql = new StringBuilder("select recommend from Recommend recommend where recommend.status!=0 ");
        for (Object key : jsonObject.keySet()) {
            hql.append("and ");
            hql.append("recommend.");
            hql.append(key.toString());
            hql.append("=:");
            hql.append(key.toString());
            hql.append(" ");
            param.put(key.toString(), jsonObject.get(key));
        }
        PageEntity pageEntity = new PageEntity();
        pageEntity.setSize(limit);
        pageEntity.setrIndex(offset);
        if (limit == -1) {
            return baseManager.listObject(hql.toString(), param);
        }
        PageInfo pageInfo = baseManager.listPageInfo(hql.toString(), pageEntity, param);
        return pageInfo.getList();
//        }
//        } catch (Exception e) {
//            JSONObject jsonObject = new JSONObject();
//            jsonObject.put("code", "1");
//            return jsonObject;
//        }
    }


}
