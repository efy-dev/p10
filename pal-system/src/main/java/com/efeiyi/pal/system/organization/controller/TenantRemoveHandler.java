package com.efeiyi.pal.system.organization.controller;

import com.efeiyi.pal.organization.model.Tenant;
import com.efeiyi.pal.system.product.service.ProductSeriesServiceManager;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.service.DoHandler;
import com.ming800.core.util.ApplicationContextUtil;
import org.springframework.ui.ModelMap;

import javax.servlet.http.HttpServletRequest;

/**
 * Created by Administrator on 2015/8/29.
 *
 */

public class TenantRemoveHandler implements DoHandler {

    private BaseManager baseManager = (BaseManager) ApplicationContextUtil.getApplicationContext().getBean("baseManagerImpl");
    private ProductSeriesServiceManager productSeriesServiceManager = (ProductSeriesServiceManager) ApplicationContextUtil.getApplicationContext().getBean("productSeriesServiceManagerImpl");

    @Override
    public ModelMap handle(ModelMap modelMap, HttpServletRequest request) throws Exception {
        String tenantId = request.getParameter("id");
        if (tenantId == null || "".equals(tenantId)) {
            throw new Exception("非遗项目Id不能为空");
        }
        Tenant tenant = (Tenant) baseManager.getObject(Tenant.class.getName(), tenantId);
        productSeriesServiceManager.removeTenantProductSeriesByTenant(tenant);

        modelMap.put("object", tenant);
        return modelMap;
    }

}
