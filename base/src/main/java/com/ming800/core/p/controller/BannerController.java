package com.ming800.core.p.controller;

import com.ming800.core.p.model.Banner;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import com.ming800.core.p.model.Banner;
import com.ming800.core.p.service.BannerManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

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

    @Autowired
    private BannerManager bannerManager;


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

    /**
     * 保存
     * @param banner
     * @return
     */
    @RequestMapping("/saveBanner.do")
    @ResponseBody
    public String saveBanner(Banner banner){

        try{
            bannerManager.saveBanner(banner);
        }catch (Exception e){

            e.printStackTrace();
        }
        System.out.print(banner.getId());
        return  banner.getId();
    }

    /**
     * 真删
     * @param banner
     * @return
     */
    @RequestMapping("/deleteBanner.do")
    @ResponseBody
    public String deleteBanner(Banner banner){

        try {

            bannerManager.deleteBanner(banner);

        }catch (Exception e){
            e.printStackTrace();
        }

        return  banner.getId();
    }

    /**
     * 假删
     * @param banner
     * @return
     */
    @RequestMapping("/removeBanner.do")
    @ResponseBody
    public String removeBanner(Banner banner){

        try {

            bannerManager.removeBanner(banner);

        }catch (Exception e){
            e.printStackTrace();
        }

        return  banner.getId();
    }

    @RequestMapping("/updateBannerOrder.do")
    @ResponseBody
    public String updateBannerOrder(Banner banner){

        try{
            bannerManager.updateBannerOrder(banner);
        }catch (Exception e){

            e.printStackTrace();
        }
        return  banner.getId();
    }
}
