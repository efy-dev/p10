package com.efeiyi.ec.system.organization.controller;

import com.efeiyi.ec.master.model.Master;
import com.efeiyi.ec.organization.model.Permission;
import com.efeiyi.ec.organization.model.Role;
import com.efeiyi.ec.system.organization.service.TenantManager;
import com.efeiyi.ec.system.organization.util.AuthorizationUtil;
import com.efeiyi.ec.tenant.model.BigTenant;
import com.efeiyi.ec.tenant.model.Tenant;
import com.efeiyi.ec.tenant.model.TenantMaster;
import com.ming800.core.base.controller.BaseController;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.Module;
import com.ming800.core.does.service.ModuleManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.HashMap;
import java.util.Map;

/**
 * Created by IntelliJ IDEA.
 * User: ming
 * Date: 12-10-15
 * Time: 下午4:56
 * To change this template use File | Settings | File Templates.
 */

@Controller
@RequestMapping("/tenant")
public class TenantController extends BaseController {

    @Autowired
    private TenantManager tenantManager;

    @RequestMapping("/viewTenant.do")
    public String viewTenant(Model model){
        BigTenant tenant = (BigTenant) AuthorizationUtil.getMyUser().getBigTenant();

        return "redirect:/basic/xm.do?qm=viewTenant&id="+tenant.getId();
    }

    @RequestMapping("/linkMaster.do")
    @ResponseBody
    public String linkMaster(String tenantId,String masterId,String tenantMasterId,String status){
        String id = "";
        try {

            id = tenantManager.linkMaster(tenantId,masterId,tenantMasterId,status);
        }catch (Exception e){

        }
        return  id;
    }

    @RequestMapping("/linkProject.do")
    @ResponseBody
    public String linkProject(String tenantId,String projectId,String tenantProjectId,String status){
        String id = "";
        try {

            id =  tenantManager.linkProject(tenantId,projectId,tenantProjectId,status);
        }catch (Exception e){
            e.printStackTrace();
        }
        return  id;
    }


    @RequestMapping("/linkProduct.do")
    @ResponseBody
    public String linkProduct(String tenantCategoryId,String productId,String tenantProductId,String status){
        String id = "";
        try {

            id =  tenantManager.linkProduct(tenantCategoryId,productId,tenantProductId,status);
        }catch (Exception e){
            e.printStackTrace();
        }
        return  id;
    }

}
