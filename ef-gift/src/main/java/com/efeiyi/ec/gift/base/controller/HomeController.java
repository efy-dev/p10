package com.efeiyi.ec.gift.base.controller;

import com.efeiyi.ec.gift.base.util.AuthorizationUtil;
import com.efeiyi.ec.gift.model.ProductGiftTagValue;
import com.efeiyi.ec.organization.model.MyUser;
import com.efeiyi.ec.organization.model.User;
import com.efeiyi.ec.product.model.Subject;
import com.efeiyi.ec.project.model.ProjectCategory;
import com.efeiyi.ec.purchase.model.PurchaseOrder;
import com.efeiyi.ec.purchase.model.PurchaseOrderPayment;
import com.efeiyi.ec.zero.promotion.model.PromotionPlan;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import com.ming800.core.p.model.Banner;
import com.ming800.core.p.service.BannerManager;
import com.ming800.core.p.service.ObjectRecommendedManager;
import com.ming800.core.util.CookieTool;
import com.ming800.core.util.StringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
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
import java.net.URLDecoder;
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


    //首先需要判断是否是微信浏览器，如果是微信浏览器，需要通过微信接口获得unionid 然后判断该用户是否注册了efeiyi用户，拿到用户数据后自动登陆，然后返回页面
    @RequestMapping({"/authenticationTest.do"})
    @ResponseBody
    public String authenticationTest() {
        System.out.println(AuthorizationUtil.isAuthenticated());
        String name = "13693097151";
        LinkedHashMap<String, Object> param = new LinkedHashMap<>();
        param.put("username", name);
        MyUser myUser = (MyUser) baseManager.getUniqueObjectByConditions("select obj from " + MyUser.class.getName() + " obj where obj.username=:username", param);
        AuthenticationManager am = new SampleAuthenticationManager();
        try {
            Authentication request = new UsernamePasswordAuthenticationToken(myUser, StringUtil.encodePassword("1231", "SHA"));
            Authentication result = am.authenticate(request);
            SecurityContextHolder.getContext().setAuthentication(result);
        } catch (AuthenticationException e) {
            System.out.println("Authentication failed: " + e.getMessage());
        }
        return AuthorizationUtil.getMyUser().getUsername();
    }

    private static class SampleAuthenticationManager implements AuthenticationManager {
        static final List<GrantedAuthority> AUTHORITIES = new ArrayList<>();

        static {
            AUTHORITIES.add(new SimpleGrantedAuthority("ROLE_USER"));
        }

        public Authentication authenticate(Authentication auth) throws AuthenticationException {
            return new UsernamePasswordAuthenticationToken(auth.getPrincipal(),
                    auth.getCredentials(), AUTHORITIES);
        }
    }


    @RequestMapping({"/logoutHandler"})
    public String logoutHandler(HttpServletResponse response) {
        //只有手动退出的时候清除cookie
        CookieTool.addCookie(response, "userinfo", "", 1, ".efeiyi.com");
        return "redirect:/";
    }

    @RequestMapping({"/home.do"})
    public String home1(HttpServletRequest request, Model model) throws Exception {
        Map<String, List<ProductGiftTagValue>> map = new HashMap<>();
        //获取首页轮播图
        List<Banner> bannerList = bannerManager.getBannerList("gift.homeProductGift");
        XQuery productGiftTagValueQuery = new XQuery("listProductGiftTagValue_default", request);//场合标签组

        List<ProductGiftTagValue> list = baseManager.listObject(productGiftTagValueQuery);
        try {
            for(ProductGiftTagValue productGiftTagValue:list){
                String group = productGiftTagValue.getGroup();
                if (map.containsKey(group)){
                    map.get(group).add(productGiftTagValue);
                }else {
                    List<ProductGiftTagValue> productGiftTagValueList = new ArrayList<>();
                    productGiftTagValueList.add(productGiftTagValue);
                    map.put(group,productGiftTagValueList);
                }
            }
        }catch (Exception e){}
        XQuery xQuery = new XQuery("listAdvertisement_default", request);
        List advertisementList = baseManager.listObject(xQuery);
        List<Subject> subjectList = objectRecommendedManager.getRecommendedList("gift.productGiftRecommended");

        model.addAttribute("map",map);
        model.addAttribute("bannerList", bannerList);
        model.addAttribute("advertisementList", advertisementList);
        model.addAttribute("subjectList", subjectList);
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
            LinkedHashMap<String, Object> queryParamMap = new LinkedHashMap<>();
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
    @RequestMapping({"/count.do"})
    public String count(HttpServletRequest request,HttpServletResponse response,Model model) throws ParseException {
        Date dateNow = new Date();
        SimpleDateFormat formatter = new SimpleDateFormat( "yyyy-MM-dd");
        String dateStr = formatter.format(dateNow);
        String dateParam = dateStr+"%";
        Date date = formatter.parse(dateStr);
        List<PurchaseOrder> purchaseOrderList = getPurchaseOrderList(dateParam);
        List<PurchaseOrderPayment> purchaseOrderPaymentList = getPurchaseOrderPaymentList(dateParam);
        List<User> userList = getRegisterList(dateParam);
        model.addAttribute("registerCount", userList.size());
        model.addAttribute("purchaseOrderCount",purchaseOrderList.size());
        model.addAttribute("purchaserPaymentCount",purchaseOrderPaymentList.size());
        model.addAttribute("date",dateStr);
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(date);
        calendar.add(Calendar.DAY_OF_MONTH, -1);
        Date yesterday = calendar.getTime();
        dateStr = formatter.format(yesterday);
        dateParam = dateStr+"%";
        purchaseOrderList = getPurchaseOrderList(dateParam);
        purchaseOrderPaymentList = getPurchaseOrderPaymentList(dateParam);
        userList = getRegisterList(dateParam);
        model.addAttribute("yesterday",dateStr);
        model.addAttribute("yesterdayRegisterCount",userList.size());
        model.addAttribute("yesterdayPurchaseOrderCount",purchaseOrderList.size());
        model.addAttribute("yesterdayPurchasePaymentCount",purchaseOrderPaymentList.size());
        return "/count";
    }
    private  List getPurchaseOrderList(String str){
        String query = "FROM PurchaseOrder p WHERE p.createDatetime like '"+str+"' AND p.status != 0";
        List<PurchaseOrder> purchaseOrderList = baseManager.listObject(query);
        return purchaseOrderList;
    }
    private List getRegisterList(String str){
        String query = "FROM User u WHERE u.createDatetime like '"+str+"' AND u.status != 0";
        List<User> userList = baseManager.listObject(query);
        return userList;
    }
    private List getPurchaseOrderPaymentList(String str){
        String query = "FROM PurchaseOrderPayment p WHERE p.createDateTime like '"+str+"' AND p.status = 2";
        List<PurchaseOrderPayment> list = baseManager.listObject(query);
        return list;

    }

}
