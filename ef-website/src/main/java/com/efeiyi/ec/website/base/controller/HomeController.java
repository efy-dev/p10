package com.efeiyi.ec.website.base.controller;

import com.efeiyi.ec.organization.model.MyUser;
import com.efeiyi.ec.project.model.Project;
import com.efeiyi.ec.project.model.ProjectCategory;
import com.efeiyi.ec.website.organization.util.AuthorizationUtil;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import com.ming800.core.p.model.Banner;
import com.ming800.core.p.service.BannerManager;
import com.ming800.core.p.service.ObjectRecommendedManager;
import com.ming800.core.util.CookieTool;
import com.ming800.core.util.StringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;

/**
 * Created by Administrator on 2015/8/17.
 */
@Controller
public class HomeController {

    @Autowired
    private ObjectRecommendedManager objectRecommendedManager;

    @Autowired
    private BannerManager bannerManager;

    @Autowired
    private BaseManager baseManager;

    @RequestMapping({"/authenticationTest.do"})
    @ResponseBody
    public String authenticationTest() {
        System.out.println(AuthorizationUtil.isAuthenticated());
        String name = "13693097151";
        LinkedHashMap<String,Object> param = new LinkedHashMap<>();
        param.put("username",name);
        MyUser myUser = (MyUser)baseManager.getUniqueObjectByConditions("select obj from "+MyUser.class.getName()+" obj where obj.username=:username",param);
        String password = "123123";
        AuthenticationManager am = new SampleAuthenticationManager();
        try {
            Authentication request = new UsernamePasswordAuthenticationToken(myUser, StringUtil.encodePassword("123123", "SHA"));
            Authentication result = am.authenticate(request);
            Object obj = result.getPrincipal();
            SecurityContextHolder.getContext().setAuthentication(result);
        } catch (AuthenticationException e) {
            System.out.println("Authentication failed: " + e.getMessage());
        }
        return AuthorizationUtil.getMyUser().getUsername();
    }

    private static class SampleAuthenticationManager implements AuthenticationManager {
        static final List<GrantedAuthority> AUTHORITIES = new ArrayList<GrantedAuthority>();

        static {
            AUTHORITIES.add(new SimpleGrantedAuthority("ROLE_USER"));
        }

        public Authentication authenticate(Authentication auth) throws AuthenticationException {
                return new UsernamePasswordAuthenticationToken(auth.getPrincipal(),
                        auth.getCredentials(), AUTHORITIES);
        }
    }


    @RequestMapping({"/logoutHandler"})
    public String logoutHandler(HttpServletResponse response){
        //只有手动退出的时候清除cookie
        CookieTool.addCookie(response,"userinfo","",1,".efeiyi.com");
        return "redirect:/";
    }

    @RequestMapping({"/home.do"})
    public String home(HttpServletRequest request, Model model) throws Exception {

        //判断是否有需要重定向的页面
        String redirectUrl = request.getParameter("redirect");
        if (redirectUrl != null) {
            return "redirect:" + redirectUrl;
        }


        List<Object> projectList = objectRecommendedManager.getRecommendedList("categoryRecommended");
        HashMap<String, List> map = new HashMap<>();
        for (Object object : projectList) {
            XQuery xQuery = new XQuery("listProjectCategoryProductModel_default", request);
            xQuery.put("projectCategory_id", ((ProjectCategory) object).getId());
            map.put(((ProjectCategory) object).getId(), baseManager.listObject(xQuery));
        }
        model.addAttribute("recommendMap", map);
        model.addAttribute("projectList", projectList);

        //首页轮播图
        List<Object> bannerList = bannerManager.getBannerList("ec.home.banner");
        model.addAttribute("bannerList", bannerList);

        //传承人
        List<Object> masterList = objectRecommendedManager.getRecommendedList("ec.masterRecommended");
        model.addAttribute("masterList", masterList);
        model.addAttribute("sign", "000");

        //品牌故事
        XQuery subjectQuery = new XQuery("listAdvertisement_default", request);
        List<Object> subjectList = baseManager.listObject(subjectQuery);
        if (subjectList != null && subjectList.size() > 0) {
            model.addAttribute("advertisement", subjectList);
        }

        return "/home";
    }
    @RequestMapping({"/home1.do"})
    public String home1(HttpServletRequest request, Model model) throws Exception {

        //判断是否有需要重定向的页面
        String redirectUrl = request.getParameter("redirect");
        if (redirectUrl != null) {
            return "redirect:" + redirectUrl;
        }
        List<Object> categoryList = objectRecommendedManager.getRecommendedList("categoryRecommended");
        HashMap<String, List> map = new HashMap<>();
        HashMap<String, List> projectMap = new HashMap<>();
        for (Object object : categoryList) {
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

        //首页轮播图
        List<Object> bannerList = bannerManager.getBannerList("ec.home.banner");
        model.addAttribute("bannerList", bannerList);

        //传承人
        List<Object> masterList = objectRecommendedManager.getRecommendedList("ec.masterRecommended");
        model.addAttribute("masterList", masterList);
        model.addAttribute("sign", "000");

        //广告区域 营销活动 热卖商品 广告区
        XQuery subjectQuery = new XQuery("listAdvertisement_default", request);
        XQuery subjectQuery2 = new XQuery("listAdvertisement_default2", request);
        XQuery subjectQuery3 = new XQuery("listAdvertisement_default3", request);
        List<Object> subjectList = baseManager.listObject(subjectQuery);
        List<Object> subjectList2 = baseManager.listObject(subjectQuery2);
        List<Object> subjectList3 = baseManager.listObject(subjectQuery3);
        //热卖商品
        if (subjectList != null && subjectList.size() > 0) {
            model.addAttribute("advertisement", subjectList);
        }
        if (subjectList2 != null && subjectList2.size() > 0) {
            model.addAttribute("advertisement2", subjectList2);
        }
        if (subjectList3 != null && subjectList3.size() > 0) {
            model.addAttribute("advertisement3", subjectList3);
        }
        model.addAttribute("projectMap", projectMap);
        return "/home";
    }

    @RequestMapping({"/productCategory.do"})
    public String listProductCategory(HttpServletRequest request, Model model) throws Exception {
        HashMap<String, List> projectMap = new HashMap<>();
        XQuery xQuery = new XQuery("listProjectCategory_default", request);
        xQuery.setSortHql("");
        xQuery.updateHql();
        List<Object> categoryList = baseManager.listObject(xQuery);
        for (Object category : categoryList) {
            XQuery projectQuery = new XQuery("listProject_default", request);
            projectQuery.put("projectCategory_id", ((ProjectCategory) category).getId());
            projectQuery.setSortHql("");
            projectQuery.updateHql();
            projectMap.put(((ProjectCategory) category).getId(), baseManager.listObject(projectQuery));
        }
        model.addAttribute("categoryList", categoryList);
        model.addAttribute("projectMap", projectMap);
        return "/common/productCategory";
    }

    @RequestMapping({"/news"})
    public String listNews() {

        return "/common/news";

    }

    @RequestMapping({"/500"})
    public String show500() {
        return "/common/500";
    }

    @RequestMapping({"/404"})
    public String show404() {
        return "/common/404";
    }


//    @RequestMapping({"/test/404"})
//    public String show404Test(){
//        return "/common/test";
//    }
//
//    @RequestMapping({"/test/500"})
//    public String show5004Test(){
//       throw new RuntimeException();
//    }


    @RequestMapping({"/test.do"})
    public String test() {
        return "/test";
    }


}
