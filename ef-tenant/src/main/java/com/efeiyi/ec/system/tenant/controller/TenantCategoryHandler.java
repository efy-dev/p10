package com.efeiyi.ec.system.tenant.controller;

import com.efeiyi.ec.system.organization.util.AuthorizationUtil;
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
public class TenantCategoryHandler implements DoHandler {

    private BaseManager baseManager = (BaseManager) ApplicationContextUtil.getApplicationContext().getBean("baseManagerImpl");
    @Override
    public ModelMap handle(ModelMap modelMap, HttpServletRequest request) throws Exception {
        modelMap.put("tenantId",AuthorizationUtil.getMyUser().getBigTenant().getId());
        return modelMap;
    }
}
