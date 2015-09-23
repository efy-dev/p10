package com.efeiyi.ec.wiki.base.controller;

import com.efeiyi.ec.organization.model.MyUser;
import com.efeiyi.ec.project.model.Project;
import com.efeiyi.ec.project.model.ProjectFollowed;
import com.efeiyi.ec.project.model.ProjectRecommended;
import com.efeiyi.ec.wiki.organization.util.AuthorizationUtil;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import org.apache.http.HttpResponse;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2015/7/31.
 *
 */
@Controller
@RequestMapping("/base")
public class WikiIndexController extends WikibaseController {
    private static Logger logger = Logger.getLogger(WikiIndexController.class);
    @Autowired
    BaseManager baseManager;

    /**
     * 非遗百科首页展示
     * @param request is HttpServletRequest,model
     * @return "/wiki/showIndex"
     */
    @RequestMapping("/getTenant.do")
    public ModelAndView getTenant( HttpServletRequest request  , Model model)throws Exception{
        logger.info("weiki  for efeiyi index begin...");

        model.addAttribute("bannerList",getWikiBannerList(request));
        model.addAttribute("projectList",getFeiyiProjectList(request));
        model.addAttribute("recommendProjectList",getRecommendProjectList());
        model.addAttribute("recommendTenantList",getRecommendTenantList());
        model.addAttribute("wondenfulProjectList",getWondenfulProjectList());
        model.addAttribute("wondenfulVideosList",getWondenfulVideosList());

        logger.info("weiki for efeiyi index end...");
        return new ModelAndView("/wiki/showIndex");

    }

    /**
     * 首页轮播图
     * @param request is HttpServletRequest
     * @return bannerList
     * @throws Exception
     */
    public List getWikiBannerList(HttpServletRequest request)throws Exception{
        XQuery xQuery = new XQuery("listWikiBanner_default",request);
        return baseManager.listObject(xQuery);
    }

    /**
     * 非遗百科热门展示
     * @param request is HttpServletRequest,model
     * @return "/wiki/showIndex"
     */
    @RequestMapping("/home.do")
    public ModelAndView getHotProjects( HttpServletRequest request  , Model model)throws Exception{

        XQuery query = new XQuery("plistProjectRecommended_default",request);
        List<ProjectRecommended> list = baseManager.listObject(query);
        model.addAttribute("popularProjectsList",list);

        XQuery query2 = new XQuery("plistProjectRecommended_default",request);
        //query2.put("groupName","attentionProject");
        List<ProjectRecommended> list2 = baseManager.listObject(query2);
        model.addAttribute("attentionProjectsList",list2);

        if(AuthorizationUtil.getMyUser().getId()!=null){
            XQuery query3 = new XQuery("listProjectFollowed_isShow",request);
            query3.put("user_id",AuthorizationUtil.getMyUser().getId());
            List<ProjectFollowed>  projectFolloweds = baseManager.listObject(query3);
            if (projectFolloweds.size()>=5){
                model.addAttribute("isShow","ok");
            }else {
                model.addAttribute("isShow","no");
            }
        }else{
            model.addAttribute("isShow","no");
        }

        return new ModelAndView("/hotProjects/PopularProjects");
    }
    @RequestMapping("/getHotProjects.do")
    public List getHotProjects( HttpServletRequest request)throws Exception{
        List list = getWondenfulProjectList();
        return list;
    }

    @RequestMapping("/getPerson.do")
     public ModelAndView getPersonCenter( HttpServletRequest request, Model model)throws Exception{
        return new ModelAndView("/personal/personalCenter");
    }

    @RequestMapping("/getPersonalInfo.do")
     public ModelAndView getPersonInfo( HttpServletRequest request, Model model)throws Exception{
        return new ModelAndView("/personal/personalInfoView");
    }

    @RequestMapping("/attention.do")
    @ResponseBody
    public boolean saveProjectFollows( HttpServletRequest request, Model model)throws Exception{
        String projectid = request.getParameter("projectId");
        ProjectFollowed projectFollowed = new ProjectFollowed();
        MyUser user= AuthorizationUtil.getMyUser();
        if (user.getId()==null){
            return false;
        }
        projectFollowed.setUser(user);
        Project project = (Project)baseManager.getObject(Project.class.getName(),projectid);
        projectFollowed.setProject(project);
        projectFollowed.setStatus("1");
        projectFollowed.setCreateDatetime(new Date());
        project.setFsAmount(project.getFsAmount()==null?(0+1):(project.getFsAmount()+1));
        baseManager.saveOrUpdate(Project.class.getName(),project);
        baseManager.saveOrUpdate(ProjectFollowed.class.getName(),projectFollowed);

        return true;
    }
    @RequestMapping("/Isattention.do")
    @ResponseBody
    public boolean checkIsAttention( HttpServletRequest request,Model model)throws Exception{
        boolean flag = false;
        String projectid = request.getParameter("projectId");
        if (AuthorizationUtil.getMyUser().getId()!= null){
            XQuery xQuery = new XQuery("plistProjectFollowed_check",request);
            xQuery.put("project_id",projectid);
            xQuery.put("user_id",AuthorizationUtil.getMyUser().getId());
            List<ProjectFollowed> list =  baseManager.listObject(xQuery);
            if (list!= null || list.size()>=1){
                flag = true;
            }
        }

        return  flag;
    }


    @RequestMapping("/brifProject.do")
    public ModelAndView getBrifProject( HttpServletRequest request,Model model)throws Exception{
           String projectId = request.getParameter("projectId");
           Project project = (Project)baseManager.getObject(Project.class.getName(),projectId);
           model.addAttribute("project",project);
        return new ModelAndView("/project/brifProject");
    }


}
