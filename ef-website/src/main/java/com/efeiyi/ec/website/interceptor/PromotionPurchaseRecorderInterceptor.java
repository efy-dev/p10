package com.efeiyi.ec.website.interceptor;

import com.efeiyi.ec.purchase.model.PurchaseOrder;
import com.efeiyi.ec.purchase.model.PurchaseOrderPaymentDetails;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.util.CookieTool;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Created by Administrator on 2015/12/3.
 */
public class PromotionPurchaseRecorderInterceptor extends HandlerInterceptorAdapter {

    @Autowired
    private BaseManager baseManager;

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        try {

            String promotionSource = (String) request.getSession().getAttribute("source");
            if (promotionSource == null) {
                Cookie cookie = CookieTool.getCookieByName(request, "source");
                if (cookie != null) {
                    promotionSource = cookie.getValue();
                }
            }
            if (promotionSource != null) {
                //营销返利有效并且没有超出RD有效期，记录订单
                String path = request.getServletPath();
                String orderId = path.substring(path.lastIndexOf("/") + 1);
                PurchaseOrderPaymentDetails purchaseOrderPaymentDetails = (PurchaseOrderPaymentDetails) baseManager.getObject(PurchaseOrderPaymentDetails.class.getName(), orderId);

                //orderId是PurchaseOrder.id或purchaseOrderPaymentDetails.id
                PurchaseOrder purchaseOrder = purchaseOrderPaymentDetails != null ? purchaseOrderPaymentDetails.getPurchaseOrderPayment().getPurchaseOrder() : (PurchaseOrder) baseManager.getObject(PurchaseOrder.class.getName(), orderId);
                purchaseOrder.setSource(promotionSource);
                baseManager.saveOrUpdate(PurchaseOrder.class.getName(), purchaseOrder);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return super.preHandle(request, response, handler);
    }


}
