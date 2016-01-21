package com.efeiyi.ec.purchase.model;

import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.util.Date;
import java.util.List;

/**
 * Created by Administrator on 2015/9/17 0017.
 */
@Entity
@Table(name = "purchase_order_comment")
public class PurchaseOrderComment {

    private String id ;
    private PurchaseOrderProduct purchaseOrderProduct;
    private PurchaseOrderComment subPurchaseOrderComment;
    private String starts;
    private List<PurchaseOrderCommentPicture> purchaseOrderCommentPictureList;
    private String status;
    private String content;
    private Date createDatetime;
    private PurchaseOrderBusinessReply purchaseOrderBusinessReply;


    @Column(name = "create_datetime")
    public Date getCreateDatetime() {
        return createDatetime;
    }

    public void setCreateDatetime(Date createDatetime) {
        this.createDatetime = createDatetime;
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

    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "purchase_order_product_id")
    public PurchaseOrderProduct getPurchaseOrderProduct() {
        return purchaseOrderProduct;
    }

    public void setPurchaseOrderProduct(PurchaseOrderProduct purchaseOrderProduct) {
        this.purchaseOrderProduct = purchaseOrderProduct;
    }

    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "sub_purchase_order_comment_id")
    public PurchaseOrderComment getSubPurchaseOrderComment() {
        return subPurchaseOrderComment;
    }

    public void setSubPurchaseOrderComment(PurchaseOrderComment subPurchaseOrderComment) {
        this.subPurchaseOrderComment = subPurchaseOrderComment;
    }

    @Column(name = "starts")
    public String getStarts() {
        return starts;
    }

    public void setStarts(String starts) {
        this.starts = starts;
    }

    @OneToMany(fetch =  FetchType.LAZY ,mappedBy = "purchaseOrderComment")
    public List<PurchaseOrderCommentPicture> getPurchaseOrderCommentPictureList() {
        return purchaseOrderCommentPictureList;
    }

    public void setPurchaseOrderCommentPictureList(List<PurchaseOrderCommentPicture> purchaseOrderCommentPictureList) {
        this.purchaseOrderCommentPictureList = purchaseOrderCommentPictureList;
    }

    @Column(name = "status")
    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
    @Column(name = "content")
    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }
    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "purchase_order_business_reply_id")
    public PurchaseOrderBusinessReply getPurchaseOrderBusinessReply() {
        return purchaseOrderBusinessReply;
    }

    public void setPurchaseOrderBusinessReply(PurchaseOrderBusinessReply purchaseOrderBusinessReply) {
        this.purchaseOrderBusinessReply = purchaseOrderBusinessReply;
    }

    @Override
    public String toString() {
        return "PurchaseOrderComment{id = " + id + "}";
    }
}
