package com.efeiyi.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/main")
public class MainController {

    @RequestMapping("/do1")
    public String do1(HttpServletRequest request) throws Exception {

        return "/pc/20150806";
    }
    @RequestMapping("/do2")
    public String do2(HttpServletRequest request) throws Exception {

        return "/pc/20150729";
    }
    @RequestMapping("/do3")
    public String do3(HttpServletRequest request) throws Exception {

        return "/pc/20150728";
    }
    @RequestMapping("/do4")
    public String do4(HttpServletRequest request) throws Exception {

        return "/pc/20150611";
    }
    @RequestMapping("/do5")
    public String do5(HttpServletRequest request) throws Exception {

        return "/pc/2015060902";
    }
    @RequestMapping("/do6")
    public String do6(HttpServletRequest request) throws Exception {

        return "/pc/20150609";
    }
    @RequestMapping("/do7")
    public String do7(HttpServletRequest request) throws Exception {

        return "/pc/platform";
    }
    @RequestMapping("/helpCenter")
    public String helpCenter(HttpServletRequest request) throws Exception {

        return "/pc/helpCenter";
    }
    @RequestMapping("/welcome")
    public String welcome(HttpServletRequest request) throws Exception {

        return "/pc/welcome";
    }
    @RequestMapping("/aboutUs")
    public String aboutUs(HttpServletRequest request) throws Exception {

        return "/pc/aboutUs";
    }
    @RequestMapping("/contactUs")
    public String contactUs(HttpServletRequest request) throws Exception {

        return "/pc/contactUs";
    }

}