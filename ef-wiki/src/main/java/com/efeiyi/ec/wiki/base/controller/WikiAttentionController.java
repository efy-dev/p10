package com.efeiyi.ec.wiki.base.controller;

import com.efeiyi.ec.project.model.*;
import com.efeiyi.ec.wiki.base.util.projectConvertprojectModelUtil;
import com.efeiyi.ec.wiki.model.ProjectDataModel;
import com.efeiyi.ec.wiki.model.ProjectModel;
import com.efeiyi.ec.wiki.organization.util.AuthorizationUtil;
import com.ming800.core.base.dao.XdoDao;
import com.ming800.core.base.dao.hibernate.XdoDaoSupport;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.PageInfo;
import com.ming800.core.does.model.XQuery;
import com.ming800.core.p.model.ObjectRecommended;
import com.ming800.core.p.service.BannerManager;
import com.ming800.core.p.service.ObjectRecommendedManager;
import org.apache.log4j.Logger;
import org.hibernate.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by Administrator on 2015/10/8.
 *
 */
@Controller
@RequestMapping("/pc")
public class WikiAttentionController extends WikibaseController {
    private static Logger logger = Logger.getLogger(WikiAttentionController.class);
    @Autowired
    BaseManager baseManager;
    @Autowired
    private XdoDaoSupport xdoDao;
    @Autowired
    private BannerManager bannerManager;
    @Autowired
    private ObjectRecommendedManager objectRecommendedManager;



    @RequestMapping("/index.do")
    public ModelAndView getHotProjects(HttpServletRequest request, Model model) throws Exception {
        //轮播图
        List<Object> bannerList = getBanners();
        model.addAttribute("bannerList", bannerList);
        //通过类别查询所有的工艺
        //1.获取所有的类别
/*
        XQuery query = new XQuery("listProjectCategory_default", request);
        List<ProjectCategory> list = baseManager.listObject(query);
        //一步加载

        List<List<Project>> pc = new ArrayList<List<Project>>();
        for (ProjectCategory projectCategory : list){

            XQuery query2 = new XQuery("listProject2_byCategory", request);
            query2.put("projectCategory_id", projectCategory.getId());
            List<Project> listp = baseManager.listObject(query2);
            if(listp!=null && !listp.isEmpty()){
                pc.add(listp);
            }

        }*/
        List<List<Project>> pc = new ArrayList<List<Project>>();
        Session session = xdoDao.getSession();

        List<ProjectCategoryRecommended> projectCategoryRecommendeds = session.createSQLQuery(
                "SELECT * FROM base_recommended a \n" +
                "      where  a.group_name=\"wiki.categoryRecommended\" \n" +
                "      and a.status=\"1\"")
                .addEntity(ProjectCategoryRecommended.class).list();


        for (ProjectCategoryRecommended projectCategoryRecommended :projectCategoryRecommendeds){
            String id = projectCategoryRecommended.getProjectCategory().getId();
            List<Project> projects =session.createSQLQuery("SELECT * from project p WHERE  EXISTS(\n" +
                    "      SELECT 1 FROM base_recommended a \n" +
                    "      where  a.group_name=\"wiki.projectRecommended\" \n" +
                    "      and a.status=\"1\"\n" +
                    "      and a.recommend_id = p.id\n" +
                    "\n" +
                    ") AND EXISTS(\n" +
                    "      SELECT 1 FROM base_recommended a \n" +
                    "      where  a.group_name=\"wiki.categoryRecommended\" \n" +
                    "      and a.status=\"1\"\n" +
                    "      and a.recommend_id = p.category_id AND  a.recommend_id=" +"'"+id+"'"+
                    ")   ").addEntity(Project.class).list();
            if(projects !=null &&!projects.isEmpty()){
                pc.add(projects);
            }

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


    @RequestMapping("/prj.do")
    @ResponseBody
    public List saveProjectFollows(HttpServletRequest request) throws Exception {
        XQuery query = new XQuery("plistProjectRecommended_default", request);
        PageInfo pageInfo = baseManager.listPageInfo(query);
        List<ProjectRecommended> list = pageInfo.getList();
        List<ProjectModel> pm = new ArrayList<ProjectModel>();
        if (list!=null && !list.isEmpty()){
            for (ProjectRecommended projectRecommended:list){
                 Project project = projectRecommended.getProject();
                 ProjectModel projectModel = projectConvertprojectModelUtil.projectConvertprojectModel(project);
                 pm.add(projectModel);
            }
            return pm;
        }

        return new ArrayList<ProjectModel>();

    }




   //关注后
    @RequestMapping("/afterAttention.do")
    public ModelAndView getAfterAttention(HttpServletRequest request, Model model) throws Exception {
        //轮播图
        List<Object> bannerList = getBanners();
        model.addAttribute("bannerList", bannerList);
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

@RequestMapping("/afterAtJ.do")
@ResponseBody
public List getAttentionProjects(HttpServletRequest request) throws Exception {
    XQuery query = new XQuery("plistProjectFollowed2_isShow", request);
    query.put("user_id", AuthorizationUtil.getMyUser().getId());
    PageInfo pageInfo = baseManager.listPageInfo(query);
    List<ProjectFollowed> projectFolloweds = pageInfo.getList();
    List<ProjectDataModel> pm = new ArrayList<ProjectDataModel>();
    if (projectFolloweds!=null && !projectFolloweds.isEmpty()){
        for (ProjectFollowed projectFollowed:projectFolloweds){
            Project project = projectFollowed.getProject();
            ProjectDataModel projectDataModel = projectConvertprojectModelUtil.getProjectDataModel(project);
            pm.add(projectDataModel);
        }
        return pm;
    }

    return new ArrayList<ProjectModel>();

}
}
