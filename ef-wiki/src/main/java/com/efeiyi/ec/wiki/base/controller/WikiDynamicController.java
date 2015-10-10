package com.efeiyi.ec.wiki.base.controller;

import com.efeiyi.ec.organization.model.MyUser;
import com.efeiyi.ec.project.model.Project;
import com.efeiyi.ec.project.model.ProjectCategory;
import com.efeiyi.ec.project.model.ProjectFollowed;
import com.efeiyi.ec.project.model.ProjectRecommended;
import com.efeiyi.ec.wiki.model.ProjectModel;
import com.efeiyi.ec.wiki.organization.util.AuthorizationUtil;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.PageInfo;
import com.ming800.core.does.model.XQuery;
import com.ming800.core.p.service.BannerManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;

/**
 * Created by Administrator on 2015/10/8.
 *
 */
@Controller
@RequestMapping("/pc")
public class WikiDynamicController extends WikibaseController {
    private static Logger logger = Logger.getLogger(WikiDynamicController.class);
    @Autowired
    BaseManager baseManager;
    @Autowired
    private BannerManager bannerManager;

    @RequestMapping("/index.do")
    public ModelAndView getHotProjects(HttpServletRequest request, Model model) throws Exception {
        //轮播图
        List<Object> bannerList = getBanners();
        model.addAttribute("bannerList", bannerList);
        //通过类别查询所有的工艺
        //1.获取所有的类别
        XQuery query = new XQuery("listProjectCategory_default", request);
        List<ProjectCategory> list = baseManager.listObject(query);
        //一步加载
        /*String index = request.getParameter(PageEntity.PARAM_NAME_PAGEINDEX);
        String size = request.getParameter(PageEntity.PARAM_NAME_PAGERECORDS);*/
        List<List<Project>> pc = new ArrayList<List<Project>>();
        for (ProjectCategory projectCategory : list){
            XQuery query2 = new XQuery("listProject2_byCategory", request);
            List<Project> listp = baseManager.listObject(query2);
            pc.add(listp);
        }
        model.addAttribute("projectCategory", pc);
       //关注前or关注后
        if (AuthorizationUtil.getMyUser().getId() != null) {
            XQuery query3 = new XQuery("listProjectFollowed_isShow", request);
            query3.put("user_id", AuthorizationUtil.getMyUser().getId());
            List<ProjectFollowed> projectFolloweds = baseManager.listObject(query3);
            if (projectFolloweds.size() >= 5) {
                model.addAttribute("isShow", "ok");
            } else {
                model.addAttribute("isShow", "no");
            }
        } else {
            model.addAttribute("isShow", "no");
        }

        return new ModelAndView("/hotProjects/PopularProjects");
    }
    //获取轮播图
    public List<Object> getBanners()throws Exception{
        return bannerManager.getBannerList("wiki.pc.dynamic");
    }

    @RequestMapping("/beforeAttention.do")
    public ModelAndView getBeforeAttention(HttpServletRequest request, Model model) throws Exception {
        //轮播图
        List<Object> bannerList = getBanners();
        model.addAttribute("bannerList", bannerList);

        //关注前or关注后
        if (AuthorizationUtil.getMyUser().getId() != null) {
            XQuery query3 = new XQuery("listProjectFollowed_isShow", request);
            query3.put("user_id", AuthorizationUtil.getMyUser().getId());
            List<ProjectFollowed> projectFolloweds = baseManager.listObject(query3);
            if (projectFolloweds.size() >= 5) {
                model.addAttribute("isShow", "ok");
            } else {
                model.addAttribute("isShow", "no");
            }
            model.addAttribute("fsAmount", projectFolloweds.size());
        } else {
            model.addAttribute("isShow", "no");
            model.addAttribute("fsAmount", "0");
        }

        return new ModelAndView("/attention/beforeAttention");
    }


    @RequestMapping("/xmj.do")
    @ResponseBody
    public List saveProjectFollows(HttpServletRequest request, Model model) throws Exception {
        XQuery query = new XQuery("plistProjectRecommended_default", request);
        PageInfo pageInfo = baseManager.listPageInfo(query);
        List<ProjectRecommended> list = pageInfo.getList();
        List<ProjectModel> pm = new ArrayList<ProjectModel>();
        if (null!=list && list.size()>=1){
            for (ProjectRecommended projectRecommended:list){
                 Project project = projectRecommended.getProject();
                 ProjectModel projectModel = projectConvertprojectModel(project);
                 pm.add(projectModel);
            }
            return pm;
        }

        return new ArrayList<ProjectModel>();

    }


    public ProjectModel projectConvertprojectModel(Project project)  {
        ProjectModel projectModel = new ProjectModel();
        if (project!=null){
            projectModel.setCreateDateTime(project.getCreateDateTime() == null ? new Date (): project.getCreateDateTime());
            projectModel.setAddressDistrict(project.getAddressDistrict().getAddressCity().getAddressProvince().getName()==null?"":project.getAddressDistrict().getAddressCity().getAddressProvince().getName());
            projectModel.setDescription(project.getDescription()==null?"":project.getDescription());
            projectModel.setFsAmount(project.getFsAmount()==null?0l:project.getFsAmount());
            projectModel.setLevel(project.getLevel()==null?"":project.getLevel());
            projectModel.setMasters((long)project.getMasterProjects().size());
            projectModel.setPicture_url(project.getPicture_url()==null?"":project.getPicture_url());
            projectModel.setPicture_wap_url(project.getPicture_wap_url()==null?"":project.getPicture_wap_url());
            projectModel.setProjectId(project.getId()==null?"":project.getId());
            projectModel.setProjectName(project.getName()==null?"":project.getName());
            projectModel.setWorks((long)project.getProductList().size());
        }


        return projectModel;
    }

   //关注后
    @RequestMapping("/afterAttention.do")
    public ModelAndView getAfterAttention(HttpServletRequest request, Model model) throws Exception {
        //轮播图
        List<Object> bannerList = getBanners();
        model.addAttribute("bannerList", bannerList);

        //关注前or关注后
        if (AuthorizationUtil.getMyUser().getId() != null) {
            XQuery query3 = new XQuery("listProjectFollowed_isShow", request);
            query3.put("user_id", AuthorizationUtil.getMyUser().getId());
            List<ProjectFollowed> projectFolloweds = baseManager.listObject(query3);
            if (projectFolloweds.size() >= 5) {
                model.addAttribute("isShow", "ok");
            } else {
                model.addAttribute("isShow", "no");
            }
            model.addAttribute("fsAmount", projectFolloweds.size());
        } else {
            model.addAttribute("isShow", "no");
            model.addAttribute("fsAmount", "0");
        }

        return new ModelAndView("/attention/afterAttention");
    }

}
