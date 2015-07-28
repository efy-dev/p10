package com.efeiyi.ec.system.master.controller;

import com.ming800.core.does.service.DoHandler;
import org.springframework.ui.ModelMap;

import javax.servlet.http.HttpServletRequest;

/**
 * Created by Administrator on 2015/7/20.
 */
public class ToMasterBannerFormHandler implements DoHandler {
    @Override
    public ModelMap handle(ModelMap modelMap, HttpServletRequest request) throws Exception {
        if (request.getParameter("masterId") != null) {
            modelMap.put("master_id", request.getParameter("masterId"));
        }
        return modelMap;
    }
}
