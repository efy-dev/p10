package com.efeiyi.association.association.controller;

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
    public ModelAndView getBannerByGroupId(ModelMap modelMap, HttpServletRequest request) throws Exception {
        //获取轮播图
        String qm = "listPCBanner_default";
        //先找到配置文件里的entity
        Do tempDo = doManager.getDoByQueryModel(qm.split("_")[0]);
        //再从中找到query的信息
        DoQuery tempDoQuery = tempDo.getDoQueryByName(qm.split("_")[1]);
        PageInfo pageInfo = xdoManager.listPage(tempDo, tempDoQuery, null, null);
        modelMap.put("bannerList", pageInfo.getList());

        //非遗要闻==行业新闻
        qm = "plistNewsIndustry_industry";
        //先找到配置文件里的entity
        tempDo = doManager.getDoByQueryModel(qm.split("_")[0]);
        //再从中找到query的信息
        tempDoQuery = tempDo.getDoQueryByName(qm.split("_")[1]);
        pageInfo = xdoManager.listPage(tempDo, tempDoQuery, null, null);
        modelMap.put("IndustryList", subList(pageInfo.getList()));

        //重要通知==新闻公告
        qm = "plistNewsNote_industry";
        //先找到配置文件里的entity
        tempDo = doManager.getDoByQueryModel(qm.split("_")[0]);
        //再从中找到query的信息
        tempDoQuery = tempDo.getDoQueryByName(qm.split("_")[1]);
        pageInfo = xdoManager.listPage(tempDo, tempDoQuery, null, null);
        modelMap.put("NoteList", subList(pageInfo.getList()));

        return new ModelAndView("home/home");
    }

    private List subList(List oldList){
        if (oldList != null && oldList.size()>3){
            List newList = new ArrayList();
            for (int i=0;i<3;i++){
                newList.add(i,oldList.get(i));
            }
            return newList;
        }
        return oldList;
    }

}
