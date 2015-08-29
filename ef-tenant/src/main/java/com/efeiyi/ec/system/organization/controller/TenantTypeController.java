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
		String id = AuthorizationUtil.getMyUser().getBigTenant().getId();
		BigTenant big = (BigTenant) baseManager.getObject(BigTenant.class.getName(),id);
		if("11".equals(big.getTenantType())){
			return "/tenantType/enterpriseTenant";
		}else if("12".equals(big.getTenantType())){
			return "/tenantType/privateTenant";
		}else{
			return "/tenantType/personalTenant";
		}
	}
}
