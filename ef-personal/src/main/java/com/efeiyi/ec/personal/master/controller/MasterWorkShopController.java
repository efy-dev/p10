package com.efeiyi.ec.personal.master.controller;

import com.efeiyi.ec.master.model.Master;
import com.efeiyi.ec.master.model.MasterWorkShop;
import com.efeiyi.ec.tenant.model.Tenant;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * Created by AC丶man on 2015/7/17.
 */

@Controller
@RequestMapping("/workShop")
public class MasterWorkShopController extends BaseMasterController {

    @Autowired
    private BaseManager baseManager;


    /**
     * 获取传承人工作坊
     * @param model
     * @return
     */
    @RequestMapping("/work")
    public ModelAndView getTenantWorkShop(HttpServletRequest request, Model model) throws Exception {
        Master tenant = super.getMasterfromDomain(request);
        XQuery xQuery = new XQuery("listMasterWorkShop_default",request);
        xQuery.put("master_id", tenant.getId());
        List list = baseManager.listObject(xQuery);
        if (list != null && list.size() > 0){
            MasterWorkShop workShop = (MasterWorkShop) list.get(0);
            model.addAttribute("workShop",workShop);
       }
        model.addAttribute("tenant", tenant);
        model.addAttribute("pageMsg","5");
        return new ModelAndView("/tenantWorkShop/tenantWorkShopView");
    }


}
