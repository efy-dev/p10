package com.efeiyi.ec.website.Recommend.controller;

import com.ming800.core.base.service.BaseManager;
import com.ming800.core.p.service.ObjectRecommendedManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

/**
 * Created by Administrator on 2015/8/6.
 */
@Controller
@RequestMapping("/recommended")
public class recommendController {
    @Autowired
    private BaseManager baseManager;

    @Autowired
    private ObjectRecommendedManager objectRecommendedManager;
    @RequestMapping("/getproduct.do")
    public ModelAndView getProductRecommended(ModelMap modelMap) throws Exception{
        modelMap.put("product",objectRecommendedManager.getRecommendedList("productRecommended"));
        return  new ModelAndView("/prodcutRecommended");

    }

}
