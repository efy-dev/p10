package com.efeiyi.ec.system.basic.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;


/**
 * Created by Administrator on 2015/7/21.
 */

@Controller
@RequestMapping("/Img")
public class ImgHandler  {

    @RequestMapping("/imgUrl.do")
    public ModelAndView getImg(String imgUrl,ModelMap modelMap){
       modelMap.put("imgUrl",imgUrl);
       return  new ModelAndView("/imgView");
 }
}
