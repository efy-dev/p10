package com.efeiyi.ec.system.basic.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Created by Administrator on 2015/7/13.
 */
@Controller
public class ManageController {

    @RequestMapping({"main.do"})
    public String main(){
        return "/main";
    }

}
