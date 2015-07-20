package com.efeiyi.pal.purchase.model;

import com.efeiyi.pal.label.model.LabelBatch;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;

/**
 * Created by Administrator on 2015/7/16.
 */

@Entity
@Table(name = "purchase_order_label_batch")
public class PurchaseOrderLabelBatch {

    private String id;
    private PurchaseOrder purchaseOrder;
    private LabelBatch labelBatch;

    @Id
    @GenericGenerator(name = "id", strategy = "com.ming800.core.p.model.M8idGenerator")
    @GeneratedValue(generator = "id")
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "purchase_order_id")
    public PurchaseOrder getPurchaseOrder() {
        return purchaseOrder;
    }

    public void setPurchaseOrder(PurchaseOrder purchaseOrder) {
        this.purchaseOrder = purchaseOrder;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "label_batch_id")
    public LabelBatch getLabelBatch() {
        return labelBatch;
    }

    public void setLabelBatch(LabelBatch labelBatch) {
        this.labelBatch = labelBatch;
    }

}
