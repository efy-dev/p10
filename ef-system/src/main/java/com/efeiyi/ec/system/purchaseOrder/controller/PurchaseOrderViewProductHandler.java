package com.efeiyi.ec.system.purchaseOrder.controller;

import com.efeiyi.ec.organization.model.Consumer;
import com.efeiyi.ec.purchase.model.PurchaseOrder;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import com.ming800.core.does.service.DoHandler;
import com.ming800.core.util.ApplicationContextUtil;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;
import org.springframework.ui.ModelMap;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by Administrator on 2015/7/21.
 */
public class PurchaseOrderViewProductHandler implements DoHandler {

    private BaseManager baseManager = (BaseManager) ApplicationContextUtil.getApplicationContext().getBean("baseManagerImpl");

    @Override
    public ModelMap handle(ModelMap modelMap, HttpServletRequest request) throws Exception {

        if (request.getParameter("viewIdentify") != null) {
            modelMap.put("viewIdentify", request.getParameter("viewIdentify"));
        }
        if (request.getParameter("viewProductModel") != null) {
            modelMap.put("viewProductModel", request.getParameter("viewProductModel"));
        }
        if (request.getParameter("productModelId") != null) {
            modelMap.put("productModelId", request.getParameter("productModelId"));
        }
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

        if(request.getParameter("id") != null){//如果是父订单 所有的子订单留言都得显示出来
            String orderId = request.getParameter("id");
            PurchaseOrder purchaseOrder = (PurchaseOrder) baseManager.getObject(PurchaseOrder.class.getName(),orderId);
            List<String> messageList = new ArrayList<String>();
            if(null == purchaseOrder.getFatherPurchaseOrder()){
                List<PurchaseOrder> subMessageList = purchaseOrder.getSubPurchaseOrder();
                if(null == subMessageList || subMessageList.size() == 0){
                    messageList.add(purchaseOrder.getMessage());
                }else{
                    for (int i = 0;i < subMessageList.size();i++){
                        messageList.add(subMessageList.get(i).getMessage());
                    }
                }
                modelMap.put("messageList",messageList);
            }else{
                messageList.add(purchaseOrder.getMessage());
                modelMap.put("messageList",messageList);
            }
        }

        XQuery xQuery = new XQuery("listTenant_product", request);
        List<Object> tenantList = baseManager.listObject(xQuery);
        modelMap.put("tenantList",tenantList);
        return modelMap;
    }
}
