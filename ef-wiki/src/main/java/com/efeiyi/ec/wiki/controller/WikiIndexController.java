package com.efeiyi.ec.wiki.controller;

import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * Created by Administrator on 2015/7/31.
 *
 */
@Controller
public class WikiIndexController extends WikibaseController {
    private static Logger logger = Logger.getLogger(WikiIndexController.class);
    @Autowired
    BaseManager baseManager;

    /**
     * 非遗百科首页展示
     * @param request is HttpServletRequest,model
     * @return "/wiki/showIndex"
     */
    @RequestMapping("/getTenant.do")
    public ModelAndView getTenant( HttpServletRequest request  , Model model)throws Exception{
        logger.info("weiki  for efeiyi index begin...");

        model.addAttribute("bannerList",getWikiBannerList(request));
        model.addAttribute("projectList",getFeiyiProjectList(request));
        model.addAttribute("recommendProjectList",getRecommendProjectList());
        model.addAttribute("recommendTenantList",getRecommendTenantList());
        model.addAttribute("wondenfulProjectList",getWondenfulProjectList());
        model.addAttribute("wondenfulVideosList",getWondenfulVideosList());

        logger.info("weiki for efeiyi index end...");
        return new ModelAndView("/wiki/showIndex");

    }

    /**
     * 首页轮播图
     * @param request is HttpServletRequest
     * @return bannerList
     * @throws Exception
     */
    public List getWikiBannerList(HttpServletRequest request)throws Exception{
        XQuery xQuery = new XQuery("listWikiBanner_default",request);
        return baseManager.listObject(xQuery);
    }

    /**
     * 非遗百科热门展示
     * @param request is HttpServletRequest,model
     * @return "/wiki/showIndex"
     */
    @RequestMapping("/home.do")
    public ModelAndView getHotProjects( HttpServletRequest request  , Model model)throws Exception{
        return new ModelAndView("/hotProjects/hotProjects");
    }
    @RequestMapping("/getHotProjects.do")
    public List getHotProjects( HttpServletRequest request)throws Exception{
        List list = getWondenfulProjectList();
        return list;
    }
}
