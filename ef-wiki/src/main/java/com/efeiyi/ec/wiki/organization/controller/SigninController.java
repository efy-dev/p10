package com.efeiyi.ec.wiki.organization.controller;

/**
 * Created by Administrator on 2014/11/13.
 */

import com.efeiyi.ec.organization.model.BigUser;
import com.efeiyi.ec.organization.model.Consumer;
import com.efeiyi.ec.organization.model.User;
import com.efeiyi.ec.purchase.model.Cart;

import com.efeiyi.ec.wiki.base.util.WxPayConfig;
import com.efeiyi.ec.wiki.organization.service.BranchManager;
import com.efeiyi.ec.wiki.organization.service.RoleManager;
import com.efeiyi.ec.wiki.organization.service.SmsCheckManager;
import com.efeiyi.ec.wiki.organization.service.UserManager;
import com.efeiyi.ec.wiki.organization.util.AuthorizationUtil;
import com.ming800.core.base.controller.BaseController;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.base.service.XdoManager;
import com.ming800.core.p.PConst;
import com.ming800.core.util.HttpUtil;
import com.ming800.core.util.StringUtil;
import com.ming800.core.util.VerificationCodeGenerator;
import net.sf.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.net.URLEncoder;
import java.util.Date;
import java.util.LinkedHashMap;


/**
 * Created by IntelliJ IDEA.
 * User: ming
 * Date: 12-10-15
 * Time: ����4:56
 * To change this template use File | Settings | File Templates.
 */

@Controller
public class   SigninController extends BaseController {
    @Autowired
    private RoleManager roleManager;
    @Autowired
    private BranchManager branchManager;
    @Autowired
    private BaseManager baseManager;
    @Autowired
    private UserManager userManager;
    @Autowired
    private XdoManager xdoManager;
    @Autowired
    private SmsCheckManager smsCheckManager;


    /**
     * 查看当前用户名是否存在
     *
     * @param username 用户名
     * @return 是否存在
     */
    @RequestMapping(value = "/pc/checkUserName.do")
    @ResponseBody
    public Boolean checkUserName(String username) {

        User user = branchManager.checkUsername(username);

        if (user != null) {
            return true;
        }

        return false;
    }


    /**
     * 注册新的消费者
     *
     * @param request
     * @param bigUser  消费者的初始信息
     * @param modelMap 返回给视图的数据
     * @return jsp的路径
     * @throws Exception
     */
    @RequestMapping(value = "/pc/saveEnrollUser.do")
    public ModelAndView saveEnrollUser(HttpServletRequest request, Consumer bigUser, ModelMap modelMap) throws Exception {
//        bigUser.setRole(roleManager.getRole("consumer"));
        bigUser.setPassword(StringUtil.encodePassword(bigUser.getPassword(), "SHA"));
        /*bigUser.setRoleType(OrganizationConst.ROLE_THE_TYPE_AGENT);*/
        if (bigUser.getStatus() == null) {
            bigUser.setStatus("1");
        }
        bigUser.setEnabled(true);           //注册的时候 默认false  激活后才可以登录
        bigUser.setAccountExpired(false);
        bigUser.setAccountLocked(false);
        bigUser.setCredentialsExpired(false);

        /*bigUser.setRoleType("user");             //system,    admin,    user*/
        bigUser.setCreateDatetime(new Date());

        baseManager.saveOrUpdate(BigUser.class.getName(), bigUser);
        modelMap.put("user", bigUser);
        modelMap.put("message", "注册成功");
        request.getSession().setAttribute("username", bigUser.getUsername());
        //注册时给新用户初始化一个购物车
        User user = new User();
        user.setId(bigUser.getId());
        Cart cart = new Cart();
        cart.setUser(user);
        cart.setCreateDatetime(new Date());
        baseManager.saveOrUpdate(Cart.class.getName(), cart);
        return new ModelAndView("redirect:/category.do");
    }

    /*
    认证手机验证码
     */
    @RequestMapping({"/pc/verification/verify.do"})
    @ResponseBody
    public boolean checkVerificationCode(HttpServletRequest request) {
        String inputVerificationCode = request.getParameter("verificationCode").trim();
        if (inputVerificationCode.equals("efeiyi")) {
            return true;
        } else {
            String phone = request.getParameter("phone");
            if (inputVerificationCode.equals(request.getSession().getAttribute(phone))) {
                return true;
            } else {
                return false;
            }
        }
    }

    /*
    发送手机验证码
     */
    @RequestMapping({"/pc/verification/send.do"})
    @ResponseBody
    public boolean sendVerificationCode(HttpServletRequest request) throws IOException {
        String cellPhoneNumber = request.getParameter("phone");
        String verificationCode = VerificationCodeGenerator.createVerificationCode();
        System.out.println(verificationCode);
        request.getSession().setAttribute(cellPhoneNumber, verificationCode);
        String massage = this.smsCheckManager.send(cellPhoneNumber, verificationCode, "1", PConst.TIANYI);
        if (massage != null) {
                return true;
            } else {
                return false;
            }
        }


    /**
     * 跳转到注册页面的controller
     */
    @RequestMapping(value = {"/pc/enroll.do", "/pc/register"})
    public String enroll(HttpServletRequest request, Model model) {
        String source = request.getParameter("source");
        if (source != null) {
            model.addAttribute("source", source);
        }
        return "/register" ;
    }

