package com.efeiyi.ec.system.project.controller;

import com.efeiyi.ec.master.model.Master;
import com.efeiyi.ec.organization.model.AddressCity;
import com.ming800.core.base.controller.BaseController;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2015/9/8.
 *
 */
@Controller
@RequestMapping("/pcn")
public class ProjectContentController extends BaseController {
    private static Logger logger = Logger.getLogger(ProjectContentController.class);
    @Autowired
    private BaseManager baseManager;

    @RequestMapping("/getcreators.do")
    @ResponseBody
    public List getCreators(HttpServletRequest request){
        List<Master> list = new ArrayList<Master>();

        List list2 = new ArrayList();
        XQuery xQuery;
        try {
            xQuery = new XQuery("listMaster_default",request);
            list = baseManager.listObject(xQuery);
            for(Master master:list){
                Map<String,String> map = new HashMap<String,String>();
                map.put("hex",master.getId());
                map.put("id",master.getId());
                map.put("label",master.getFullName());
                map.put("rgb",master.getTitle());
                list2.add(map);
            }
        }catch (Exception e){
            e.printStackTrace();
           logger.info(e);
        }

        return  list2;
    }

    @RequestMapping("/getcities.do")
    @ResponseBody
    public List getCities(HttpServletRequest request){
        List<AddressCity> list = new ArrayList<AddressCity>();
        List list2 = new ArrayList();
        XQuery xQuery;
        try {
            xQuery = new XQuery("listAddressCity2_default",request);
            list = baseManager.listObject(xQuery);
            for(AddressCity addressCity:list){
                Map<String,String> map = new HashMap<String,String>();
                map.put("hex",addressCity.getId());
                map.put("id",addressCity.getId());
                map.put("label",addressCity.getName());
                map.put("rgb",addressCity.getName());
                list2.add(map);
            }
        }catch (Exception e){
            e.printStackTrace();
            logger.info(e);
        }

        return  list2;
    }
}
