package com.ming800.core.base.controller;

import com.ming800.core.base.model.Banner;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * Created by kayson_yang on 2015/7/13.
 */

@Controller
@RequestMapping("/banner")
public class BannerController {
    private static Logger logger = Logger.getLogger(BannerController.class);
    @Autowired
    private BaseManager baseManager;



    /**
     * 通过模块ID获取相关模块的轮播图（状态为可用）的所有对象
     */
    @RequestMapping("/ba.do")
    public ModelAndView getBannerByModlueId(ModelMap model,HttpServletRequest request)throws Exception{
        List<Banner> banners = null;
        XQuery xQuery = null;
        try {
            xQuery = new XQuery("listPCBanner_default",request);
        } catch (Exception e) {
            logger.error("create xQuery error in BannerController.getBannerByModlueId()...");
            e.printStackTrace();
        }
        banners = baseManager.listObject(xQuery);
        if (banners==null || banners.size()<=0){
            logger.info("no banners be found,plase confirm again!");
            throw new Exception("no data be found");
        }else{
            model.addAttribute("banners",banners);
        }

        return new ModelAndView("/test/index",model);
    }

}
