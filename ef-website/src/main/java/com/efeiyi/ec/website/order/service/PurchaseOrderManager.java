package com.efeiyi.ec.website.order.service;

import com.efeiyi.ec.organization.model.ConsumerAddress;
import com.efeiyi.ec.product.model.ProductModel;
import com.efeiyi.ec.purchase.model.Cart;
import com.efeiyi.ec.purchase.model.PurchaseOrder;
import org.springframework.ui.Model;

import java.math.BigDecimal;
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

    /**
     * 购物车下单入口
     * @param cart
     * @param model
     * @return
     * @throws Exception
     */
    PurchaseOrder saveOrUpdatePurchaseOrder(Cart cart,Model model) throws Exception;

    /**
     * 单品下单入口
     * @param productModel 商品
     * @param price 单价
     * @param amount 数量
     * @param model
     * @return
     * @throws Exception
     */
    PurchaseOrder saveOrUpdatePurchaseOrder(ProductModel productModel, BigDecimal price, int amount, Model model) throws Exception;

    PurchaseOrder saveOrUpdatePurchaseOrder(PurchaseOrder purchaseOrder, Model model) throws Exception;

    PurchaseOrder confirmPurchaseOrder(PurchaseOrder purchaseOrder ,ConsumerAddress consumerAddress,HashMap<String, String> messageMap,String payWay);



}
