package com.efeiyi.ec.wiki.art.controller;

import com.efeiyi.ec.master.model.MasterProject;
import com.efeiyi.ec.master.model.MasterWork;
import com.efeiyi.ec.wiki.model.Artistry;
import com.ming800.core.base.controller.BaseController;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import com.ming800.core.p.service.ObjectRecommendedManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
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
     * 工艺详情:description技艺描述；
     * 相关大师，在MasterProject中取；相关作品取project下面的ProductModel推荐；
     * @param projectWikiId
     * @param request
     * @param model
     */
    @RequestMapping("/project/{projectWikiId}")
    public String getProjectDetail(HttpServletRequest request,Model model,@PathVariable String projectWikiId) throws Exception {
        Artistry artistry = (Artistry) baseManager.getObject(Artistry.class.getName(),projectWikiId);
        String projectId = null;
        try {
            projectId = artistry.getProject().getId();
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
        model.addAttribute("artistry",artistry);
        return "/project/craftDescription";
    }
}
