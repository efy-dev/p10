package com.efeiyi.ec.activity.group.model;

import com.efeiyi.ec.purchase.model.PurchaseOrder;

import javax.persistence.*;

/**
 * Created by Administrator on 2015/11/4 0004.
 */
@Entity
@Table(name = "activity_purchase_order_group")
public class PurchaseOrderGroup extends PurchaseOrder{

    private MyGroup myGroup;
    private GroupMember groupMember;

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
//    @Override
//    public String toString(){
//        return  "PurchaseOrderGroup{myGroupId = "+myGroup.getId()+";GroupMember = "+groupMember.getId()+"}";
//    }
}
