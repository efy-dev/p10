package com.efeiyi.ec.system.basic.controller;

import com.ming800.core.does.service.DoHandler;
import org.springframework.ui.ModelMap;

import javax.servlet.http.HttpServletRequest;

/**
 * Created by Administrator on 2015/7/22.
 */
public class BasicBannerListHandler implements DoHandler {

    @Override
    public ModelMap handle(ModelMap modelMap, HttpServletRequest request) throws Exception {

        modelMap.put("groupName" , request.getParameter("groupName"));

        return modelMap;
    }
}
