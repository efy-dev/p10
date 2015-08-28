package com.efeiyi.pal.system.order.controller;

import com.efeiyi.pal.purchase.model.PurchaseOrder;
import com.efeiyi.pal.purchase.model.PurchaseOrderPayment;
import com.ming800.core.base.service.BaseManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.Date;

/**
 * Created by Administrator on 2015/8/17.
 */

@Controller
@RequestMapping("/purchaseOrderPayment")
public class PurchaseOrderPaymentController {

    @Autowired
    private BaseManager baseManager;

    @RequestMapping("/newPurchaseOrderPayment.do")
    public ModelAndView newPurchaseOrderPayment(ModelMap modelMap, HttpServletRequest request) throws Exception{
        String orderId = request.getParameter("orderId");
        if (orderId == null || orderId.trim().equals("")) {
            throw new Exception("商户id不能为空!");
        }
        PurchaseOrder order = (PurchaseOrder) baseManager.getObject(PurchaseOrder.class.getName(), orderId);

        modelMap.put("purchaseOrder", order);
        String resultPage = "/purchaseOrderPayment/purchaseOrderPaymentForm";
        return new ModelAndView(resultPage);
    }

    @RequestMapping("/savePurchaseOrderPayment.do")
    public ModelAndView savePurchaseOrderLabel(HttpServletRequest request) throws Exception{
        PurchaseOrderPayment purchaseOrderPayment = new PurchaseOrderPayment();

        String orderPaymentId = request.getParameter("id");
        String type = "new";
        if (orderPaymentId != null && !orderPaymentId.equals("")) {
            type = "edit";
            purchaseOrderPayment = (PurchaseOrderPayment) baseManager.getObject(PurchaseOrderPayment.class.getName(), orderPaymentId);
        }

        purchaseOrderPayment = setPurchaseOrderLabelBaseProperty(purchaseOrderPayment, request, type);
        purchaseOrderPayment = getRelationAttributeObject(purchaseOrderPayment, request, type);

        baseManager.saveOrUpdate(purchaseOrderPayment.getClass().getName(), purchaseOrderPayment);

        String resultPage = "redirect:/basic/xm.do?qm=viewPurchaseOrder&order=view&id="+purchaseOrderPayment.getPurchaseOrder().getId();
        return new ModelAndView(resultPage);
    }

    @RequestMapping("/removePurchaseOrderPayment.do")
    public ModelAndView removeTenantSource(HttpServletRequest request) throws Exception{
        String orderPaymentId = request.getParameter("orderPaymentId");
        if (orderPaymentId == null || orderPaymentId.trim().equals("")) {
            throw new Exception("id不能为空!");
        }
        PurchaseOrderPayment purchaseOrderorderPayment = (PurchaseOrderPayment) baseManager.getObject(PurchaseOrderPayment.class.getName(), orderPaymentId);
        purchaseOrderorderPayment.setStatus("0");
        baseManager.saveOrUpdate(purchaseOrderorderPayment.getClass().getName(), purchaseOrderorderPayment);
        PurchaseOrder purchaseOrder = purchaseOrderorderPayment.getPurchaseOrder();
        if (purchaseOrder.getPurchaseOrderPaymentList() == null || purchaseOrder.getPurchaseOrderPaymentList().size() == 0){
            purchaseOrder.setStatus("1");
            baseManager.saveOrUpdate(purchaseOrder.getClass().getName(), purchaseOrder);
        }

        String resultPage = "redirect:/basic/xm.do?qm=viewPurchaseOrder&order=view&id="+purchaseOrderorderPayment.getPurchaseOrder().getId();
        return new ModelAndView(resultPage);
    }

    /**
     * 获取purchaseOrderLabel的Form表单基本数据
     * @param purchaseOrderPayment
     * @param request
     * @param type
     * @return
     */
    private PurchaseOrderPayment setPurchaseOrderLabelBaseProperty(PurchaseOrderPayment purchaseOrderPayment, HttpServletRequest request, String type) throws Exception {
        String payWay = request.getParameter("payWay");
        String status = request.getParameter("status");

        purchaseOrderPayment.setPayWay(payWay);
        purchaseOrderPayment.setStatus(status);
        if (type.equals("new")){
            purchaseOrderPayment.setCreateDatetime(new Date());
            purchaseOrderPayment.setStatus("1");
        }

        return purchaseOrderPayment;
    }

    /**
     * 获取关联属性的对象
     * @param purchaseOrderPayment
     * @param request
     * @param type
     * @return
     */
    private PurchaseOrderPayment getRelationAttributeObject(PurchaseOrderPayment purchaseOrderPayment, HttpServletRequest request, String type){
        String purchaseOrderId = request.getParameter("purchaseOrder.id");
        PurchaseOrder purchaseOrder = (PurchaseOrder) baseManager.getObject(PurchaseOrder.class.getName(), purchaseOrderId);
        if (type.equals("new")){
            purchaseOrder.setStatus("2");
            baseManager.saveOrUpdate(PurchaseOrder.class.getName(), purchaseOrder);
        }
        purchaseOrderPayment.setPurchaseOrder(purchaseOrder);

        return purchaseOrderPayment;
    }

}
