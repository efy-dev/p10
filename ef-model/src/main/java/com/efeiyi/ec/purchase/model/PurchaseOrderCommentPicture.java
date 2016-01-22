package com.efeiyi.ec.purchase.model;

import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;

/**
 * Created by Administrator on 2015/9/17 0017.
 */
@Entity
@Table(name = "purchase_order_comment_picture")
public class PurchaseOrderCommentPicture {

    private String id ;
    private String pictureUrl;
    private String status;
    private PurchaseOrderComment purchaseOrderComment;

    @Id
    @GenericGenerator(name = "id", strategy = "com.ming800.core.p.model.M8idGenerator")
    @GeneratedValue(generator = "id")
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    @Column(name = "picture_url")
    public String getPictureUrl() {
        return pictureUrl;
    }

    public void setPictureUrl(String pictureUrl) {
        this.pictureUrl = pictureUrl;
    }

    @Column(name = "status")
    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "purchase_order_comment_id")
    public PurchaseOrderComment getPurchaseOrderComment() {
        return purchaseOrderComment;
    }

    public void setPurchaseOrderComment(PurchaseOrderComment purchaseOrderComment) {
        this.purchaseOrderComment = purchaseOrderComment;
    }

    @Override
    public String toString() {
        return "PurchaseOrderCommentPicture{id = " + id + "}";
    }
}
