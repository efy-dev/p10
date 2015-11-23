package com.efeiyi.ec.website.order.service;

import com.efeiyi.ec.organization.model.ConsumerAddress;
import com.efeiyi.ec.purchase.model.Cart;
import com.efeiyi.ec.purchase.model.PurchaseOrder;
import org.springframework.ui.Model;

import java.util.HashMap;

/**
 * Created by Administrator on 2015/10/21 0021.
 */
public interface PurchaseOrderManager {

    /*
        生成订单包含几个步骤
        1.生成主订单
        2.生成子订单
        3.
     */
    PurchaseOrder saveOrUpdatePurchaseOrder(Cart cart, Model model) throws Exception;

    PurchaseOrder confirmPurchaseOrder(PurchaseOrder purchaseOrder, ConsumerAddress consumerAddress, HashMap<String, String> messageMap, String payWay);



}
