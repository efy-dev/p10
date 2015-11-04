package com.efeiyi.ec.purchase.model;

import com.efeiyi.ec.group.model.Group;
import com.efeiyi.ec.group.model.Member;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;

/**
 * Created by Administrator on 2015/11/4 0004.
 */
@Entity
@Table(name = "purchase_order_group")
public class PurchaseOrderGroup {

    private String id;
    private PurchaseOrder purchaseOrder;
    private Group group;
    private Member member;
    private String status; //0删除 1不删除

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
    @JoinColumn(name = "group_id")
    public Group getGroup() {
        return group;
    }

    public void setGroup(Group group) {
        this.group = group;
    }

    public Member getMember() {
        return member;
    }
    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "member_id")
    public void setMember(Member member) {
        this.member = member;
    }

    @Column(name = "status")
    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
