package com.efeiyi.ec.website.interceptor;

import com.efeiyi.ec.purchase.model.PurchaseOrder;
import com.efeiyi.ec.purchase.model.PurchaseOrderPaymentDetails;
import com.efeiyi.ec.website.organization.util.AuthorizationUtil;
import com.efeiyi.jh.advertisement.model.PromotionPurchaseRecord;
import com.efeiyi.jh.advertisement.model.PromotionUserRecord;
import com.ming800.core.base.service.BaseManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Date;
import java.util.LinkedHashMap;

/**
 * Created by Administrator on 2015/12/3.
 */
public class PromotionPurchaseRecorderInterceptor extends HandlerInterceptorAdapter {

    @Autowired
    private BaseManager baseManager;

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        LinkedHashMap<String, Object> queryParamMap = new LinkedHashMap<>();
        queryParamMap.put("user", AuthorizationUtil.getUser());
        PromotionUserRecord promotionUserRecord = (PromotionUserRecord) baseManager.getUniqueObjectByConditions("from PromotionUserRecord x where x.user=:user", queryParamMap);
        if (promotionUserRecord != null && promotionUserRecord.getRdEndDate().compareTo(new Date()) >= 0) {
            String path = request.getServletPath();
            String orderId = path.substring(path.lastIndexOf("/") + 1);
            PurchaseOrderPaymentDetails purchaseOrderPaymentDetails = (PurchaseOrderPaymentDetails) baseManager.getObject(PurchaseOrderPaymentDetails.class.getName(), orderId);
            PurchaseOrder purchaseOrder = purchaseOrderPaymentDetails.getPurchaseOrderPayment().getPurchaseOrder();
            PromotionPurchaseRecord promotionPurchaseRecord = new PromotionPurchaseRecord();
            promotionPurchaseRecord.setPurchaseOrder(purchaseOrder);
            promotionPurchaseRecord.setPromotionPlan(promotionUserRecord.getLatestPromotionPlan());
            promotionPurchaseRecord.setPromotionUserRecord(promotionUserRecord);
            baseManager.saveOrUpdate(PromotionPurchaseRecord.class.getName(), promotionPurchaseRecord);
        }
        return super.preHandle(request, response, handler);
    }


}
