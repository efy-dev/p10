package com.efeiyi.ec.system.product.controller;

import com.ming800.core.base.service.BaseManager;
import com.ming800.core.base.service.XdoManager;
import com.ming800.core.does.model.XQuery;
import com.ming800.core.does.service.DoHandler;
import com.ming800.core.util.ApplicationContextUtil;
import org.springframework.ui.ModelMap;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * Created by Administrator on 2015/7/21.
 */
public class listProductHandler implements DoHandler {

    private BaseManager baseManager = (BaseManager) ApplicationContextUtil.getApplicationContext().getBean("baseManagerImpl");

    @Override
    public ModelMap handle(ModelMap modelMap, HttpServletRequest request) throws Exception {

        if (request.getParameter("tenantId") != null) {
            modelMap.put("tenantId", request.getParameter("tenantId"));
        }
        if (request.getParameter("viewIdentify") != null) {
            modelMap.put("viewIdentify", request.getParameter("viewIdentify"));
        }

//        XQuery xQuery = new XQuery();
//        List list =  baseManager.listObject(xQuery);

        return modelMap;
    }
}
