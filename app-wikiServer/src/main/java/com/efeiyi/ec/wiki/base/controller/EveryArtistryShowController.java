package com.efeiyi.ec.wiki.base.controller;

import com.ming800.core.base.service.BaseManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;

/**
 * Created by Administrator on 2015/8/4.
 *
 */
@Controller
public class EveryArtistryShowController extends WikibaseController {
    private static Logger logger = Logger.getLogger(EveryArtistryShowController.class);
    @Autowired
    BaseManager baseManager;



    /**
     * 各非遗技艺列表页
     * @param request is HttpServletRequest,model
     * @return "/wiki/everyArt"
     */
    @RequestMapping("/getArt.do")
    public ModelAndView getTenant( HttpServletRequest request  , Model model)throws Exception{
        logger.info("everyArt show ...");
        model.addAttribute("projectList",getFeiyiProjectList(request));
        model.addAttribute("recommendTenantList",getRecommendTenantList());
        return new ModelAndView("/com/efeiyi/ec/wiki/everyArt");
    }

}
