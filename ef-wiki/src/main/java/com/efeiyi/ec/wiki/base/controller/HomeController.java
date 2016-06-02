package com.efeiyi.ec.wiki.base.controller;

import com.efeiyi.ec.yale.question.model.Question;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.PageInfo;
import com.ming800.core.does.model.XQuery;
import com.ming800.core.p.service.BannerManager;
import com.ming800.core.p.service.ObjectRecommendedManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * Created by Administrator on 2016/4/13.
 */
@Controller
public class HomeController {
    @Autowired
    BaseManager baseManager;
    @Autowired
    BannerManager bannerManager;
    @Autowired
    ObjectRecommendedManager objectRecommendedManager;

    /**
     * PC和移动首页；推荐技艺列表；轮播图；
     *
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping({"/home.do"})
    public String home(HttpServletRequest request, Model model) throws Exception {
        XQuery query = new XQuery("listArtistryRecommended_default", request);
        query.put("artistry_type", "1");
        List<Object> artRecommendList = baseManager.listObject(query);
        query.put("artistry_type", "2");
        List<Object> craftRecommendList = baseManager.listObject(query);
        model.addAttribute("artRecommendList", artRecommendList);
        model.addAttribute("craftRecommendList", craftRecommendList);
        //@TODO PC轮播图groupname待定
        List<Object> pcBannerList = bannerManager.getBannerList("wiki.pc.dynamic");
        //@TODO wap轮播图groupname待定
        List<Object> wapBannerList = bannerManager.getBannerList("wiki.wap.dynamic");
        model.addAttribute("pcBannerList", pcBannerList);
        model.addAttribute("wapBannerList", wapBannerList);
        return "/home";
    }

    @RequestMapping({"/dati"})
    public String dati(HttpServletRequest request) {
        return "/dati";
    }

    @RequestMapping({"/question"})
    public String questionMap(HttpServletRequest request, Model model) {
        List<Question> questions = baseManager.listObject("select obj from Question obj where obj.status!='0'");
        model.addAttribute("questions", questions);
        return "/questionMap";
    }

}
