package com.efeiyi.ec.system.organization.controller;

import com.efeiyi.ec.organization.model.Permission;
import com.efeiyi.ec.organization.model.Role;
import com.ming800.core.base.controller.BaseController;
import com.ming800.core.does.model.Module;
import com.ming800.core.does.service.ModuleManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import java.util.HashMap;
import java.util.Map;

/**
 * Created by IntelliJ IDEA.
 * User: ming
 * Date: 12-10-15
 * Time: 下午4:56
 * To change this template use File | Settings | File Templates.
 */

@Controller
@RequestMapping("/sign")
public class SIgnController extends BaseController {

    /**
     * 判断注册还是登陆
     * 跳转注册页面
     */
    @RequestMapping("/toRegister.do")
    public String forward(String result) {

            return "/register";
    }

}
