package com.efeiyi.ec.purchase.model;

import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.util.Date;


/**
 * Created by Administrator on 2015/9/17.
 */
@Entity
@Table(name = "purchase_order_business_reply")
public class PurchaseOrderBusinessReply{
    private String id;
    private String reply;
    private PurchaseOrderComment purchaseOrderComment;
    private Date createDatetime;

    @Id
    @GenericGenerator(name = "id", strategy = "com.ming800.core.p.model.M8idGenerator")
    @GeneratedValue(generator = "id")
    public String getId() {
        return id;
    }
    public void setId(String id) {
        this.id = id;
    }
    @Column(name ="reply")
    public String getReply() {
        return reply;
    }

    public void setReply(String reply) {
        this.reply = reply;
    }

    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "purchase_order_comment_id")
    public PurchaseOrderComment getPurchaseOrderComment() {
        return purchaseOrderComment;
    }
    public void setPurchaseOrderComment(PurchaseOrderComment purchaseOrderComment) {
        this.purchaseOrderComment = purchaseOrderComment;
    }
    @Column(name = "create_datetime")
    public Date getCreateDatetime() {
        return createDatetime;
    }

    public void setCreateDatetime(Date createDatetime) {
        this.createDatetime = createDatetime;
    }

    @Override
    public String toString() {
        return "PurchaseOrderBusinessReply{id = " + id + "}";
    }
}


