package com.efeiyi.ec.website.interceptor;

import com.efeiyi.ec.organization.model.MyUser;
import com.efeiyi.ec.organization.model.User;
import com.efeiyi.ec.purchase.model.PurchaseOrder;
import com.efeiyi.ec.purchase.model.PurchaseOrderPaymentDetails;
import com.efeiyi.ec.website.organization.util.AuthorizationUtil;
import com.efeiyi.ec.zero.promotion.model.PromotionPlan;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.util.CookieTool;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.Cookie;
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
        String promotionSource = (String) request.getSession().getAttribute("source");
        if (promotionSource == null) {
            Cookie cookie = CookieTool.getCookieByName(request, "source");
            if (cookie != null) {
                promotionSource = cookie.getValue();
            }
        }
        if (promotionSource != null) {
            LinkedHashMap<String, Object> queryParamMap = new LinkedHashMap<>();
            queryParamMap.put("identifier", promotionSource);
            PromotionPlan promotionPlan = (PromotionPlan) baseManager.getUniqueObjectByConditions("from PromotionPlan x where x.identifier=:identifier", queryParamMap);

            //营销返利有效并且没有超出RD有效期，记录订单
//            MyUser user = (MyUser)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
            if (!"0".equals(promotionPlan.getStatus()) /*&& user.getRdEndDay() != null && new Date().compareTo(user.getRdEndDay()) < 0*/) {
                String path = request.getServletPath();
                String orderId = path.substring(path.lastIndexOf("/") + 1);
                PurchaseOrderPaymentDetails purchaseOrderPaymentDetails = (PurchaseOrderPaymentDetails) baseManager.getObject(PurchaseOrderPaymentDetails.class.getName(), orderId);
                PurchaseOrder purchaseOrder = purchaseOrderPaymentDetails.getPurchaseOrderPayment().getPurchaseOrder();
                purchaseOrder.setSource(promotionSource);
                baseManager.saveOrUpdate(PurchaseOrder.class.getName(), purchaseOrder);
            }
        }
        return super.preHandle(request, response, handler);
    }


}
