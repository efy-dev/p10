package com.efeiyi.ec.system.master.controller;

import com.efeiyi.ec.system.master.service.MasterWorkRecommendedManager;
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
    private MasterWorkRecommendedManager masterWorkRecommendedManager = (MasterWorkRecommendedManager) ApplicationContextUtil.getApplicationContext().getBean("masterWorkRecommendedManagerImpl");
    @Override
    public ModelMap handle(ModelMap modelMap, HttpServletRequest request) throws Exception {
        if (request.getParameter("recommendId") != null) {
          objectRecommendedManager.deleteObjectRecommendByRecommendId(request.getParameter("recommendId"));//删除传承人推荐
          masterWorkRecommendedManager.deleteMasterWorkRecommendByMaster(request.getParameter("recommendId"));//删除该传承人所有的推荐作品
        }
        return modelMap;
    }
}
