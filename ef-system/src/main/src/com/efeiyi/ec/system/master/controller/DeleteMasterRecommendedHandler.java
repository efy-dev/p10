package com.efeiyi.ec.system.master.controller;

import com.ming800.core.does.service.DoHandler;
import com.ming800.core.p.service.ObjectRecommendedManager;
import com.ming800.core.util.ApplicationContextUtil;
import org.springframework.ui.ModelMap;

import javax.servlet.http.HttpServletRequest;

/**
 * Created by Administrator on 2015/7/20.
 */
public class DeleteMasterRecommendedHandler implements DoHandler {

    private ObjectRecommendedManager objectRecommendedManager = (ObjectRecommendedManager) ApplicationContextUtil.getApplicationContext().getBean("objectRecommendedManagerImpl");

    @Override
    public ModelMap handle(ModelMap modelMap, HttpServletRequest request) throws Exception {
        if (request.getParameter("recommendId") != null) {
          objectRecommendedManager.deleteObjectRecommendByRecommendId(request.getParameter("recommendId"));
        }
        return modelMap;
    }
}
