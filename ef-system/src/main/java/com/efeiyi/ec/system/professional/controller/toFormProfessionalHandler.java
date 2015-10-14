package com.efeiyi.ec.system.professional.controller;

import com.efeiyi.ec.master.model.MasterProject;
import com.efeiyi.ec.product.model.Product;
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
public class toFormProfessionalHandler implements DoHandler {

    private BaseManager baseManager = (BaseManager) ApplicationContextUtil.getApplicationContext().getBean("baseManagerImpl");

    @Override
    public ModelMap handle(ModelMap modelMap, HttpServletRequest request) throws Exception {

        XQuery xQuery = new XQuery("listTenant_product",request);//商家
        List<Tenant> tenantList = baseManager.listObject(xQuery);
        modelMap.put("tenantList",tenantList);
        return modelMap;
    }
}
