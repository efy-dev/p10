package com.efeiyi.ec.system.product.controller;

import com.efeiyi.ec.tenant.model.TenantProductTag;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import com.ming800.core.does.service.DoHandler;
import com.ming800.core.p.service.AutoSerialManager;
import com.ming800.core.util.ApplicationContextUtil;
import org.springframework.ui.ModelMap;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * Created by Administrator on 2015/7/20.
 */
public class plistTenantProductHandler implements DoHandler {

    private BaseManager baseManager = (BaseManager) ApplicationContextUtil.getApplicationContext().getBean("baseManagerImpl");


    private AutoSerialManager autoSerialManager = (AutoSerialManager) ApplicationContextUtil.getApplicationContext().getBean("autoSerialManagerImpl");

    @Override
    public ModelMap handle(ModelMap modelMap, HttpServletRequest request) throws Exception {
        modelMap.put("tenantCategoryId", request.getParameter("tenantCategoryId"));
        modelMap.put("tenantId", request.getParameter("tenantId"));
        XQuery xQuery = new XQuery("listTenantProductTag_default1",request);
        xQuery.put("tenantCategory_id",request.getParameter("tenantCategoryId"));
        List<TenantProductTag> tenantProductTagList = baseManager.listObject(xQuery);
        modelMap.put("tenantProductTagList",tenantProductTagList);
        return modelMap;
    }
}
