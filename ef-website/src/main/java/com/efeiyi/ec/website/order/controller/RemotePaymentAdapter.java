package com.efeiyi.ec.website.order.controller;


import com.efeiyi.ec.purchase.model.PurchaseOrder;
import com.efeiyi.ec.purchase.model.PurchaseOrderPaymentDetails;
import com.efeiyi.ec.website.order.service.PaymentManager;
import com.ming800.core.base.service.BaseManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping({"remote"})
public class RemotePaymentAdapter {

    private PaymentManager paymentManager;

    private BaseManager baseManager;

    @Autowired
    public RemotePaymentAdapter(PaymentManager paymentManager, BaseManager baseManager) {
        this.paymentManager = paymentManager;
        this.baseManager = baseManager;
    }

    @RequestMapping({"/payAdapter"})
    public String payAdapter(HttpServletRequest request) {
        String paymentType = request.getParameter("paymentType");
        String paymentDetailsId = request.getParameter("paymentDetailsId");
        String callback = request.getParameter("callback");
        String redirect = "";

        request.getSession().setAttribute("remoteAdapterCallback", callback);

        if (paymentType.equals(PurchaseOrder.ZHIFUBAO)) {
            redirect = "redirect:/remote/pay/ali?paymentDetailsId=" + paymentDetailsId;
        } else if (paymentType.equals(PurchaseOrder.WEIXIN)) {
            redirect = "redirect:/remote/pay/wx?paymentDetailsId=" + paymentDetailsId;
        }

        return redirect;
    }

    @RequestMapping({"/payResultAdapter"})
    public String payResultAdapter(HttpServletRequest request) {
        return "";
    }

    @RequestMapping({"/pay/ali"})
    public String aliPay(HttpServletRequest request, Model model) {
        String paymentDetailsId = request.getParameter("paymentDetailsId");
        PurchaseOrderPaymentDetails paymentDetails = (PurchaseOrderPaymentDetails) baseManager.getObject(PurchaseOrderPaymentDetails.class.getName(), paymentDetailsId);
        String returnUrl = "/remote/payResultAdapter?paymentDetailsId=" + paymentDetailsId;
        String result = paymentManager.alipayWap(paymentDetails, returnUrl);
        model.addAttribute("resultHtml", result);
        return "/order/alipay";
    }

    @RequestMapping({"/pay/wx"})
    public String wxPay(HttpServletRequest request) {
        return "";
    }

}
