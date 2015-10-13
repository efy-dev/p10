package com.efeiyi.association.association.controller;

import com.efeiyi.association.core.DatabaseContextHolder;
import com.ming800.core.base.service.XdoManager;
import com.ming800.core.does.model.Do;
import com.ming800.core.does.model.DoQuery;
import com.ming800.core.does.model.PageInfo;
import com.ming800.core.does.service.DoManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by Administrator on 2015/9/24.
 * 前台首页 Controller
 */
@Controller
@RequestMapping("/home")
public class HomeController {

    @Autowired
    private DoManager doManager;
    @Autowired
    private XdoManager xdoManager;

    @RequestMapping("/home.do")
    public ModelAndView getBannerByGroupId() throws Exception {
        return new ModelAndView("home/home");
    }

    @RequestMapping("/homeBanner.do")
    public ModelAndView getHomeBanner(ModelMap modelMap, HttpServletRequest request) throws Exception {
        //获取轮播图
        String qm = request.getParameter("qm");
        Do tempDo = doManager.getDoByQueryModel(qm.split("_")[0]);//先找到配置文件里的entity
        DoQuery tempDoQuery = tempDo.getDoQueryByName(qm.split("_")[1]);//再从中找到query的信息
        PageInfo pageInfo = xdoManager.listPage(tempDo, tempDoQuery, null, null);
        modelMap.put("bannerList", pageInfo.getList());

        return new ModelAndView("home/homeBanner");
    }

    @RequestMapping("/homeIndustryNews.do")
    public ModelAndView getHomeIndustryNews(ModelMap modelMap, HttpServletRequest request) throws Exception {
        //非遗要闻==行业新闻
        String qm = request.getParameter("qm");
        Do tempDo = doManager.getDoByQueryModel(qm.split("_")[0]);//先找到配置文件里的entity
        DoQuery tempDoQuery = tempDo.getDoQueryByName(qm.split("_")[1]);//再从中找到query的信息
        PageInfo pageInfo = xdoManager.listPage(tempDo, tempDoQuery, null, null);
        modelMap.put("IndustryList", subList(pageInfo.getList(), 3));

        return new ModelAndView("home/homeIndustryNews");
    }

    @RequestMapping("/homeNoteNews.do")
    public ModelAndView getHomeNoteNews(ModelMap modelMap, HttpServletRequest request) throws Exception {
        //重要通知==新闻公告
        String qm = request.getParameter("qm");
        Do tempDo = doManager.getDoByQueryModel(qm.split("_")[0]);//先找到配置文件里的entity
        DoQuery tempDoQuery = tempDo.getDoQueryByName(qm.split("_")[1]);//再从中找到query的信息
        PageInfo pageInfo = xdoManager.listPage(tempDo, tempDoQuery, null, null);
        modelMap.put("NoteList", subList(pageInfo.getList(), 3));

        return new ModelAndView("home/homeNoteNews");
    }

    @RequestMapping("/homeOrgNews.do")
    public ModelAndView getHomeOrgNews(ModelMap modelMap, HttpServletRequest request) throws Exception {
        //协会新闻
        String qm = request.getParameter("qm");
        Do tempDo = doManager.getDoByQueryModel(qm.split("_")[0]);//先找到配置文件里的entity
        DoQuery tempDoQuery = tempDo.getDoQueryByName(qm.split("_")[1]);//再从中找到query的信息
        PageInfo pageInfo = xdoManager.listPage(tempDo, tempDoQuery, null, null);
        modelMap.put("OrgNewsList", subList(pageInfo.getList(), 2));

        return new ModelAndView("home/homeOrgNews");
    }

    @RequestMapping("/homeMaster.do")
    public ModelAndView getHomeMaster(ModelMap modelMap, HttpServletRequest request) throws Exception {

        DatabaseContextHolder.setDataSource("dataSource");//切换数据源
        //传承人
        String qm = request.getParameter("qm");
        Do tempDo = doManager.getDoByQueryModel(qm.split("_")[0]);//先找到配置文件里的entity
        DoQuery tempDoQuery = tempDo.getDoQueryByName(qm.split("_")[1]);//再从中找到query的信息
        PageInfo pageInfo = xdoManager.listPage(tempDo, tempDoQuery, null, null);
        modelMap.put("masterList", subList(pageInfo.getList(), 2));

        DatabaseContextHolder.setDataSource(null);//切换回数据源

        return new ModelAndView("home/homeMaster");
    }

    private List subList(List oldList, int size){
        if (oldList != null && oldList.size()>size){
            List newList = new ArrayList();
            for (int i=0;i<size;i++){
                newList.add(i,oldList.get(i));
            }
            return newList;
        }
        return oldList;
    }

}
