package com.efeiyi.ec.wiki.organization.controller;

import com.alibaba.fastjson.JSONObject;
import com.efeiyi.ec.master.model.MasterFollowed;
import com.efeiyi.ec.organization.model.MyUser;
import com.ming800.core.base.controller.BaseController;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.LinkedHashMap;

/**
 * Created by Administrator on 2015/12/22.
 *
 */
@Controller
public class SigninController extends BaseController {
    private static Logger logger = Logger.getLogger(SigninController.class);
    private static final String SQL_USER_GET ="from MyUser WHERE username=? AND status='1'";
    @RequestMapping(value ="/wiki/login.do", method = RequestMethod.POST)
    @ResponseBody
    public boolean login(HttpServletRequest request) throws Exception {
        boolean flag = false;
        JSONObject jsonObj = (JSONObject)JSONObject.parse(request.getParameter("json").toString());
        LinkedHashMap<String, Object> map = new LinkedHashMap<String, Object>();
        map.put("username", jsonObj.getString("username"));
        MyUser user = (MyUser) baseManager.getUniqueObjectByConditions(SQL_USER_GET, map);
        if(user.getPassword().equals(jsonObj.getString("password"))){
            flag=true;
        }
        return flag;
    }
}
