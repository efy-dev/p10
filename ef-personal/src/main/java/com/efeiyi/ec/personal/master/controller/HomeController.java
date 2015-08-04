package com.efeiyi.ec.personal.master.controller;

import com.ming800.core.p.service.ObjectRecommendedManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

/**
 * Created by AC丶man on 2015/7/26.
 */
@Controller
public class HomeController {

    @Autowired
    private ObjectRecommendedManager recommendedManager;

    /**
     * 获取所有传承人
     * @param model
     * @return
     */
    @RequestMapping("/index")
    public String index(Model model)throws Exception{
       /* XQuery xQuery = new XQuery("listTenantProject_default",request);
        List list = baseManager.listObject(xQuery);
        model.addAttribute("list",list);
        model.addAttribute("pageMsg","0");*/
        List skillList = recommendedManager.getRecommendedList("masterSkillRecommended");
        List artList = recommendedManager.getRecommendedList("masterArtRecommended");
        model.addAttribute("skillList",skillList);
        model.addAttribute("artList",artList);
        return "/tenant/tenantList";
    }
}
