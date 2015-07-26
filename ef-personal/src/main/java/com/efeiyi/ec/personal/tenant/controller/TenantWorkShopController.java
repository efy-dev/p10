package com.efeiyi.ec.personal.tenant.controller;

import com.efeiyi.ec.tenant.model.Tenant;
import com.efeiyi.ec.tenant.model.TenantWorkShop;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.LinkedHashMap;
import java.util.List;

/**
 * Created by AC丶man on 2015/7/17.
 */

@Controller
@RequestMapping("/workShop")
public class TenantWorkShopController extends BaseTenantController {

    @Autowired
    private BaseManager baseManager;


    /**
     * 获取传承人工作坊
     * @param model
     * @return
     */
    @RequestMapping("/work")
    public ModelAndView getTenantWorkShop(HttpServletRequest request, Model model) throws Exception {
        Tenant tenant = super.getTenantfromDomain(request);
        XQuery xQuery = new XQuery("listTenantWorkShop_default",request);
        xQuery.put("tenant_id", tenant.getId());
        List list = baseManager.listObject(xQuery);
        if (list != null && list.size() > 0){
            TenantWorkShop workShop = (TenantWorkShop) list.get(0);
            model.addAttribute("workShop",workShop);
       }
        model.addAttribute("tenant", tenant);
        return new ModelAndView("/tenantWorkShop/tenantWorkShopView");
    }


}
