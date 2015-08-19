package com.efeiyi.ec.personal.master.controller;

import com.efeiyi.ec.tenant.model.Tenant;
import com.efeiyi.ec.tenant.model.TenantProject;
import com.ming800.core.base.controller.BaseController;
import com.ming800.core.base.service.BaseManager;
import org.springframework.beans.factory.annotation.Autowired;

import javax.servlet.http.HttpServletRequest;
import java.util.LinkedHashMap;
import java.util.List;


/**
 * Created by kayson on 2015/7/25.
 *
 */
public class BaseMasterController extends BaseController {
    @Autowired
    BaseManager baseManager;
    protected Tenant tenant;

    public Tenant getTenant() {
        return tenant;
    }

    public void setTenant(Tenant tenant) {
        this.tenant = tenant;
    }


    public Tenant getTenantfromDomain(HttpServletRequest request)throws Exception{
        Tenant tenantTemp = null;
        String subDommainName = (String)request.getAttribute("domainName");
        if(!"master".equalsIgnoreCase(subDommainName)){
            LinkedHashMap<String,Object> map = new LinkedHashMap<>();
            String queryHql ="from Tenant t where t.name=:name and t.status=:status";
            map.put("name",subDommainName);
            map.put("status","1");
            tenantTemp =(Tenant) baseManager.getUniqueObjectByConditions(queryHql,map);
            List<TenantProject> projects = tenantTemp.getTenantProjectList();
            //tenantTemp.setProjectName(mainTenantProject(projects));
        }
      return tenantTemp;
    }


    public String mainTenantProject(List<TenantProject> tenantProjects) {

        TenantProject tenantProject = null;

        if (tenantProjects != null && tenantProjects.size() > 0) {

            for (TenantProject tenantProjectTemp : tenantProjects) {
                if (tenantProjectTemp.getStatus().equals("1")) {
                    tenantProject = tenantProjectTemp;
                }
            }
            if (tenantProject == null) {
                tenantProject = tenantProjects.get(0);
            }

            return tenantProject.getProject().getName();
        } else {

            return "";
        }
    }
}
