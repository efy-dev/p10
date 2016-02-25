package com.efeiyi.ec.consumer.base.controller;

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
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;

/**
 * Created by Administrator on 2015/8/17.
 */
@Controller
public class HomeController {


    @Autowired
    private BaseManager baseManager;

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


    @RequestMapping("/401")
    public String show401() throws Exception {
        return "redirect:/";
    }





}
