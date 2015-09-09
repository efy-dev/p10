package com.efeiyi.ec.system.purchaseOrder.controller;

import com.ming800.core.does.service.DoHandler;
import org.springframework.ui.ModelMap;

import javax.servlet.http.HttpServletRequest;

/**
 * Created by Administrator on 2015/7/16.
 */
public class PurchaseOrderHandler implements DoHandler {
    @Override
    public ModelMap handle(ModelMap modelMap, HttpServletRequest request) throws Exception {
        modelMap.put("view",request.getParameter("view"));
        return modelMap;
    }
}
