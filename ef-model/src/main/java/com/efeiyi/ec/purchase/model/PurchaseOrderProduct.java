package com.efeiyi.ec.purchase.model;

import com.efeiyi.ec.product.model.Product;
import com.efeiyi.ec.product.model.ProductModel;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.math.BigDecimal;

/**
 * Created by Administrator on 2015/5/28.
 */
@Entity
@Table(name = "purchase_order_product")
public class PurchaseOrderProduct {
    private String id;
    private PurchaseOrder purchaseOrder;
    private ProductModel productModel;
    private Integer purchaseAmount;
    private BigDecimal purchasePrice;
    private PurchaseOrderComment purchaseOrderComment;
    private String status;//评价状态 0：未评价 1：已评价

    public PurchaseOrderProduct(PurchaseOrder purchaseOrder, ProductModel productModel, Integer purchaseAmount, BigDecimal purchasePrice) {
        this.purchaseOrder = purchaseOrder;
        this.productModel = productModel;
        this.purchaseAmount = purchaseAmount;
        this.purchasePrice = purchasePrice.setScale(2, BigDecimal.ROUND_HALF_UP);
    }

    public PurchaseOrderProduct() {
    }

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
    @JoinColumn(name = "product_id")
    public ProductModel getProductModel() {
        return productModel;
    }

    public void setProductModel(ProductModel productModel) {
        this.productModel = productModel;
    }


    @Column(name = "purchase_amount")
    public Integer getPurchaseAmount() {
        return purchaseAmount;
    }

    public void setPurchaseAmount(Integer purchaseAmount) {
        this.purchaseAmount = purchaseAmount;
    }

    @Column(name = "purchase_price")
    public BigDecimal getPurchasePrice() {
        return purchasePrice;
    }

    public void setPurchasePrice(BigDecimal purchasePrice) {
        this.purchasePrice = purchasePrice;
    }

    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "purchase_order_comment_id")
    public PurchaseOrderComment getPurchaseOrderComment() {
        return purchaseOrderComment;
    }

    public void setPurchaseOrderComment(PurchaseOrderComment purchaseOrderComment) {
        this.purchaseOrderComment = purchaseOrderComment;
    }

    @Column(name = "status")
    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
