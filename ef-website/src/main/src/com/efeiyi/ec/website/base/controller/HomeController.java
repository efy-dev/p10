package com.efeiyi.ec.website.base.controller;

import com.efeiyi.ec.project.model.Project;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import com.ming800.core.p.model.Banner;
import com.ming800.core.p.service.BannerManager;
import com.ming800.core.p.service.ObjectRecommendedManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;

/**
 * Created by Administrator on 2015/8/17.
 */
@Controller
public class HomeController {

    @Autowired
    private ObjectRecommendedManager objectRecommendedManager;

    @Autowired
    private BannerManager bannerManager;

    @Autowired
    private BaseManager baseManager;

    @RequestMapping
    public String home(HttpServletRequest request,Model model) throws Exception{
        List<Object> projectList =  objectRecommendedManager.getRecommendedList("projectRecommended");
        HashMap<String,List> map = new HashMap<>();
        for (Object object : projectList){
            XQuery xQuery = new XQuery("listProduct_recommend",request);
            xQuery.put("project_id",((Project)object).getId());
            map.put(((Project) object).getId(), baseManager.listObject(xQuery));
        }
        model.addAttribute("recommendMap",map);
        model.addAttribute("projectList",projectList);

        //首页轮播图
        List<Object> bannerList = bannerManager.getBannerList("ec.home.banner");
        model.addAttribute("bannerList",bannerList);

        //传承人
        List<Object> masterList =  objectRecommendedManager.getRecommendedList("masterRecommended");
        model.addAttribute("masterList",masterList);
        return "/home";

    }

}
