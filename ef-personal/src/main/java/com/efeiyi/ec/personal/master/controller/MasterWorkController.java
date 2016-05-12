package com.efeiyi.ec.personal.master.controller;


import com.efeiyi.ec.master.model.Master;
import com.efeiyi.ec.master.model.MasterWork;
import com.efeiyi.ec.personal.master.MasterUtil;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * Created by AC丶man on 2015/7/17.
 */

@Controller
@RequestMapping("/work")
public class MasterWorkController extends BaseMasterController {

    @Autowired
    private BaseManager baseManager;


    /**
     * 获取传承人作品列表
     * @param model
     * @return
     */
    @RequestMapping("/list")
    public String listTenantProduct(HttpServletRequest request ,Model model) throws Exception {
        Master master = getMasterfromDomain(request);
        XQuery xQuery = new XQuery("plistMasterWork_default",master.getId(),request.getParameter("sort"),request);
        xQuery.put("master_id",master.getId());
        xQuery.addRequestParamToModel(model, request);
        List WorkList = baseManager.listPageInfo(xQuery).getList();
        model.addAttribute("tenant", master);
        model.addAttribute("tenantWorkList",WorkList);
        model.addAttribute("pageMsg","3");
        return "/tenantWork/tenantWorkList";

    }
    /**
     * 获取传承人作品详情
     * @param modelMap
     * @return
     */
    @RequestMapping("/{tenantWorkId}")
    public ModelAndView getProduct(HttpServletRequest request,@PathVariable String tenantWorkId,ModelMap modelMap){
        MasterWork product = (MasterWork)baseManager.getObject(MasterWork.class.getName(), tenantWorkId);
        modelMap.addAttribute("product", product);
        modelMap.addAttribute("pageMsg","6");
        return new ModelAndView("/tenantWork/tenantWorkView",modelMap);

    }

}
