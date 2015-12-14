package com.efeiyi.ec.website.base.controller;

import com.efeiyi.ec.project.model.ProjectCategory;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
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

    @RequestMapping({"/home.do"})
    public String home(HttpServletRequest request, Model model) throws Exception {

        //判断是否有需要重定向的页面
        String redirectUrl = request.getParameter("redirect");
        if (redirectUrl!=null){
            return "redirect:"+redirectUrl;
        }


        List<Object> projectList = objectRecommendedManager.getRecommendedList("categoryRecommended");
        HashMap<String, List> map = new HashMap<>();
        for (Object object : projectList) {
            XQuery xQuery = new XQuery("listProjectCategoryProductModel_default", request);
            xQuery.put("projectCategory_id", ((ProjectCategory) object).getId());
            map.put(((ProjectCategory) object).getId(), baseManager.listObject(xQuery));
        }
        model.addAttribute("recommendMap", map);
        model.addAttribute("projectList", projectList);

        //首页轮播图
        List<Object> bannerList = bannerManager.getBannerList("ec.home.banner");
        model.addAttribute("bannerList", bannerList);

        //传承人
        List<Object> masterList = objectRecommendedManager.getRecommendedList("ec.masterRecommended");
        model.addAttribute("masterList", masterList);
        model.addAttribute("sign", "000");

        //品牌故事
        XQuery subjectQuery = new XQuery("listSubject_default", request);
        List<Object> subjectList = baseManager.listObject(subjectQuery);
        if (subjectList != null && subjectList.size() > 0) {
            model.addAttribute("subject", subjectList.get(0));
        }

        return "/home";
    }

    @RequestMapping({"/productCategory.do"})
    public String listProductCategory(HttpServletRequest request, Model model) throws Exception {
        HashMap<String, List> projectMap = new HashMap<>();
        XQuery xQuery = new XQuery("listProjectCategory_default", request);
        xQuery.setSortHql("");
        xQuery.updateHql();
        List<Object> categoryList = baseManager.listObject(xQuery);
        for (Object category : categoryList) {
            XQuery projectQuery = new XQuery("listProject_default", request);
            projectQuery.put("projectCategory_id", ((ProjectCategory) category).getId());
            projectQuery.setSortHql("");
            projectQuery.updateHql();
            projectMap.put(((ProjectCategory) category).getId(), baseManager.listObject(projectQuery));
        }
        model.addAttribute("categoryList", categoryList);
        model.addAttribute("projectMap", projectMap);
        return "/common/productCategory";
    }

    @RequestMapping({"/news"})
    public String listNews(){

        return "/common/news";

    }

    @RequestMapping({"/500"})
    public String show500(){
        return "/common/500";
    }

    @RequestMapping({"/404"})
    public String show404(){
        return "/common/404";
    }


//    @RequestMapping({"/test/404"})
//    public String show404Test(){
//        return "/common/test";
//    }
//
//    @RequestMapping({"/test/500"})
//    public String show5004Test(){
//       throw new RuntimeException();
//    }


    @RequestMapping({"/test.do"})
    public String test(){
        return "/test";
    }




}
