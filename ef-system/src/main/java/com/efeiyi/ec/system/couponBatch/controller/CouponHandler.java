package com.efeiyi.ec.system.couponBatch.controller;

import com.efeiyi.ec.purchase.model.PurchaseOrder;
import com.efeiyi.ec.purchase.model.PurchaseOrderPaymentDetails;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.service.DoHandler;
import com.ming800.core.util.ApplicationContextUtil;
import org.springframework.ui.ModelMap;

import javax.servlet.http.HttpServletRequest;
import java.util.LinkedHashMap;

/**
 * Created by Administrator on 2015/10/28.
 */
public class CouponHandler implements DoHandler {

    private BaseManager baseManager = (BaseManager) ApplicationContextUtil.getApplicationContext().getBean("baseManagerImpl");

    @Override
    public ModelMap handle(ModelMap modelMap, HttpServletRequest request) throws Exception {
        String id = request.getParameter("id");
        String hql = "from PurchaseOrderPaymentDetails p where p.coupon.id=:id";
        LinkedHashMap<String,Object> hm = new LinkedHashMap<>();
        hm.put("id",id);
        PurchaseOrderPaymentDetails purchaseOrderPaymentDetails = (PurchaseOrderPaymentDetails) baseManager.getUniqueObjectByConditions(hql,hm);

        PurchaseOrder purchaseOrder = purchaseOrderPaymentDetails.getPurchaseOrderPayment().getPurchaseOrder();
        modelMap.put("purchaseOrder",purchaseOrder);

        return modelMap;
    }
}
