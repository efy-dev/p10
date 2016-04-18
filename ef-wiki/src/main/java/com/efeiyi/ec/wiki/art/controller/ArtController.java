package com.efeiyi.ec.wiki.art.controller;

import com.efeiyi.ec.master.model.MasterProject;
import com.efeiyi.ec.master.model.MasterWork;
import com.efeiyi.ec.organization.model.AddressProvince;
import com.efeiyi.ec.product.model.Product;
import com.efeiyi.ec.product.model.ProductModel;
import com.efeiyi.ec.project.model.Project;
import com.efeiyi.ec.project.model.ProjectCategory;
import com.efeiyi.ec.wiki.model.ProjectContent;
import com.efeiyi.ec.wiki.model.ProjectWiki;
import com.ming800.core.base.controller.BaseController;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.PageInfo;
import com.ming800.core.does.model.XQuery;
import com.ming800.core.p.service.ObjectRecommendedManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;

/**
 * Created by Administrator on 2016/4/12.
 */
@Controller
public class ArtController extends BaseController {

    @Autowired
    BaseManager baseManager;
    @Autowired
    ObjectRecommendedManager objectRecommendedManager;

    /**
     * 列出技艺和美术
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/listProjectCategory.do")
    public String listProjectCategory(HttpServletRequest request,Model model){
        String craftQuery = "FROM ProjectWiki p WHERE p.type = 2 AND p.status != 0";
        List<ProjectContent> craftList = baseManager.listObject(craftQuery);
        String artQuery = "FROM ProjectWiki p WHERE p.type = 1 AND p.status != 0";
        List<ProjectContent> artList = baseManager.listObject(artQuery);
        model.addAttribute("artList",artList);
        model.addAttribute("craftList",craftList);
        return "";
    }
    /**
     * 工艺详情:description技艺描述；level判断级别;addressDistrict判断省市；
     * 相关大师，在MasterProject中取；相关作品取project下面的ProductModel推荐；
     * @param projectWikiId
     * @param request
     * @param model
     */
    @RequestMapping("/project/{projectWikiId}")
    public String getProjectDetail(HttpServletRequest request,Model model,@PathVariable String projectWikiId) throws Exception {
        ProjectWiki projectWiki = (ProjectWiki) baseManager.getObject(ProjectWiki.class.getName(),projectWikiId);
//        project.setVisits(project.getVisits()==null?1:project.getVisits()+1);
//        baseManager.saveOrUpdate(Project.class.getName(),project);
        String projectId = null;
        try {
            projectId = projectWiki.getProject().getId();
        }catch (Exception e){
            projectId = null;
        }
        //相关大师
        XQuery xquery = new XQuery("listMasterProject_byProject",request);
        xquery.put("project_id",projectId);
        List<MasterProject> masterProjectList = baseManager.listObject(xquery);
        XQuery mwXQuery = new XQuery("listMasterWork_default", request);
        //相关作品
        mwXQuery.put("project_id",projectId);
        List<MasterWork> masterWorkList = baseManager.listObject(mwXQuery);
        model.addAttribute("masterProjectList",masterProjectList);
        model.addAttribute("masterWorkList",masterWorkList);
        model.addAttribute("projectWiki",projectWiki);
        return "/project/craftDescription";
    }
}
