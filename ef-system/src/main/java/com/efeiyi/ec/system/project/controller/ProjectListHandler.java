package com.efeiyi.ec.system.project.controller;

import com.ming800.core.does.service.DoHandler;
import org.springframework.ui.ModelMap;

import javax.servlet.http.HttpServletRequest;

/**
 * Created by Administrator on 2015/7/23.
 */
public class ProjectListHandler implements DoHandler {

    @Override
    public ModelMap handle(ModelMap modelMap, HttpServletRequest request) throws Exception {

        modelMap.put("masterId",request.getParameter("masterId"));
        modelMap.put("master",request.getParameter("master"));

        return modelMap;
    }
}
