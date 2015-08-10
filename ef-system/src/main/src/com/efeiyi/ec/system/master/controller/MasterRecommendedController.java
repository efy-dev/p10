package com.efeiyi.ec.system.master.controller;

import com.efeiyi.ec.master.model.MasterWorkRecommended;
import com.efeiyi.ec.system.master.service.MasterWorkRecommendedManager;
import com.ming800.core.base.service.BaseManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * Created by kayson_yang on 2015/7/13.
 *
 */

@Controller
@RequestMapping("/MasterRecommended")
public class MasterRecommendedController {
    private static Logger logger = Logger.getLogger(MasterRecommendedController.class);
    @Autowired
    private BaseManager baseManager;


    @Autowired
    private MasterWorkRecommendedManager masterWorkRecommendedManager;//作品推荐



    /***
     * 作品推荐相关
     */

    @RequestMapping("/saveMasterWorkRecommended.do")
    @ResponseBody
    public String saveMasterWorkRecommended(MasterWorkRecommended masterWorkRecommended){

        try{
            masterWorkRecommendedManager.saveMasterWorkRecommend(masterWorkRecommended);
        }catch (Exception e){

            e.printStackTrace();
        }
        return  masterWorkRecommended.getId();
    }


    @RequestMapping("/deleteMasterWorkRecommended.do")
    @ResponseBody
    public String deleteMasterWorkRecommended(MasterWorkRecommended masterWorkRecommended){

        try {

            masterWorkRecommendedManager.deleteMasterWorkRecommend(masterWorkRecommended);

        }catch (Exception e){
            e.printStackTrace();
        }

        return  masterWorkRecommended.getId();
    }


}
