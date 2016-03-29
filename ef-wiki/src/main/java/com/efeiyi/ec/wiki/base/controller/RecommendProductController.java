package com.efeiyi.ec.wiki.base.controller;

import com.ming800.core.p.service.ObjectRecommendedManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * Created by Administrator on 2016/3/23.
 *
 */
@Controller
@RequestMapping("/recommend")
public class RecommendProductController {
    @Autowired
    private ObjectRecommendedManager objectRecommendedManager;//一般推荐
    /***
     * 推荐列表
     * @param
     * @return
     * @throws Exception
     */
    @RequestMapping({"/getRecommendProductList/{projectCategoryId}"})
    @ResponseBody
    public Object getListRecommended(HttpServletRequest request, @PathVariable String projectCategoryId) throws Exception {

        List objectList = objectRecommendedManager.getRecommendedList("wiki.recommendProductModel");
        int index = 0;
        if (objectList != null && !objectList.isEmpty()){
            index =  (int)(Math.random()*(objectList.size()));
        }

        return  objectList.get(index);
    }
}
