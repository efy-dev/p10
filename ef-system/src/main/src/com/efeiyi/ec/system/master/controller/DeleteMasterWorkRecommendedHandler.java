package com.efeiyi.ec.system.master.controller;

import com.efeiyi.ec.system.master.service.MasterWorkRecommendedManager;
import com.ming800.core.does.service.DoHandler;
import com.ming800.core.p.service.ObjectRecommendedManager;
import com.ming800.core.util.ApplicationContextUtil;
import org.springframework.ui.ModelMap;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * Created by Administrator on 2015/7/20.
 */
public class DeleteMasterWorkRecommendedHandler implements DoHandler {

    private MasterWorkRecommendedManager masterWorkRecommendedManager = (MasterWorkRecommendedManager) ApplicationContextUtil.getApplicationContext().getBean("masterWorkRecommendedManagerImpl");

    @Override
    public ModelMap handle(ModelMap modelMap, HttpServletRequest request) throws Exception {
        if (request.getParameter("masterWorkId") != null) {
          masterWorkRecommendedManager.deleteMasterWorkRecommendByMasterWork(request.getParameter("masterWorkId"));
        }
        if(request.getParameter("projectId")!=null){
            List list = masterWorkRecommendedManager.deleteMasterWorkRecommendByProject(request.getParameter("projectId"));
            modelMap.put("list",list);
        }
        return modelMap;
    }
}
