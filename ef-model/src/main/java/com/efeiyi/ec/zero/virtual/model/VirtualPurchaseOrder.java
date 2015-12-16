package com.efeiyi.ec.zero.virtual.model;

import com.efeiyi.ec.purchase.model.PurchaseOrder;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;

/**
 * Created by Administrator on 2015/11/26.
 */
@Entity
@Table(name = "virtual_purchase_order")
public class VirtualPurchaseOrder {


    private String id;
    private PurchaseOrder purchaseOrder;
    private VirtualOrderPlan virtualOrderPlan;

    @Id
    @GenericGenerator(name = "id", strategy = "com.ming800.core.p.model.M8idGenerator")
    @GeneratedValue(generator = "id")
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "purchase_order_id")
    public PurchaseOrder getPurchaseOrder() {
        return purchaseOrder;
    }

    public void setPurchaseOrder(PurchaseOrder purchaseOrder) {
        this.purchaseOrder = purchaseOrder;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "virtual_order_plan_id")
    public VirtualOrderPlan getVirtualOrderPlan() {
        return virtualOrderPlan;
    }

    public void setVirtualOrderPlan(VirtualOrderPlan virtualOrderPlan) {
        this.virtualOrderPlan = virtualOrderPlan;
    }
}
