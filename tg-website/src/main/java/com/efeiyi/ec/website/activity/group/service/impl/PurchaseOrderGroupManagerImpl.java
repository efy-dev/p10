package com.efeiyi.ec.website.activity.group.service.impl;

import com.efeiyi.ec.activity.group.model.GroupProduct;
import com.efeiyi.ec.activity.group.model.PurchaseOrderGroup;
import com.efeiyi.ec.purchase.model.PurchaseOrder;
import com.efeiyi.ec.purchase.model.PurchaseOrderProduct;
import com.efeiyi.ec.website.activity.group.service.PurchaseOrderGroupManager;
import com.ming800.core.base.service.BaseManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Created by Administrator on 2015/12/15.
 */
@Service
public class PurchaseOrderGroupManagerImpl implements PurchaseOrderGroupManager {

    @Autowired
    private BaseManager baseManager;


    @Override
    public PurchaseOrder createPurchaseOrder(GroupProduct groupProduct) {
        //生成团购订单
        PurchaseOrderGroup purchaseOrderGroup = new PurchaseOrderGroup();
        purchaseOrderGroup.setTotal(groupProduct.getGroupPrice());
        purchaseOrderGroup.setTenant(groupProduct.getProductModel().getProduct().getTenant());
        purchaseOrderGroup.setOrderType("4");
        baseManager.saveOrUpdate(PurchaseOrderGroup.class.getName(), purchaseOrderGroup);

        //生成订单商品
        PurchaseOrder purchaseOrder = (PurchaseOrder) baseManager.getObject(PurchaseOrder.class.getName(), purchaseOrderGroup.getId());
        PurchaseOrderProduct purchaseOrderProduct = new PurchaseOrderProduct();
        purchaseOrderProduct.setProductModel(groupProduct.getProductModel());
        purchaseOrderProduct.setPurchaseAmount(1);
        purchaseOrderProduct.setPurchasePrice(groupProduct.getGroupPrice());
        purchaseOrderProduct.setPurchaseOrder(purchaseOrder);
        baseManager.saveOrUpdate(PurchaseOrderProduct.class.getName(), purchaseOrderProduct);

        return purchaseOrder;
    }
}
