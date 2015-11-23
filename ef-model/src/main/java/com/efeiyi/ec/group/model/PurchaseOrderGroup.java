package com.efeiyi.ec.group.model;

import com.efeiyi.ec.purchase.model.PurchaseOrder;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;

/**
 * Created by Administrator on 2015/11/4 0004.
 */
@Entity
@Table(name = "activity_purchase_order_group")
public class PurchaseOrderGroup {

    private String id;
    private PurchaseOrder purchaseOrder;
    private MyGroup myGroup;
    private GroupMember groupMember;
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
    public MyGroup getMyGroup() {
        return myGroup;
    }

    public void setMyGroup(MyGroup myGroup) {
        this.myGroup = myGroup;
    }

    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "member_id")
    public GroupMember getGroupMember() {
        return groupMember;
    }

    public void setGroupMember(GroupMember groupMember) {
        this.groupMember = groupMember;
    }

    @Column(name = "status")
    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
