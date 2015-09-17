package com.efeiyi.ec.system.project.controller;

import com.efeiyi.ec.tenant.model.TenantProject;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import com.ming800.core.does.service.DoHandler;
import com.ming800.core.util.ApplicationContextUtil;
import org.springframework.ui.ModelMap;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * Created by Administrator on 2015/7/23.
 */
public class TenantProjectListHandler implements DoHandler {

    private BaseManager baseManager = (BaseManager) ApplicationContextUtil.getApplicationContext().getBean("baseManagerImpl");
    @Override
    public ModelMap handle(ModelMap modelMap, HttpServletRequest request) throws Exception {

        System.out.print(request.getParameter("tenantId"));
        if(request.getParameter("tenantId")!=null&&request.getParameter("tenantId")!=""){
            XQuery xQuery = new XQuery("listTenantProject_default1",request);
            xQuery.put("tenant_id",request.getParameter("tenantId"));
            List<TenantProject> tenantProjectList = baseManager.listObject(xQuery);
            modelMap.put("tenantProjectList",tenantProjectList);
        }
        modelMap.put("tenantId",request.getParameter("tenantId"));
        return modelMap;
    }
}
