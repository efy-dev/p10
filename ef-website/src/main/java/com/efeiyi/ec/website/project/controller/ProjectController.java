package com.efeiyi.ec.website.project.controller;
import com.efeiyi.ec.product.model.Product;
import com.efeiyi.ec.project.model.Project;
import com.efeiyi.ec.project.model.ProjectCategory;
import com.ming800.core.base.controller.BaseController;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import com.ming800.core.p.service.BannerManager;
import com.ming800.core.p.service.ObjectRecommendedManager;
import com.sun.javafx.sg.prism.NGShape;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.ws.rs.Path;
import java.util.*;

/**
 * Created by Administrator on 2015/6/25.
 */
@Controller
@RequestMapping("/project")
public class ProjectController extends BaseController {
    @Autowired
    private BaseManager baseManager;

    @Autowired
    private ObjectRecommendedManager objectRecommendedManager;

    @Autowired
    private BannerManager bannerManager;

    @RequestMapping(value = "/listProject.do")
    public String queryProjectList(Model model,HttpServletRequest request ) throws Exception{

        XQuery xQuery = new XQuery("listProject_default",request);
        List list = this.baseManager.listObject(xQuery);
//        xQuery.addRequestParamToModel(model,request);
//        List list = baseManager.listPageInfo(xQuery).getList();

        model.addAttribute("list",list);
        return "/pc/project/projectlist";
    }

    @RequestMapping(value = "/getProject.do")
    public String getProject(Model model,HttpServletRequest request ) throws Exception{
        String id = request.getParameter("id");
        Project project = (Project) this.baseManager.getObject(Project.class.getName(), id);
        model.addAttribute("project",project);
        return "/pc/project/projectView";
    }


    @RequestMapping("/list/{categoryId}")
    public String listProjectByCategory(HttpServletRequest request , @PathVariable String categoryId ,Model model) throws Exception{
        //@TODO 轮播图位置
        List<Object> bannerList = bannerManager.getBannerList("ec.home.banner");
        ProjectCategory projectCategory = (ProjectCategory) baseManager.getObject(ProjectCategory.class.getName(),categoryId);
        model.addAttribute("bannerList", bannerList);
        XQuery projectQuery = new XQuery("listProject_default",request);
        projectQuery.put("projectCategory_id",categoryId);
        List<Object> projectList = baseManager.listObject(projectQuery);
        model.addAttribute("projectList",projectList);
        List<Object> tenantList = objectRecommendedManager.getRecommendedList("tenantRecommended");
        model.addAttribute("tenantList",tenantList);

        HashMap<String,List<Object>> productMap = new HashMap<>();
        XQuery productQuery = new XQuery("plistProduct_byproject",request,6);
        for (Object project : projectList){
            productQuery.put("project_id",((Project)project).getId());
            productMap.put(((Project)project).getId(),baseManager.listPageInfo(productQuery).getList());
        }
        model.addAttribute("sign", "000");
        model.addAttribute("productMap",productMap);
        model.addAttribute("projectCategory",projectCategory);
        return "/project/projectList";
    }
}
