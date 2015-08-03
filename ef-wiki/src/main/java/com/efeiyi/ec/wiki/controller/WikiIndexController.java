package com.efeiyi.ec.wiki.controller;

import com.ming800.core.base.controller.BaseController;
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
public class WikiIndexController extends BaseController {
    private static Logger logger = Logger.getLogger(WikiIndexController.class);
    @Autowired
    BaseManager baseManager;

    /**
     * feiyi indexShow
     * @param
     *
     * @return
     */
    @RequestMapping("/home.do")
    public ModelAndView getTenant( HttpServletRequest request  , Model model)throws Exception{
        logger.info("weiki  for efeiyi index begin...");
        model.addAttribute("bannerList",getWikiBannerList(request));
       // model.addAttribute("projectList",getFeiyiProjectList(request));
        logger.info("weiki for efeiyi index end...");
        return new ModelAndView("/wiki/showIndex");

    }

    /**
     * getWikiBannerList
     * @param request
     * @return
     * @throws Exception
     */
    public List getWikiBannerList(HttpServletRequest request)throws Exception{
        XQuery xQuery = new XQuery("listWikiBanner_default",request);
        List bannerList = baseManager.listObject(xQuery);
        return bannerList;
    }

    public List getFeiyiProjectList(HttpServletRequest request)throws Exception{
        XQuery xQuery = new XQuery("listWikiProject_default",request);
        List projectList = baseManager.listObject(xQuery);
        return  projectList;
    }

}
