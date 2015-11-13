package com.efeiyi.ec.system.purchaseOrder.controller;

import com.efeiyi.ec.organization.model.Consumer;
import com.efeiyi.ec.organization.model.MyUser;
import com.efeiyi.ec.purchase.model.PurchaseOrder;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.service.DoHandler;
import com.ming800.core.util.ApplicationContextUtil;
import org.springframework.ui.ModelMap;

import javax.servlet.http.HttpServletRequest;

/**
 * Created by Administrator on 2015/7/16.
 */
public class PurchaseOrderHandler implements DoHandler {

    private BaseManager baseManager = (BaseManager) ApplicationContextUtil.getApplicationContext().getBean("baseManagerImpl");

    @Override
    public ModelMap handle(ModelMap modelMap, HttpServletRequest request) throws Exception {
        modelMap.put("view",request.getParameter("view"));

        if(request.getParameter("id") != null) {
            String orderId = request.getParameter("id");
            PurchaseOrder purchaseOrder = (PurchaseOrder) baseManager.getObject(PurchaseOrder.class.getName(),orderId);
            String  userId = null;
            if(null == purchaseOrder.getUser()){
                userId = purchaseOrder.getFatherPurchaseOrder().getUser().getId();
            }else{
                userId = purchaseOrder.getUser().getId();
            }
            Consumer consumer = (Consumer) baseManager.getObject(Consumer.class.getName(), userId);
            modelMap.put("consumer",consumer);
        }

        return modelMap;
    }
}
