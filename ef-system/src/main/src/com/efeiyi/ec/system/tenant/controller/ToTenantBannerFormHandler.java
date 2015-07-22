package com.efeiyi.ec.system.tenant.controller;

import com.ming800.core.does.service.DoHandler;
import org.springframework.ui.ModelMap;

import javax.servlet.http.HttpServletRequest;

/**
 * Created by Administrator on 2015/7/20.
 */
public class ToTenantBannerFormHandler implements DoHandler {
    @Override
    public ModelMap handle(ModelMap modelMap, HttpServletRequest request) throws Exception {
        if (request.getParameter("tenantId") != null) {
            modelMap.put("tenant_id", request.getParameter("tenantId"));
        }
        return modelMap;
    }
}
