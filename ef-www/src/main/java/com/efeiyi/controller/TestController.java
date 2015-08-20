package com.efeiyi.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

@Controller
public class TestController {

    @RequestMapping("/home.do")
    public String listTenantInfo(HttpServletRequest request) throws Exception {

        return "/index";
    }

}