package com.efeiyi.ec.system.basic.controller;

import com.ming800.core.base.controller.BaseController;
import com.ming800.core.p.model.Banner;
import com.ming800.core.p.service.BannerManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;


/**
 * Created by IntelliJ IDEA.
 * User: ming
 * Date: 12-10-15
 * Time: 下午4:56
 * To change this template use File | Settings | File Templates.
 */

@Controller
@RequestMapping("/banner")
public class BannerController extends BaseController {

    @Autowired
    private BannerManager bannerManager;

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