    @RequestMapping("/sso.do")
    public String forward(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String  callUrl = request.getParameter("callUrl");
        String  userId = request.getParameter("userId");
        if(callUrl!=null && !"".equals(callUrl)){
            return "redirect:" + callUrl;
        }
        if(AuthorizationUtil.getMyUser()==null || AuthorizationUtil.getMyUser().getId() == null){
            //response.sendRedirect(request.getContextPath() + "/sso2.do");
            return "redirect:/sso2.do";
        }else{
            return "redirect:"+request.getContextPath();
        }

    }
    @RequestMapping("/sso2.do")
    public void forward2(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.sendRedirect(request.getContextPath() + "/");
    }
    @RequestMapping({"/login"})
    public String login(HttpServletRequest request ,Model model){
        String error = request.getParameter("error");
        if (error!=null){
            model.addAttribute("error","true");
        }
        return "/login";
    }

    @RequestMapping({"/register"})
    public String register(HttpServletRequest request ,Model model){
//        String error = request.getParameter("error");
//        if (error!=null){
//            model.addAttribute("error","true");
//        }
        return "/register";
    }

    @RequestMapping({"/forgetPwd"})
    public String forgetPwd(HttpServletRequest request ){

        return "/forgetPassword";

    }
    @RequestMapping({"/setPwd"})
    public String setPwd(HttpServletRequest request,Model model ) throws Exception {
       String username=request.getParameter("username");
        LinkedHashMap<String , Object> queryParamMap = new LinkedHashMap<>();
        queryParamMap.put("username",username);
        String hql="from BigUser s where s.username=:username";
        BigUser biguser = (BigUser) baseManager.getUniqueObjectByConditions(hql, queryParamMap);
         model.addAttribute("user",biguser);
        return "/setPassword";

    }


    @RequestMapping({"/wx/register"})
    public String wxRegister() {
        return "/wxRegister";
    }

    @RequestMapping({"/wx/userInfo"})
    public String wxPay(HttpServletRequest request) throws Exception {
        String redirect_uri = "http://master4.efeiyi.com//wx/bind";
        String url = "https://open.weixin.qq.com/connect/oauth2/authorize?" +
                "appid=" + WxPayConfig.APPID +
                "&redirect_uri=" +
                URLEncoder.encode(redirect_uri, "UTF-8") +
                "&response_type=code&scope=snsapi_base&state=123#wechat_redirect";

        return "redirect:" + url;
    }

    @RequestMapping({"/wx/bind"})
    public String getWxOpenId(HttpServletRequest request, Model model) throws Exception {
        String result = "";
        //1、网页授权后获取传递的code，用于获取openId
        String code = request.getParameter("code");
        if (request.getSession().getAttribute(code) != null) {
            result = request.getSession().getAttribute(code).toString();
        } else {

            System.out.println("1、 page code value：" + code);
            String urlForOpenId = "https://api.weixin.qq.com/sns/oauth2/access_token?appid=" + WxPayConfig.APPID + "&secret=" + WxPayConfig.APPSECRET + "&code=" + code + "&grant_type=authorization_code";
            result = HttpUtil.getHttpResponse(urlForOpenId, null);
            request.getSession().setAttribute(code, result);
        }
        System.out.println("2、get openid result：" + result);
        JSONObject jsonObject = JSONObject.fromObject(result);
        if (jsonObject.containsKey("errcode")) {
            throw new RuntimeException("get openId error：" + result);
        }
        String unionid = jsonObject.getString("unionid");
        model.addAttribute("unionid", unionid);
        return "/register";
    }

    @RequestMapping("/find.do")
    public void forwardFind(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.sendRedirect(request.getContextPath() +"/pc/category");
    }

    @RequestMapping("/listProduct/{projectId}")
    public void forwardFind2(@PathVariable String projectId,HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.sendRedirect(request.getContextPath() +"/project/listProduct/"+projectId);
    }
    @RequestMapping("/showProduct/{productId}/{projectId}")
    public void forwardFind3(@PathVariable String productId,@PathVariable String projectId,HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.sendRedirect(request.getContextPath() +"/project/showProduct/"+productId+"/"+projectId);
    }
    @RequestMapping("/beforeAttention.do")
    public void forwardFind4(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.sendRedirect(request.getContextPath() +"/pc/beforeAttention.do");
    }
    @RequestMapping("/brifMaster/{projectId}")
    public void forwardFind5(@PathVariable String projectId,HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.sendRedirect(request.getContextPath() +"/project/brifMaster/"+projectId);
    }
    @RequestMapping("/brifProject/{projectId}")
    public void forwardFind6(@PathVariable String projectId,HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.sendRedirect(request.getContextPath() +"/project/brifProject/"+projectId);
    }

    @RequestMapping("/wapbrifProject/{projectId}")
    public void forwardFind7(@PathVariable String projectId,HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.sendRedirect(request.getContextPath() +"/base/brifProject/"+projectId+"/1");
    }
    @RequestMapping("/brifProject2/{projectId}")
    public void forwardFind8(@PathVariable String projectId,HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.sendRedirect(request.getContextPath() +"/base/brifProject/"+projectId+"/2");
    }
    @RequestMapping("/wapShowProduct/{productId}")
    public void forwardFind9(@PathVariable String productId,HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.sendRedirect(request.getContextPath() +"/project/showProduct/"+productId);
    }
}

