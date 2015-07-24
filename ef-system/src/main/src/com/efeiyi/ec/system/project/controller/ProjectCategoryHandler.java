package com.efeiyi.ec.system.project.controller;

import com.ming800.core.does.service.DoHandler;
import org.springframework.ui.ModelMap;

import javax.servlet.http.HttpServletRequest;

/**
 * Created by Administrator on 2015/7/16.
 */
public class ProjectCategoryHandler implements DoHandler {


    @Override
    public ModelMap handle(ModelMap modelMap, HttpServletRequest request) throws Exception {
        modelMap.put("level",request.getParameter("level"));
        modelMap.put("fatherCategoryId",request.getParameter("fatherCategoryId"));
        return modelMap;
    }
}
