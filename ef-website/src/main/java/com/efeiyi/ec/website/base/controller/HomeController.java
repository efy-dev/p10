package com.efeiyi.ec.website.base.controller;

import com.efeiyi.ec.project.model.ProjectCategory;
import com.efeiyi.ec.zero.promotion.model.PromotionPlan;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import com.ming800.core.p.service.BannerManager;
import com.ming800.core.p.service.ObjectRecommendedManager;
import com.ming800.core.util.CookieTool;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.net.URLDecoder;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;

@Controller
public class HomeController {

    @Autowired
    private ObjectRecommendedManager objectRecommendedManager;

    @Autowired
    private BannerManager bannerManager;

    @Autowired
    private BaseManager baseManager;

    @RequestMapping({"/logoutHandler"})
    public String logoutHandler(HttpServletResponse response) {
        //只有手动退出的时候清除cookie
        CookieTool.addCookie(response, "userinfo", "", 1, ".efeiyi.com");
        return "redirect:/";
    }

    @RequestMapping({"/home.do"})
    public String home1(HttpServletRequest request, Model model) throws Exception {

        //判断是否有需要重定向的页面
        String redirectUrl = request.getParameter("redirect");
        if (redirectUrl != null) {
            return "redirect:" + redirectUrl;
        }
        //取得分类列表
        XQuery projectCategoryxQuery = new XQuery("listProjectCategory_default", request);
        projectCategoryxQuery.setSortHql("");
        projectCategoryxQuery.updateHql();
        List<Object> categoryList = baseManager.listObject(projectCategoryxQuery);
        List<Object> recommendedCategoryList = objectRecommendedManager.getRecommendedList("categoryRecommended");
        //店铺推荐
        List<Object> recommendedTenantList = objectRecommendedManager.getRecommendedList("tenantRecommended");
        //tenant_project
        HashMap<String, List> map = new HashMap<>();
        HashMap<String, List> projectMap = new HashMap<>();
        for (Object object : categoryList) {
            //取得推荐分类下面商品
            XQuery xQuery = new XQuery("listProjectCategoryProductModel_default", request);
            xQuery.put("projectCategory_id", ((ProjectCategory) object).getId());
            map.put(((ProjectCategory) object).getId(), baseManager.listObject(xQuery));
            //首页
            XQuery projectQuery = new XQuery("listProject_default", request);
            projectQuery.put("projectCategory_id", ((ProjectCategory) object).getId());
            projectQuery.setSortHql("");
            projectQuery.updateHql();
            projectMap.put(((ProjectCategory) object).getId(), baseManager.listObject(projectQuery));
        }
        model.addAttribute("recommendMap", map);
        model.addAttribute("categoryList", categoryList);
        model.addAttribute("recommendedCategoryList", recommendedCategoryList);
        //首页轮播图
        List<Object> bannerList = bannerManager.getBannerList("ec.home.banner");
        model.addAttribute("bannerList", bannerList);
        model.addAttribute("bannerFlag", "true");
        //传承人
        List<Object> masterList = objectRecommendedManager.getRecommendedList("ec.masterRecommended");
        model.addAttribute("masterList", masterList);
        model.addAttribute("sign", "000");
        //广告区域 营销活动 热卖商品 广告区
        XQuery marketingActivityQuery = new XQuery("listAdvertisement_default1", request);
        XQuery hotSaleQuery = new XQuery("listAdvertisement_default3", request);
        XQuery bannerQuery = new XQuery("listAdvertisement_default5", request);
        List<Object> marketingActivityQueryList = baseManager.listObject(marketingActivityQuery);
        List<Object> hotSaleList = baseManager.listObject(hotSaleQuery);
        List<Object> bannerActivityList = baseManager.listObject(bannerQuery);
        //热卖商品
        if (marketingActivityQueryList != null && marketingActivityQueryList.size() > 0) {
            model.addAttribute("marketingActivityQueryList", marketingActivityQueryList);
        }
        if (hotSaleList != null && hotSaleList.size() > 0) {
            model.addAttribute("hotSaleList", hotSaleList);
        }
        if (bannerActivityList != null && bannerActivityList.size() > 0) {
            model.addAttribute("bannerActivityList", bannerActivityList);
        }
        model.addAttribute("projectMap", projectMap);
        model.addAttribute("recommendedTenantList", recommendedTenantList);
        return "/home";
    }


    @RequestMapping({"/productCategory.do"})
    public String listProductCategory(HttpServletRequest request, Model model) throws Exception {
        //取得分类列表
        XQuery projectCategoryXQuery = new XQuery("listProjectCategory_default", request);
        projectCategoryXQuery.setSortHql("");
        projectCategoryXQuery.updateHql();
        List<Object> categoryList = baseManager.listObject(projectCategoryXQuery);
        HashMap<String, List> projectMap = new HashMap<>();
        for (Object object : categoryList) {
            XQuery projectQuery = new XQuery("listProject_default", request);
            projectQuery.put("projectCategory_id", ((ProjectCategory) object).getId());
            projectQuery.setSortHql("");
            projectQuery.updateHql();
            projectMap.put(((ProjectCategory) object).getId(), baseManager.listObject(projectQuery));
        }
        model.addAttribute("categoryList", categoryList);
        model.addAttribute("projectMap", projectMap);
        return "/common/productCategory";
    }


    @RequestMapping({"/500"})
    public String show500() {
        return "/common/500";
    }

    @RequestMapping({"/404"})
    public String show404() {
        return "/common/404";
    }

    @RequestMapping("/401")
    public String show401() throws Exception {
        return "redirect:/";
    }

    @RequestMapping({"/toMobile.do"})
    public String toMobileHandler(HttpServletRequest request, Model model) throws Exception {
        String url = request.getParameter("mobileUrl");
        url = URLDecoder.decode(url, "UTF-8");
        model.addAttribute("url", url);
        return "/toMobile";

    }

    @RequestMapping({"/watchUrlSource.do"})
    @ResponseBody
    public String watchedUrl(HttpServletRequest request) throws Exception {
        String currentUrl = request.getParameter("currentUrl");
        if (currentUrl.contains("source")) {
            String source = currentUrl.substring(currentUrl.indexOf("source"));
            if (source.contains("&")) {
                source = source.substring(source.indexOf("source"), source.indexOf("&"));
            }
            source = source.substring(source.indexOf("=") + 1);
            LinkedHashMap<String,Object> queryParamMap = new LinkedHashMap<>();
            queryParamMap.put("identifier", source);
            PromotionPlan promotionPlan = (PromotionPlan) baseManager.getUniqueObjectByConditions("from PromotionPlan x where x.identifier=:identifier", queryParamMap);
            if (promotionPlan != null && !"0".equals(promotionPlan.getStatus())) {
                Integer clickCount = promotionPlan.getClickCount();
                promotionPlan.setClickCount(clickCount == null ? 1 : clickCount + 1);
                baseManager.saveOrUpdate(PromotionPlan.class.getName(), promotionPlan);
            }
        }
        return "recorded";
    }

}
