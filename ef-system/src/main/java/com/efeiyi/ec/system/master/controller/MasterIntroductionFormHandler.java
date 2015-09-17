package com.efeiyi.ec.system.master.controller;

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

        if (request.getParameter("masterId") != null) {
            modelMap.put("masterId", request.getParameter("masterId"));
        }
        XQuery xQuery = new XQuery("listProject_default",request);
        List<Project> list = baseManager.listObject(xQuery);
        modelMap.addAttribute("projectList",list);
        return modelMap;
    }
}
