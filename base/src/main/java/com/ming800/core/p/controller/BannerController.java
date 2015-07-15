package com.ming800.core.p.controller;

import com.ming800.core.p.model.Banner;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * Created by kayson_yang on 2015/7/13.
 *
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
    @SuppressWarnings("unchecked")
    @RequestMapping("/ba.do")
    public List<Banner> getBannerByGroupId(HttpServletRequest request)throws Exception{
        logger.debug("getBannerByGroupId begin ...");
        XQuery xQuery = new XQuery("listPCBanner_default",request);
        List<Banner> banners = baseManager.listObject(xQuery);
        logger.debug("getBannerByGroupId end ...");
        return banners;
        //return new ModelAndView("/test/index",model);
    }

}
