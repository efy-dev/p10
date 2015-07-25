package com.efeiyi.ec.personal.tenant.controller;

import com.efeiyi.ec.tenant.model.Tenant;
import com.ming800.core.base.controller.BaseController;
import com.ming800.core.base.service.BaseManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import java.util.LinkedHashMap;


/**
 * Created by kayson on 2015/7/25.
 *
 */
public class BaseTenantController extends BaseController {
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
        String subDommainName = (String)request.getAttribute("domainName");
        if(!"master".equalsIgnoreCase(subDommainName)){
            LinkedHashMap<String,Object> map = new LinkedHashMap<>();
            String queryHql ="from Tenant t where t.name=:name";
            map.put("name",subDommainName);
            tenant =(Tenant) baseManager.getUniqueObjectByConditions(queryHql,map);
        }
      return tenant;
    }
}
