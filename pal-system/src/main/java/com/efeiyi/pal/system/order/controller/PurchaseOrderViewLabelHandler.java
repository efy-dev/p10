package com.efeiyi.pal.system.order.controller;

import com.efeiyi.pal.label.model.Label;
import com.efeiyi.pal.purchase.model.PurchaseOrder;
import com.efeiyi.pal.purchase.model.PurchaseOrderLabel;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.service.DoHandler;
import com.ming800.core.util.ApplicationContextUtil;
import org.springframework.ui.ModelMap;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * Created by Administrator on 2015/9/2.
 */
public class PurchaseOrderViewLabelHandler implements DoHandler {

    private BaseManager baseManager = (BaseManager) ApplicationContextUtil.getApplicationContext().getBean("baseManagerImpl");

    @Override
    public ModelMap handle(ModelMap modelMap, HttpServletRequest request) throws Exception {

        String purchaseOrderId = request.getParameter("id");
        if (purchaseOrderId == null || "".equals(purchaseOrderId)) {
            throw new Exception("订单Id为空");
        }
        PurchaseOrder purchaseOrder = (PurchaseOrder) baseManager.getObject(PurchaseOrder.class.getName(), purchaseOrderId);

        boolean orderTag = false;
        boolean tagNFC = false;
        if (purchaseOrder != null){
            orderTag = purchaseOrderLabels(purchaseOrder);
            tagNFC = purchaseOrderLabelsNFC(purchaseOrder);
        }

        modelMap.put("tagNFC", tagNFC);
        modelMap.put("orderTag", orderTag);
        modelMap.put("object", purchaseOrder);
        return modelMap;
    }

    private boolean purchaseOrderLabels(PurchaseOrder purchaseOrder){
        List<PurchaseOrderLabel> purchaseOrderLabelList= purchaseOrder.getPurchaseOrderLabelList();
        for (PurchaseOrderLabel pol: purchaseOrderLabelList){
            List<Label> labelList = pol.getLabelList();
            if (labelList != null && labelList.size() > 0){
                return true;
            }
        }
        return false;
    }

    private boolean purchaseOrderLabelsNFC(PurchaseOrder purchaseOrder){
        List<PurchaseOrderLabel> purchaseOrderLabelList= purchaseOrder.getPurchaseOrderLabelList();
        for (PurchaseOrderLabel pol: purchaseOrderLabelList){
            if (pol != null && "2".equals(pol.getType())){
                return true;
            }
        }
        if ("1".equals(purchaseOrder.getStatus()) || "2".equals(purchaseOrder.getStatus())){
            return true;
        }
        return false;
    }

}
