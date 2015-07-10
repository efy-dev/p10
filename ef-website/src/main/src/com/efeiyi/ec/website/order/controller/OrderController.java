package com.efeiyi.ec.website.order.controller;

import com.efeiyi.ec.purchase.model.PurchaseOrder;
import com.ming800.core.base.controller.BaseController;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import java.util.*;

/**
 * Created by Administrator on 2015/6/25.
 */
@Controller
@RequestMapping("/purchaseOrder")
public class OrderController extends BaseController {
    @Autowired
    private BaseManager baseManager;

    @RequestMapping(value = "/listOrder.do")
    public String queryOrderList(Model model,HttpServletRequest request ) throws Exception{
        XQuery xQuery = new XQuery("listPurchaseOrder_default",request);
        xQuery.addRequestParamToModel(model,request);
        List list = baseManager.listPageInfo(xQuery).getList();

        model.addAttribute("list",list);
        return "/pc/purchaseOrder/purchaseOrderList";
    }

//    @RequestMapping(value = "/getOrder.do")
//    public String getOrder(Model model,HttpServletRequest request ) throws Exception{
//        XQuery xQuery = new XQuery("viewPurchaseOrder_getOrder",request);
//        List<Object> list = this.baseManager.listObject(xQuery);
//
//        PurchaseOrder purchaseOrder = new PurchaseOrder();
//        if (list != null && list.size() > 0){
//            purchaseOrder = (PurchaseOrder) list.get(0);
//        }
//
//        model.addAttribute("order",purchaseOrder);
//        return "/pc/purchaseOrder/purchaseOrderView";
//    }

    @RequestMapping(value = "/getOrder.do")
    public String getOrder(Model model,HttpServletRequest request ) throws Exception{
        PurchaseOrder purchaseOrder = (PurchaseOrder) baseManager.getObject(PurchaseOrder.class.getName(),request.getParameter("id"));
        model.addAttribute("order",purchaseOrder);
        return "/pc/purchaseOrder/purchaseOrderView";
    }

}
