package com.efeiyi.ec.system.organization.controller;

import com.efeiyi.ec.organization.model.BigUser;
import com.efeiyi.ec.organization.model.MyUser;
import com.efeiyi.ec.system.organization.util.AuthorizationUtil;
import com.efeiyi.ec.tenant.model.BigTenant;
import com.ming800.core.base.service.BaseManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Created by AC丶man on 2015/8/29.
 */
@Controller
@RequestMapping("/tenantType")
public class TenantTypeController {

	@Autowired
	BaseManager baseManager;

	@RequestMapping("/sendTenantTypePage.do")
	public String sendTenantTypePage(){
		MyUser user = AuthorizationUtil.getMyUser();
		BigUser user1 = user.getBigUser();
		String id = user1.getBigTenant().getId();
		BigTenant bigTenant = (BigTenant) baseManager.getObject(BigTenant.class.getName(),id);
		if("11".equals(bigTenant.getTenantType())){
			return "/tenantType/enterpriseTenant";
		}else if("12".equals(bigTenant.getTenantType())){
			return "/tenantType/privateTenant";
		}else{
			return "/tenantType/personalTenant";
		}
	}
}
