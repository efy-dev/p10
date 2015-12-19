package com.efeiyi.ec.zero.virtual.model;

import com.efeiyi.ec.purchase.model.PurchaseOrder;

import javax.persistence.*;

/**
 * Created by Administrator on 2015/11/26.
 */
@Entity
@Table(name = "virtual_purchase_order")
public class VirtualPurchaseOrder extends PurchaseOrder{

    private VirtualOrderPlan virtualOrderPlan;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "virtual_order_plan_id")
    public VirtualOrderPlan getVirtualOrderPlan() {
        return virtualOrderPlan;
    }

    public void setVirtualOrderPlan(VirtualOrderPlan virtualOrderPlan) {
        this.virtualOrderPlan = virtualOrderPlan;
    }
}
