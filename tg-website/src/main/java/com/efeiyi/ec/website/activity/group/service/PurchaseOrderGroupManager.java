package com.efeiyi.ec.website.activity.group.service;

import com.efeiyi.ec.activity.group.model.GroupProduct;
import com.efeiyi.ec.purchase.model.PurchaseOrder;

/**
 * Created by Administrator on 2015/12/15.
 */
public interface PurchaseOrderGroupManager {
    public PurchaseOrder createPurchaseOrder(GroupProduct groupProduct);
}
