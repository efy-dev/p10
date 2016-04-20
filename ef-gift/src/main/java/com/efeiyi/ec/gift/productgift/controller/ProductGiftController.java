package com.efeiyi.ec.gift.productgift.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

/**
 * Created by Administrator on 2016/4/19.
 */
@Controller
public class ProductGiftController {

    @RequestMapping({"get.do"})
    public String testAspect(HttpServletRequest request) throws Exception{
        return "";
    }
}
