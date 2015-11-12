package com.efeiyi.ec.system.master.controller;

import com.efeiyi.ec.system.master.service.MasterManager;
import com.ming800.core.does.service.DoHandler;
import com.ming800.core.util.ApplicationContextUtil;
import org.springframework.ui.ModelMap;

import javax.servlet.http.HttpServletRequest;

/**
 * Created by Administrator on 2015/11/10.
 */
public class DeleteMasterMessageHandler implements DoHandler {

    private MasterManager manager = (MasterManager) ApplicationContextUtil.getApplicationContext().getBean("masterManagerImpl");

    @Override
    public ModelMap handle(ModelMap modelMap, HttpServletRequest request) throws Exception {
        if (request.getParameter("messageId") != null){
            manager.removeMasterMessage(request.getParameter("messageId"));
        }
        return modelMap;
    }
}
