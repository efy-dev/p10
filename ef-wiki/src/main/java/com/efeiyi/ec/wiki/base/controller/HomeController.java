package com.efeiyi.ec.wiki.base.controller;

import com.efeiyi.ec.project.model.Project;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import com.ming800.core.p.service.BannerManager;
import com.ming800.core.p.service.ObjectRecommendedManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * Created by Administrator on 2016/4/13.
 */
@Controller
public class HomeController {
    @Autowired
    BaseManager baseManager;
    @Autowired
    BannerManager bannerManager;
    @Autowired
    ObjectRecommendedManager objectRecommendedManager;

    /**
     * PC和移动首页；推荐技艺列表；轮播图；
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping({"/home.do"})
    public String home(HttpServletRequest request,Model model) throws Exception {
        XQuery query = new XQuery("plistProjectRecommended_default", request);
        List<Object> projectRecommendedList = baseManager.listObject(query);
        query.put("project_type","1");
        List<Object> artList = baseManager.listObject(query);
        query.put("project_type","2");
        List<Object> craftList = baseManager.listObject(query);
        model.addAttribute("projectRecommendedList",projectRecommendedList);
        model.addAttribute("artList",artList);
        model.addAttribute("craftList",craftList);
        //@TODO PC轮播图groupname待定
        List<Object> pcBannerList = bannerManager.getBannerList("wiki.pc.dynamic");
        //@TODO wap轮播图groupname待定
        List<Object> wapBannerList = bannerManager.getBannerList("wiki.wap.dynamic");
        model.addAttribute("pcBannerList",pcBannerList);
        model.addAttribute("wapBannerList",wapBannerList);
        return "/home";
    }
}
