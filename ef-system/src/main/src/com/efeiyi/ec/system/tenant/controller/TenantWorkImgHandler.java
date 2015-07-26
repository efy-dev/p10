package com.efeiyi.ec.system.tenant.controller;

import com.ming800.core.does.service.DoHandler;
import org.springframework.ui.ModelMap;

import javax.servlet.http.HttpServletRequest;

/**
 * Created by Administrator on 2015/7/21.
 */
public class TenantWorkImgHandler implements DoHandler {

    @Override
    public ModelMap handle(ModelMap modelMap, HttpServletRequest request) throws Exception {



        modelMap.put("imgUrl",request.getParameter("imgUrl"));

        return modelMap;
    }
}
