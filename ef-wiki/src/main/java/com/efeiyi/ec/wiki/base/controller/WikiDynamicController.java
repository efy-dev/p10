package com.efeiyi.ec.wiki.base.controller;

import com.efeiyi.ec.project.model.Project;
import com.efeiyi.ec.project.model.ProjectCategory;
import com.efeiyi.ec.project.model.ProjectFollowed;
import com.efeiyi.ec.wiki.organization.util.AuthorizationUtil;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import com.ming800.core.p.service.BannerManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
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
            model.addAttribute("fsAmount", 0);
        }

        return new ModelAndView("/attention/beforeAttention");
    }
}
