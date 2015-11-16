package com.efeiyi.ec.system.PurchaseOrderPayment.controller;

import com.ming800.core.does.service.DoHandler;
import org.springframework.ui.ModelMap;

import javax.servlet.http.HttpServletRequest;

/**
 * Created by Administrator on 2015/11/16.
 */
public class PurchaseOrderPaymentHandler implements DoHandler{
    @Override
    public ModelMap handle(ModelMap modelMap, HttpServletRequest request) throws Exception {
        String viewIdentify = request.getParameter("viewIdentify");
        modelMap.put("viewIdentify",viewIdentify);
        return modelMap;
    }
}
