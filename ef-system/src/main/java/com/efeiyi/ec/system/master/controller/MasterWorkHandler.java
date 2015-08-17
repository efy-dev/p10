package com.efeiyi.ec.system.master.controller;

import com.ming800.core.does.service.DoHandler;
import org.springframework.ui.ModelMap;

import javax.servlet.http.HttpServletRequest;

/**
 * Created by Administrator on 2015/7/21.
 */
public class MasterWorkHandler implements DoHandler {

    @Override
    public ModelMap handle(ModelMap modelMap, HttpServletRequest request) throws Exception {

        if (request.getParameter("masterId") != null) {
            modelMap.put("masterId", request.getParameter("masterId"));
        }

        modelMap.put("projectId",request.getParameter("projectId"));

        return modelMap;
    }
}
