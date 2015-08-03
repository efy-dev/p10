package com.efeiyi.ec.wiki.controller;

import com.ming800.core.base.controller.BaseController;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import com.ming800.core.p.service.ObjectRecommendedManager;
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
    @Autowired
    ObjectRecommendedManager objectRecommendedManager;
    /**
     * 非遗百科首页展示
     * @param request is HttpServletRequest,model
     * @return "/wiki/showIndex"
     */
    @RequestMapping("/home.do")
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
     * 非遗项目
     * @param  request is HttpServletRequest
     * @return projectList
     * @throws Exception
     */
    public List getFeiyiProjectList(HttpServletRequest request)throws Exception{
        XQuery xQuery = new XQuery("listWikiProject_default",request);
        return  baseManager.listObject(xQuery);
    }

    /**
     * 精彩非遗项目
     * @return wondenfulProjectList
     * @throws Exception
     */
    public  List getWondenfulProjectList()throws Exception{
        return objectRecommendedManager.getRecommendedList("WondenfulProject");
    }

    /**
     * 推荐项目
     * @return recommendProjectList
     * @throws Exception
     */
    public  List getRecommendProjectList()throws Exception{
        return objectRecommendedManager.getRecommendedList("ProjectRecommended");
    }

    /**
     * 传承人推荐
     * @return recommendTenantList
     * @throws Exception
     */
    public  List getRecommendTenantList()throws Exception{
        return objectRecommendedManager.getRecommendedList("masterRecommended");
    }

    /**
     * 精彩视频
     * @return wondenfulVideosList
     * @throws Exception
     */
    public  List getWondenfulVideosList()throws Exception{
        return objectRecommendedManager.getRecommendedList("WondenfulVideo");
    }

}
