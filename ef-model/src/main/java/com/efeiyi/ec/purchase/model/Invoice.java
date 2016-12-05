package com.efeiyi.ec.purchase.model;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;

/**
 * Created by WangTao on 2016/12/5 0005.
 * 发票
 */
@Entity
@Table(name = "invoice")
@JsonIgnoreProperties(value = {"hibernateLazyInitializer", "handler"})
public class Invoice {

    private String id;
    private String type;
    private PurchaseOrder purchaseOrder;
    private String title;
    private String name;
    private String status;


    @Id
    @GenericGenerator(name = "id", strategy = "com.ming800.core.p.model.M8idGenerator")
    @GeneratedValue(generator = "id")
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }


    @Column(name = "type")
    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "purchase_order_id")
    public PurchaseOrder getPurchaseOrder() {
        return purchaseOrder;
    }

    public void setPurchaseOrder(PurchaseOrder purchaseOrder) {
        this.purchaseOrder = purchaseOrder;
    }

    @Column(name = "title")
    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    @Column(name = "name")
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Column(name = "status")
    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}