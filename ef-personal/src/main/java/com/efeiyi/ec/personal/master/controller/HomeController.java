package com.efeiyi.ec.personal.master.controller;

import com.efeiyi.ec.master.model.Master;
import com.efeiyi.ec.master.model.MasterProject;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.PageInfo;
import com.ming800.core.does.model.XQuery;
import com.ming800.core.p.service.ObjectRecommendedManager;
import com.ming800.core.taglib.PageEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * Created by AC丶man on 2015/7/26.
 */
@Controller
public class HomeController {

    @Autowired
    private ObjectRecommendedManager recommendedManager;
    @Autowired
    private BaseManager baseManager;

    /**
     * 获取所有传承人
     * @param model
     * @return
     */
    @RequestMapping("/index")
    public String index(Model model)throws Exception{
       /* XQuery xQuery = new XQuery("listTenantProject_default",request);
        List list = baseManager.listObject(xQuery);
        model.addAttribute("list",list);
        model.addAttribute("pageMsg","0");*/
        List skillList = recommendedManager.getRecommendedList("masterSkillRecommended");
        List artList = recommendedManager.getRecommendedList("masterArtRecommended");
        model.addAttribute("skillList",skillList);
        model.addAttribute("artList",artList);
        return "/tenant/tenantList";
    }

//    public String mainMasterProject(List<MasterProject> masterProjects) {
//
//        MasterProject masterProject = null;
//
//        if (masterProjects != null && masterProjects.size() > 0) {
//
//            for (MasterProject masterProjectTemp : masterProjects) {
//                if (masterProjectTemp.getStatus().equals("1")) {
//                    masterProject = masterProjectTemp;
//                }
//            }
//            if (masterProject == null) {
//                masterProject = masterProjects.get(0);
//            }
//
//            return masterProject.getProject().getName();
//        } else {
//
//            return "";
//        }
//    }

    @RequestMapping("/allMaster")
    public String allMasterList(HttpServletRequest request,Model model) throws Exception {
        XQuery xQuery = new XQuery("plistMaster_byDateTime","1",request.getParameter("sort"),request);
        PageEntity entity = new PageEntity();
        String index = request.getParameter("pageEntity.index");
        if (index == null || "".equals(index)){
            entity.setIndex(Integer.parseInt("1"));
        }else{
            entity.setIndex(Integer.parseInt(index));
        }
        entity.setSize(12);
        xQuery.setPageEntity(entity);
        PageInfo info = baseManager.listPageInfo(xQuery);
        xQuery.addRequestParamToModel(model, request);
        List<Master> masterList = info.getList();
        model.addAttribute("masterList",masterList);
        return "/tenant/allMasterList";
    }

}
