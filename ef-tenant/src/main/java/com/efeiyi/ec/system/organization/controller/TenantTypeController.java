package com.efeiyi.ec.system.organization.controller;

import com.efeiyi.ec.organization.model.BigUser;
import com.efeiyi.ec.organization.model.MyUser;
import com.efeiyi.ec.system.organization.util.AuthorizationUtil;
import com.efeiyi.ec.tenant.model.BigTenant;
import com.efeiyi.ec.tenant.model.EnterpriseTenant;
import com.efeiyi.ec.tenant.model.PersonalTenant;
import com.efeiyi.ec.tenant.model.PrivateTenant;
import com.ming800.core.base.service.BaseManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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
	public String sendTenantTypePage(Model model){
		String id = AuthorizationUtil.getMyUser().getBigTenant().getId();
		BigTenant big = (BigTenant) baseManager.getObject(BigTenant.class.getName(),id);
		if("11".equals(big.getTenantType())){
			EnterpriseTenant tenant = (EnterpriseTenant)baseManager.getObject(EnterpriseTenant.class.getName(),id);
			model.addAttribute("object",tenant);
			return "/tenantType/enterpriseTenant";
		}else if("12".equals(big.getTenantType())){
			PrivateTenant tenant = (PrivateTenant)baseManager.getObject(PrivateTenant.class.getName(),id);
			model.addAttribute("object",tenant);
			return "/tenantType/privateTenant";
		}else{
			PersonalTenant tenant = (PersonalTenant)baseManager.getObject(PersonalTenant.class.getName(),id);
			model.addAttribute("object",tenant);
			return "/tenantType/personalTenant";
		}
	}

    @RequestMapping("/sendTenantTypePage1.do")
    public String sendTenantTypePage1(Model model){
        String id = AuthorizationUtil.getMyUser().getBigTenant().getId();
        BigTenant big = (BigTenant) baseManager.getObject(BigTenant.class.getName(),id);
        if("11".equals(big.getTenantType())){
            EnterpriseTenant tenant = (EnterpriseTenant)baseManager.getObject(EnterpriseTenant.class.getName(),id);
            model.addAttribute("object",tenant);
            return "/tenantType1/enterpriseTenant";
        }else if("12".equals(big.getTenantType())){
            PrivateTenant tenant = (PrivateTenant)baseManager.getObject(PrivateTenant.class.getName(),id);
            model.addAttribute("object",tenant);
            return "/tenantType1/privateTenant";
        }else{
            PersonalTenant tenant = (PersonalTenant)baseManager.getObject(PersonalTenant.class.getName(),id);
            model.addAttribute("object",tenant);
            return "/tenantType1/personalTenant";
        }
    }
}
