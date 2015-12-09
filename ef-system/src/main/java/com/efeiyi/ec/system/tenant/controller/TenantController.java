package com.efeiyi.ec.system.tenant.controller;

import com.efeiyi.ec.system.tenant.service.TenantManager;
import com.efeiyi.ec.tenant.model.BigTenant;
import com.efeiyi.ec.tenant.model.TenantReview;
import com.ming800.core.base.controller.BaseController;
import com.ming800.core.base.service.BaseManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.text.SimpleDateFormat;
import java.util.Date;

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

    @Autowired
    private BaseManager baseManager;

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
    @RequestMapping("/toSubmitReview.do")
    @ResponseBody
    public String toSubmitReview(TenantReview tenantReview,String tenantId){
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");

        try {
            BigTenant bigTenant = (BigTenant)baseManager.getObject(BigTenant.class.getName(),tenantId);
            String  date = sdf.format(new Date());
           tenantReview.setCreateDateTime(sdf.parse(date));
            tenantReview.setTenant(bigTenant);
            baseManager.saveOrUpdate(TenantReview.class.getName(),tenantReview);
            bigTenant.setReview(tenantReview.getReview());
            baseManager.saveOrUpdate(BigTenant.class.getName(),bigTenant);

        }catch (Exception e){
            e.printStackTrace();
        }
        return  tenantReview.getReview();
    }

}
