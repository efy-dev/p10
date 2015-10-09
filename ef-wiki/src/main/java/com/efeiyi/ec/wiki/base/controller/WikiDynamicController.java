package com.efeiyi.ec.wiki.base.controller;

import com.efeiyi.ec.project.model.Project;
import com.efeiyi.ec.project.model.ProjectCategory;
import com.efeiyi.ec.project.model.ProjectRecommended;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import com.ming800.core.p.service.BannerManager;
import com.ming800.core.taglib.PageEntity;
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
        List<Object> bannerList = bannerManager.getBannerList("wiki.pc.dynamic");
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


        return new ModelAndView("/hotProjects/PopularProjects");
    }

}
