package com.efeiyi.ec.website.order.controller;

import com.efeiyi.ec.organization.model.MyUser;
import com.efeiyi.ec.purchase.model.PurchaseOrder;
import com.efeiyi.ec.website.organization.util.AuthorizationUtil;
import com.ming800.core.base.controller.BaseController;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import java.util.*;

/**
 * Created by Administrator on 2015/6/25.
 */
@Controller
@RequestMapping("/order")
public class PurchaseOrderController extends BaseController {
    @Autowired
    private BaseManager baseManager;


    @RequestMapping({"/list"})
    public String listPruchaseOrder(HttpServletRequest request, Model model) throws Exception {

        XQuery xQuery = new XQuery("plistPurchaseOrder_default", request);
        xQuery.addRequestParamToModel(model, request);

        List<Object> list = baseManager.listPageInfo(xQuery).getList();
        model.addAttribute("orderList", list);

        return "/purchaseOrder/orderList";

    }

    @RequestMapping({"/view/{orderId}"})
    public String viewPurchaseOrder(@PathVariable String orderId,Model model){

        Object order = baseManager.getObject(PurchaseOrder.class.getName(),orderId);
        model.addAttribute("order",order);

        return "/purchaseOrder/orderView";

    }


}
