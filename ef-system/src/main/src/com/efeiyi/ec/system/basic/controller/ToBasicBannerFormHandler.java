package com.efeiyi.ec.system.basic.controller;

import com.ming800.core.does.service.DoHandler;
import org.springframework.ui.ModelMap;

import javax.servlet.http.HttpServletRequest;

/**
 * Created by Administrator on 2015/7/20.
 */
public class ToBasicBannerFormHandler implements DoHandler {
    @Override
    public ModelMap handle(ModelMap modelMap, HttpServletRequest request) throws Exception {
        if (request.getParameter("groupName") != null) {
            modelMap.put("groupName", request.getParameter("groupName"));
        }
        return modelMap;
    }
}
