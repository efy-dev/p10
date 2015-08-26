package com.efeiyi.pal.system.order.controller;

import com.efeiyi.pal.product.model.Product;
import com.efeiyi.pal.purchase.model.PurchaseOrder;
import com.efeiyi.pal.purchase.model.PurchaseOrderLabel;
import com.ming800.core.base.service.BaseManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;

/**
 * Created by Administrator on 2015/8/17.
 */

@Controller
@RequestMapping("/purchaseOrderLabel")
public class PurchaseOrderLabelController {

    @Autowired
    private BaseManager baseManager;

    @RequestMapping("/savePurchaseOrderLabel.do")
    public ModelAndView savePurchaseOrderLabel(HttpServletRequest request) throws Exception{
        PurchaseOrderLabel purchaseOrderLabel = new PurchaseOrderLabel();

        String orderLabelId = request.getParameter("id");
        if (orderLabelId != null && !orderLabelId.equals("")) {
            purchaseOrderLabel = (PurchaseOrderLabel) baseManager.getObject(PurchaseOrderLabel.class.getName(), orderLabelId);
        }

        purchaseOrderLabel = setPurchaseOrderLabelBaseProperty(purchaseOrderLabel, request);
        purchaseOrderLabel = getRelationAttributeObject(purchaseOrderLabel, request);

        baseManager.saveOrUpdate(purchaseOrderLabel.getClass().getName(), purchaseOrderLabel);

        String resultPage = "redirect:/basic/xm.do?qm=viewPurchaseOrder&order=view&id="+purchaseOrderLabel.getPurchaseOrder().getId();
        return new ModelAndView(resultPage);
    }

    @RequestMapping("/removePurchaseOrderLabel.do")
    public ModelAndView removeTenantSource(HttpServletRequest request) throws Exception{
        String orderLabelId = request.getParameter("orderLabelId");
        if (orderLabelId == null || orderLabelId.trim().equals("")) {
            throw new Exception("id不能为空!");
        }
        PurchaseOrderLabel purchaseOrderLabel = (PurchaseOrderLabel) baseManager.getObject(PurchaseOrderLabel.class.getName(), orderLabelId);
        purchaseOrderLabel.setStatus("0");
        baseManager.saveOrUpdate(purchaseOrderLabel.getClass().getName(), purchaseOrderLabel);

        String resultPage = "redirect:/basic/xm.do?qm=viewPurchaseOrder&order=view&id="+purchaseOrderLabel.getPurchaseOrder().getId();
        return new ModelAndView(resultPage);
    }

    /**
     * 获取purchaseOrderLabel的Form表单基本数据
     * @param purchaseOrderLabel
     * @param request
     * @return
     */
    private PurchaseOrderLabel setPurchaseOrderLabelBaseProperty(PurchaseOrderLabel purchaseOrderLabel, HttpServletRequest request) throws Exception {
        String amount = request.getParameter("amount");
        String status = request.getParameter("status");

        purchaseOrderLabel.setAmount(Integer.valueOf(amount));
        purchaseOrderLabel.setStatus(status);

        return purchaseOrderLabel;
    }

    /**
     * 获取关联属性的对象
     * @param purchaseOrderLabel
     * @param request
     * @return
     */
    private PurchaseOrderLabel getRelationAttributeObject(PurchaseOrderLabel purchaseOrderLabel, HttpServletRequest request){
        String purchaseOrderId = request.getParameter("purchaseOrder.id");
        PurchaseOrder purchaseOrder = (PurchaseOrder) baseManager.getObject(PurchaseOrder.class.getName(), purchaseOrderId);
        purchaseOrderLabel.setPurchaseOrder(purchaseOrder);

        String productId = request.getParameter("product.id");
        Product product = (Product) baseManager.getObject(Product.class.getName(), productId);
        purchaseOrderLabel.setProduct(product);

        return purchaseOrderLabel;
    }

}
