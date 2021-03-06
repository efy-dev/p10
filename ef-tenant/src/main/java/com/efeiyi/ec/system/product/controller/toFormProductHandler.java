package com.efeiyi.ec.system.product.controller;

import com.efeiyi.ec.master.model.MasterProject;
import com.efeiyi.ec.system.organization.util.AuthorizationUtil;
import com.efeiyi.ec.tenant.model.Tenant;
import com.efeiyi.ec.tenant.model.TenantMaster;
import com.efeiyi.ec.tenant.model.TenantProject;
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
public class toFormProductHandler implements DoHandler {

    private BaseManager baseManager = (BaseManager) ApplicationContextUtil.getApplicationContext().getBean("baseManagerImpl");


    private AutoSerialManager autoSerialManager = (AutoSerialManager) ApplicationContextUtil.getApplicationContext().getBean("autoSerialManagerImpl");

    @Override
    public ModelMap handle(ModelMap modelMap, HttpServletRequest request) throws Exception {
        modelMap.put("view",request.getParameter("view"));
        modelMap.put("serial" ,autoSerialManager.nextSerial("product"));
        modelMap.put("tenantId",request.getParameter("tenantId"));
        XQuery xQuery = new XQuery("listTenantMaster_default",request);//
        xQuery.put("tenant_id",request.getParameter("tenantId"));
        List<TenantMaster> masterList = baseManager.listObject(xQuery);//大师
        modelMap.put("masterList",masterList);
        xQuery = new XQuery("listMasterProject_default",request);
        xQuery.put("master_id",request.getParameter("masterId"));
        List<MasterProject> projectList = baseManager.listObject(xQuery);//项目
        modelMap.put("projectList",projectList);
        xQuery = new XQuery("listTenant_product",request);//商家
        List<Tenant> tenantList = baseManager.listObject(xQuery);
        modelMap.put("tenantList",tenantList);
        xQuery = new XQuery("listTenantProject_default",request);//商家项目
        xQuery.put("tenant_id",request.getParameter("tenantId"));
        List<TenantProject> tenantProjectList = baseManager.listObject(xQuery);
        modelMap.put("tenantProjectList",tenantProjectList);


        return modelMap;
    }
}
