package com.efeiyi.ec.website.base.controller;

import com.efeiyi.ec.gift.model.ProductGiftTagValue;
import com.efeiyi.ec.master.model.Master;
import com.efeiyi.ec.master.model.MasterUserTemp;
import com.efeiyi.ec.organization.model.Panel;
import com.efeiyi.ec.organization.model.User;
import com.efeiyi.ec.product.model.ProductModel;
import com.efeiyi.ec.project.model.ProjectCategory;
import com.efeiyi.ec.purchase.model.PurchaseOrder;
import com.efeiyi.ec.purchase.model.PurchaseOrderPayment;
import com.efeiyi.ec.tenant.model.BigTenant;
import com.efeiyi.ec.zero.promotion.model.PromotionPlan;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import com.ming800.core.p.service.BannerManager;
import com.ming800.core.p.service.ObjectRecommendedManager;
import com.ming800.core.util.CookieTool;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
public class HomeController {

    @Autowired
    private ObjectRecommendedManager objectRecommendedManager;

    @Autowired
    private BannerManager bannerManager;

    @Autowired
    private BaseManager baseManager;



    @RequestMapping({"/datafrom1.do"})
    @ResponseBody
    public List selectDataFrom() {
        List<Integer> optionList = new ArrayList<>();
        for (int i = 0; i < 10; i++) {
            optionList.add(i);
        }
        return optionList;
    }

    @RequestMapping({"/demo.do"})
    public String selectDemo() {
        return "/demo";
    }


    @RequestMapping({"/logoutHandler"})
    public String logoutHandler(HttpServletResponse response) {
        //只有手动退出的时候清除cookie
        CookieTool.addCookie(response, "userinfo", "", 1, ".efeiyi.com");
        return "redirect:/";
    }

    /**
     * 大首页各种推荐
     */
    @RequestMapping({"/main.do"})
    public String home(HttpServletRequest request, Model model) throws Exception {
        //大首页轮播图
        List<Object> bannerList = bannerManager.getBannerList("ec.main.banner");
        model.addAttribute("bannerList", bannerList);
        //商品推荐
        List<Object> recommendedProductList = objectRecommendedManager.getRecommendedList("mainProductRecommended");
        model.addAttribute("productList", recommendedProductList);
        //大师推荐
        List<Object> recommendedMasterList = objectRecommendedManager.getRecommendedList("mainMasterRecommended");
        model.addAttribute("masterList", recommendedMasterList);
        LinkedHashMap<Object, List> masterNewsMap = new LinkedHashMap<>();
        String hql = "from MasterNews where master.id =:id and status=1";
        LinkedHashMap queryMap = new LinkedHashMap();
        if (recommendedMasterList != null && recommendedMasterList.size() > 0) {
            for (int i = 0; i < recommendedMasterList.size(); i++) {
                //非遗资讯
                Master master = (Master) recommendedMasterList.get(i);
                queryMap.put("id", master.getId());
                List<Object> newsList = baseManager.listObject(hql, queryMap);
                masterNewsMap.put(master, newsList);
            }
        }
        model.addAttribute("masterNewsMap", masterNewsMap);
        //礼品推荐
        List<Object> recommendedSubjectList = objectRecommendedManager.getRecommendedList("mainGiftListRecommended");
        model.addAttribute("subjectList", recommendedSubjectList);
        //非遗百科推荐
        List<Object> recommendedArtistryList = objectRecommendedManager.getRecommendedList("mainArtistryRecommended");
        model.addAttribute("artistryList", recommendedArtistryList);
        //首页类别推荐
        XQuery projectCategoryXQuery = new XQuery("listProjectCategory_default", request);
        projectCategoryXQuery.setSortHql("");
        projectCategoryXQuery.updateHql();
        List<Object> categoryList = baseManager.listObject(projectCategoryXQuery);
        HashMap<String, List> projectMap = new HashMap<>();
        for (Object object : categoryList) {
            //取得推荐分类下面商品
            XQuery projectQuery = new XQuery("listProject_default", request);
            projectQuery.put("projectCategory_id", ((ProjectCategory) object).getId());
            projectQuery.setSortHql("");
            projectQuery.updateHql();
            projectMap.put(((ProjectCategory) object).getId(), baseManager.listObject(projectQuery));

        }
        model.addAttribute("categoryList", categoryList);
        model.addAttribute("projectMap", projectMap);
        XQuery marketingActivityQuery = new XQuery("listAdvertisement_default1", request);
        XQuery hotSaleQuery = new XQuery("listAdvertisement_default3", request);
        List<Object> marketingActivityQueryList = baseManager.listObject(marketingActivityQuery);
        List<Object> hotSaleList = baseManager.listObject(hotSaleQuery);
        model.addAttribute("marketingActivityQueryList", marketingActivityQueryList);
        model.addAttribute("hotSaleList", hotSaleList);
        model.addAttribute("init", "true");
        Map<String, List<ProductGiftTagValue>> map = new HashMap<>();
        XQuery productGiftTagValueQuery = new XQuery("listProductGiftTagValue_default", request);//场合标签组
        List<ProductGiftTagValue> list = baseManager.listObject(productGiftTagValueQuery);
        try {
            for (ProductGiftTagValue productGiftTagValue : list) {
                String group = productGiftTagValue.getGroup();
                if (map.containsKey(group)) {
                    map.get(group).add(productGiftTagValue);
                } else {
                    List<ProductGiftTagValue> productGiftTagValueList = new ArrayList<>();
                    productGiftTagValueList.add(productGiftTagValue);
                    map.put(group, productGiftTagValueList);
                }
            }
        } catch (Exception e) {
        }
        XQuery giftXQuery = new XQuery("listAdvertisement_default", request);
        List advertisementList = baseManager.listObject(giftXQuery);
        model.addAttribute("advertisementList", advertisementList);
        model.addAttribute("map", map);
        return "/mainhome";
    }

    /**
     * 跳转判断
     *
     * @param request
     * @return
     */
    @RequestMapping({"/redirect.do"})
    public String redirect(HttpServletRequest request) {
        String url = request.getRequestURL().toString();
        if (url.equalsIgnoreCase("http://www.efeiyi.com/")) {
            return "forward:/main.do";
        } else {
            //访问mall.efeiyi.com
            return "forward:/mall.do";
        }
    }

    @RequestMapping("/forwardPage.do")
    public String forwardPage(HttpServletRequest request, Model model) {
        try {
            MasterUserTemp temp = new MasterUserTemp();
            temp.setUserName(request.getParameter("username"));
            temp.setLevel(request.getParameter("level"));
            temp.setProjectName(request.getParameter("projectName"));
            temp.setPhoneNum(request.getParameter("phoneNum"));
            baseManager.saveOrUpdate(MasterUserTemp.class.getName(), temp);
            return "redirect:/sign/toRegister.do?result=" + temp.getId();
        } catch (Exception e) {
            e.printStackTrace();
            return "";
        }
    }

    /**
     * 电商首页
     *
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping({"/mall.do"})
    public String mallHome(HttpServletRequest request, Model model) throws Exception {
        //判断是否有需要重定向的页面
        model.addAttribute("homepage", "true");
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

}
