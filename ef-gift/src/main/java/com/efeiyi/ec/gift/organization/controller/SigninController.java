package com.efeiyi.ec.gift.organization.controller;

/**
 * Created by Administrator on 2014/11/13.
 */

import com.efeiyi.ec.gift.base.util.AuthorizationUtil;
import com.efeiyi.ec.organization.model.MyUser;
import com.efeiyi.ec.purchase.model.PurchaseOrder;
import com.ming800.core.base.controller.BaseController;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import com.ming800.core.p.service.AutoSerialManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.net.URLEncoder;


/**
 * Created by IntelliJ IDEA.
 * User: ming
 * Date: 12-10-15
 * Time: ����4:56
 * To change this template use File | Settings | File Templates.
 */

@Controller
public class SigninController extends BaseController {
    @Autowired
    private BaseManager baseManager;
    @Autowired
    private AutoSerialManager autoSerialManager;

//    @RequestMapping({"userServiceTest.do"})
//    @ResponseBody
//    public String userServiceTest() throws Exception {
//        UserManager userManager = (UserManager) ContextUtils.getBean("userServiceProxy");
//        MyUser myUser = userManager.getUserByUserId(AuthorizationUtil.getMyUser().getId());
//        return myUser.getUsername();
//    }
//
//    @RequestMapping({"addressServiceTest.do"})
//    @ResponseBody
//    public List<ConsumerAddress> addressServiceTest() throws Exception {
//        AddressManager addressManager = (AddressManager) ContextUtils.getBean("addressServiceProxy");
//        List<ConsumerAddress> consumerAddressList = addressManager.listConsumerAddressByUserId(AuthorizationUtil.getMyUser().getId());
//        return consumerAddressList;
//    }

    @RequestMapping({"testAspect.do"})
    @ResponseBody
    public String testAspect(HttpServletRequest request) throws Exception {
        String order = "ie86ug7qxnujeidw";
        String userName = "ih33g5t18ge151fg";
//        String hql = "select obj from " + PurchaseOrder.class.getName() + " obj where obj.user.id=:username";
//        LinkedHashMap<String, Object> param = new LinkedHashMap<>();
//        param.put("username", userName);
//        baseManager.listObject(hql, param);
        PurchaseOrder purchaseOrder = (PurchaseOrder) baseManager.getObject(PurchaseOrder.class.getName(), order);
        XQuery xQuery = new XQuery("listPurchaseOrder_byUser", request);
        xQuery.put("user_id", userName);
        baseManager.listObject(xQuery);
        return "";
    }


    @RequestMapping("/sso.do")
    public String forward(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String redirect = request.getParameter("callUrl");
        if (redirect != null) {
            return "redirect:http://" + redirect;
        }
//        response.sendRedirect(request.getContextPath() + "/sso2.do");
        return "redirect:/sso2.do";
    }


    @RequestMapping("/sso2.do")
    public void forward2(HttpServletRequest request, HttpServletResponse response) throws IOException {
        //将登陆的用户的用户信息保存到cookie中
        MyUser myUser = AuthorizationUtil.getMyUser();
        response.sendRedirect(request.getContextPath() + "/");
    }



    @RequestMapping("/registerSuccess/{couponAmount}")
    public String successPage(@PathVariable String couponAmount, HttpServletRequest request, Model model) {
        model.addAttribute("couponAmount", couponAmount);
        return "/registerSuccess";
    }

    @RequestMapping({"/wx/userInfo"})
    public String wxPay(HttpServletRequest request) throws Exception {
        String dataKey = "unionid";
        String callback = request.getServerName() + ":" + request.getServerPort() + "/wx/bind";
        callback = URLEncoder.encode(callback, "UTF-8");
        String redirect = "http://mall.efeiyi.com/wx/getInfo.do?callback=" + callback + "&dataKey=" + dataKey;
        return "redirect:" + redirect;
    }

    @RequestMapping({"/wx/bind"})
    public String getWxOpenId(HttpServletRequest request, Model model) throws Exception {
        String unionid = request.getParameter("unionid");
        model.addAttribute("unionid", unionid);
        return "/wxRedirect";
    }


}
