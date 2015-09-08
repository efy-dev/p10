package com.efeiyi.ec.system.project.controller;

import com.efeiyi.ec.wiki.model.ProjectContent;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import com.ming800.core.does.service.DoHandler;
import com.ming800.core.util.ApplicationContextUtil;
import org.springframework.ui.ModelMap;

import javax.servlet.http.HttpServletRequest;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * Created by Administrator on 2015/9/7.
 *
 */
public class ProjectContentHandler implements DoHandler {

    private BaseManager baseManager = (BaseManager) ApplicationContextUtil.getApplicationContext().getBean("baseManagerImpl");

    @Override
    public ModelMap handle(ModelMap modelMap, HttpServletRequest request) throws Exception {
        XQuery xQuery = new XQuery("listProject_default",request);
        List<ProjectContent> list = baseManager.listObject(xQuery);
        modelMap.put("projectList",list);
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String createDatetime = sdf.format(new Date());
        modelMap.put("createDatetime",createDatetime);
        XQuery xQuery2 = new XQuery("listProjectCategory_default",request);
        List<ProjectContent> list2 = baseManager.listObject(xQuery2);
        modelMap.put("projectCategoryList",list2);
        if (!"".equalsIgnoreCase(request.getParameter("id")) && null != request.getParameter("id")) {
            ProjectContent projectContent = (ProjectContent) baseManager.getObject(ProjectContent.class.getName(), request.getParameter("id"));
            modelMap.put("projectContent", projectContent);
        }
        return modelMap;
    }
}
