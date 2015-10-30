package com.ming800.core.p.controller;
import com.ming800.core.base.service.BaseManager;
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
    private ObjectRecommendedManager objectRecommendedManager;//一般推荐

  //  private MasterWorkRecommendedManager masterWorkRecommendedManager;//作品推荐



    /***
     * 推荐列表
     * @param modelMap
     * @return
     * @throws Exception
     */
    @RequestMapping("/listRecommended.do")
    public ModelAndView getListRecommended(ModelMap modelMap,String groupName,String resultPage,HttpServletRequest request) throws Exception {
        request.setAttribute("qm",request.getParameter("qm"));
        modelMap.put("objectList",objectRecommendedManager.getRecommendedList(groupName));
        return  new ModelAndView("/"+resultPage);
    }

    @RequestMapping("/saveObjectRecommended.do")
    @ResponseBody
    public String saveObjectRecommended(ObjectRecommended objectRecommended){

        try{
            baseManager.saveOrUpdate(ObjectRecommended.class.getName(),objectRecommended);
        }catch (Exception e){

            e.printStackTrace();
        }
        System.out.print(objectRecommended.getId());
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
    @RequestMapping("/deleteObjectRecommended.do")
    @ResponseBody
    public String deleteObjectRecommend(ObjectRecommended objectRecommended){

        try {

            objectRecommendedManager.deleteObjectRecommend(objectRecommended);

        }catch (Exception e){
            e.printStackTrace();
        }

        return  objectRecommended.getId();
    }



}
