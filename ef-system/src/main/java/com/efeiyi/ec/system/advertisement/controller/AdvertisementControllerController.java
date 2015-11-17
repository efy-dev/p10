package com.efeiyi.ec.system.advertisement.controller;

import com.efeiyi.ec.organization.model.Professional;
import com.efeiyi.ec.system.advertisement.service.AdvertisementManager;
import com.efeiyi.ec.system.professional.service.ProfessionalManager;
import com.ming800.core.base.controller.BaseController;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import java.util.List;


/**
 * Created by Administrator on 2015/6/18.
 */
@Controller
@RequestMapping("/professional")
public class AdvertisementControllerController extends BaseController {
    @Autowired
    private BaseManager baseManager;


    @Autowired
    private AdvertisementManager advertisementManager;



    @RequestMapping("/saveAdvertisement.do")
    public String saveAdvertisement(Professional professional,String resultPage,HttpServletRequest request){

       try{
           XQuery xQuery = new XQuery("listAdvertisement_default",request);
           xQuery.put("groupName","yxhd");
           List list = baseManager.listObject(xQuery);
           System.out.println(list.size());
        //   professionalManager.saveProfessional(professional);
       } catch (Exception e){
               e.printStackTrace();
       }

        return  resultPage;
    }

    @RequestMapping("/yx.do")
    public String  yx(HttpServletRequest request)throws Exception{

        return  "redirect:http://tuan.efeiyi.com/group/sendRedPacket";

    }
}
