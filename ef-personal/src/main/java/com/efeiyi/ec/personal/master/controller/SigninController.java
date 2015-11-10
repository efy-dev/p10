package com.efeiyi.ec.personal.master.controller;

/**
 * Created by Administrator on 2014/11/13.
 */

import com.efeiyi.ec.organization.model.BigUser;
import com.efeiyi.ec.organization.model.Consumer;
import com.efeiyi.ec.organization.model.User;
import com.efeiyi.ec.personal.AuthorizationUtil;
import com.efeiyi.ec.purchase.model.Cart;


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
}

