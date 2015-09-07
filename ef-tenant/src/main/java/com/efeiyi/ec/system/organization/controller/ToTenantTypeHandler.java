package com.efeiyi.ec.system.organization.controller;

import com.ming800.core.does.service.DoHandler;
import org.springframework.ui.ModelMap;

import javax.servlet.http.HttpServletRequest;

/**
 * Created by AC丶man on 2015/8/29.
 */
public class ToTenantTypeHandler implements DoHandler {
	@Override
	public ModelMap handle(ModelMap modelMap, HttpServletRequest request) throws Exception {
		if (request.getParameter("tenantId") != null) {
			modelMap.put("tenant_id", request.getParameter("tenantId"));
		}
		return modelMap;
	}
}
