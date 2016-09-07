package com.efeiyi.ec.system.yuanqu.controller;

import net.sf.json.JSON;
import net.sf.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartRequest;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Created by Administrator on 2016/9/6 0006.
 */
@Controller
@RequestMapping({"/yuanqu"})
public class OffLineTenantController {

    @RequestMapping({"/tenantForm"})
    public String tenantForm() {
        return "/yuanqu/tenantForm";
    }

    @RequestMapping({"/submit"})
    @ResponseBody
    public Object testSubmit(HttpServletRequest request, HttpServletResponse response, MultipartRequest multipartRequest) {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("email", email);
        jsonObject.put("password", password);
        return jsonObject;
    }

}
