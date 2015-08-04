package com.efeiyi.ec.system.master.controller;

import com.efeiyi.ec.master.model.MasterRecommended;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import com.ming800.core.p.model.Banner;
import com.ming800.core.p.model.ObjectRecommended;
import com.ming800.core.p.service.ObjectRecommendedManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * Created by kayson_yang on 2015/7/13.
 *
 */

@Controller
@RequestMapping("/Recommended")
public class RecommendedController {
    private static Logger logger = Logger.getLogger(RecommendedController.class);
    @Autowired
    private BaseManager baseManager;

    @Autowired
    private ObjectRecommendedManager objectRecommendedManager;

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

    /***
     * 大师推荐
     * @param modelMap
     * @return
     * @throws Exception
     */
    @RequestMapping("/masterRecommended.do")
    public ModelAndView getListRecommended(ModelMap modelMap) throws Exception {
          modelMap.put("objectList",objectRecommendedManager.getRecommendedList("masterRecommended"));
          return  new ModelAndView("/masterRecommended/masterRecommendedList");
    }

    @RequestMapping("/saveObjectRecommended.do")
    @ResponseBody
    public String saveObjectRecommended(ObjectRecommended objectRecommended){

        try{
            objectRecommendedManager.saveObjectRecommend(objectRecommended);
        }catch (Exception e){

            e.printStackTrace();
        }
        return  objectRecommended.getId();
    }
    @RequestMapping("/updateSort.do")
    @ResponseBody
    public String updateSort(ObjectRecommended objectRecommended){

        try{
            objectRecommendedManager.updateSort(objectRecommended);
        }catch (Exception e){

            e.printStackTrace();
        }
        return  objectRecommended.getId();
    }



}
