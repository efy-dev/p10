package com.efeiyi.ec.system.master.controller;

import com.efeiyi.ec.master.model.MasterProject;
import com.efeiyi.ec.project.model.Project;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import com.ming800.core.does.service.DoHandler;
import com.ming800.core.p.service.ObjectRecommendedManager;
import com.ming800.core.util.ApplicationContextUtil;
import org.springframework.ui.ModelMap;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * Created by Administrator on 2015/7/21.
 */
public class MasterIntroductionFormHandler implements DoHandler {

    private BaseManager baseManager = (BaseManager) ApplicationContextUtil.getApplicationContext().getBean("baseManagerImpl");

    @Override
    public ModelMap handle(ModelMap modelMap, HttpServletRequest request) throws Exception {

        XQuery xQuery = new XQuery("listProject_default",request);
        List<Project> list = baseManager.listObject(xQuery);
        modelMap.addAttribute("projectList",list);
        if (request.getParameter("masterId") != null) {
            modelMap.put("masterId", request.getParameter("masterId"));
            xQuery = new XQuery("listMasterProject3Message_default",request);
            xQuery.put("master_id", request.getParameter("masterId"));
            List<MasterProject> masterProjectList = baseManager.listObject(xQuery);
            modelMap.addAttribute("masterProjectList",masterProjectList);
        }


        return modelMap;
    }
}
