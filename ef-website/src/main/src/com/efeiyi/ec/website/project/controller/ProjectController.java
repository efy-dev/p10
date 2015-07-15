package com.efeiyi.ec.website.project.controller;
import com.efeiyi.ec.project.model.Project;
import com.ming800.core.base.controller.BaseController;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import java.util.*;

/**
 * Created by Administrator on 2015/6/25.
 */
@Controller
@RequestMapping("/project")
public class ProjectController extends BaseController {
    @Autowired
    private BaseManager baseManager;

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
}
