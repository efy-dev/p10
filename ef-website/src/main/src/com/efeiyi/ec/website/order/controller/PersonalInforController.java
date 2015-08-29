package com.efeiyi.ec.website.order.controller;

import com.efeiyi.ec.organization.model.BigUser;
import com.efeiyi.ec.website.organization.util.AuthorizationUtil;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XSaveOrUpdate;
import com.ming800.core.util.StringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;

/**
 * Created by Administrator on 2015/8/19.
 */
@Controller
@RequestMapping("/myEfeiyi")
public class PersonalInforController {
    @Autowired
    private BaseManager baseManager;
    @RequestMapping({"updatePersonalInfo.do"})
    public String  updatePersonalInfo(HttpServletRequest request)throws Exception{
        XSaveOrUpdate xSaveOrUpdate =new XSaveOrUpdate("saveOrUpdateInfo",request);
        baseManager.saveOrUpdate(xSaveOrUpdate);

        return "redirect:/myEfeiyi/personalInfo.do";

    }
    @RequestMapping({"personalInfo.do"})
   public String getPersonalInfo(ModelMap modelMap){
       String id = AuthorizationUtil.getMyUser().getId();
       BigUser user = (BigUser) baseManager.getObject(BigUser.class.getName(), id);

        modelMap.addAttribute("user", user);
        return "/purchaseOrder/personalInfoView";
    }

    @RequestMapping({"personalInfoOfMobile.do"})
    public String getPersonalInfoOfMobile(ModelMap modelMap){
        String id = AuthorizationUtil.getMyUser().getId();
        BigUser user = (BigUser) baseManager.getObject(BigUser.class.getName(), id);

        modelMap.addAttribute("user", user);
        return "/purchaseOrder/updateUser";
    }
    /**
     * 密码修改
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping({"updatePassword.do"})
    public String updatePassword(HttpServletRequest request) throws Exception {
        String contion = request.getParameter("pwd");
        String password= StringUtil.encodePassword(contion, "SHA");
        XSaveOrUpdate xSaveOrUpdate = new XSaveOrUpdate("saveOrUpdatePassword",request);
        xSaveOrUpdate.getParamMap().put("password",password);
        baseManager.saveOrUpdate(xSaveOrUpdate);
        return "redirect:/login";

    }
    @RequestMapping({"getPassword.do"})
    public String getPassword(HttpServletRequest request,ModelMap modelMap){

        String id = AuthorizationUtil.getMyUser().getId();
        BigUser user = (BigUser) baseManager.getObject(BigUser.class.getName(), id);

        modelMap.addAttribute("user", user);
        return "/purchaseOrder/securityAccount";
    }

    /**
     * 检查原有密码
     * @param request
     * @return
     */
    @RequestMapping({"checkPassword.do"})
    @ResponseBody
     public boolean checkPassword(HttpServletRequest request){
        String mm=request.getParameter("password");
        String password= StringUtil.encodePassword(mm, "SHA");
        String id = AuthorizationUtil.getMyUser().getId();
        BigUser user = (BigUser) baseManager.getObject(BigUser.class.getName(), id);
        if(password.equals(user.getPassword())){
            return true;
        }else{
            return false;
        }
    }

}
