package com.efeiyi.association.controller;

import com.efeiyi.ec.association.model.AssUser;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.util.BssPropertiesConfigure;
import com.ming800.core.util.DESEncryptUtil;
import com.ming800.core.util.StringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.LinkedHashMap;

/**
 * Created by Administrator on 2015/9/23.
 */
@Controller
@RequestMapping("/myUser")
public class MyUserController {

    @Autowired
    BaseManager baseManager;
    @Autowired
    BssPropertiesConfigure configure;

    @RequestMapping("/register.do")
    public ModelAndView register() {

        return new ModelAndView("/user/register");
    }

    @RequestMapping("/registerLogin.do")
    public ModelAndView registerSave(AssUser assUser,HttpServletRequest request,ModelMap modelMap) throws Exception {
        String queryStr = "from AssUser where name = :name";
        LinkedHashMap<String, Object> queryParamMap = new LinkedHashMap<>();
        queryParamMap.put("name", assUser.getName());
        Object obj = baseManager.getUniqueObjectByConditions(queryStr,queryParamMap);
        if(obj == null) {
            String password = assUser.getPassword();
            String encodedPassword = StringUtil.encodePassword(password, "SHA1");
            assUser.setPassword(encodedPassword);
            assUser.setStatus("1");
            assUser.setEnabled(true);
            baseManager.saveOrUpdate(assUser.getClass().getName(), assUser);
            assUser.setPassword(password);
            modelMap.addAttribute("object",assUser);
            return new ModelAndView("/login");
        }else{
            modelMap.addAttribute("errMsg","已被注册！");
            return new ModelAndView("/user/register",modelMap);
        }
    }
}
