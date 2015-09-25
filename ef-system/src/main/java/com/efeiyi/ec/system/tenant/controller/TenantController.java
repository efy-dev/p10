package com.efeiyi.ec.system.tenant.controller;

import com.efeiyi.ec.system.tenant.service.TenantManager;
import com.ming800.core.base.controller.BaseController;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

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


    @RequestMapping("/linkProduct.do")
    @ResponseBody
    public String linkProduct(String tenantCategoryId,String productId,String tenantProductId,String status){
        String id = "";
        try {

            id =  tenantManager.linkProduct(tenantCategoryId, productId, tenantProductId, status);
        }catch (Exception e){
            e.printStackTrace();
        }
        return  id;
    }

}
