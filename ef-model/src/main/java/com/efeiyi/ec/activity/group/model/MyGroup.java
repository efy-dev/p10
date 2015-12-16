package com.efeiyi.ec.activity.group.model;

import com.efeiyi.ec.organization.model.User;
import org.hibernate.annotations.GenericGenerator;
import org.hibernate.annotations.Where;

import javax.persistence.*;
import java.util.Date;
import java.util.List;

/**
 * Created by Administrator on 2015/10/21.
 */
@Entity
@Table(name = "activity_group")
public class MyGroup {
    private String id;
    private GroupProduct groupProduct;//团购商品
    private List<GroupMember> groupMemberList;
    private String status; //0:取消 1：进行中 2:未激活 3：组团成功团已关闭 4：拼团成功并且团未关闭 5： 组团失败
    private Date createDateTime;
    private List<PurchaseOrderGroup> purchaseOrderGroupList;
    private User manUser;

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
    @JoinColumn(name = "group_product_id")
    public GroupProduct getGroupProduct() {
        return groupProduct;
    }

    public void setGroupProduct(GroupProduct groupProduct) {
        this.groupProduct = groupProduct;
    }

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "myGroup", cascade = CascadeType.ALL)
    public List<GroupMember> getGroupMemberList() {
        return groupMemberList;
    }

    public void setGroupMemberList(List<GroupMember> groupMemberList) {
        this.groupMemberList = groupMemberList;
    }

    @Column(name = "status")
    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Column(name = "create_datetime")
    public Date getCreateDateTime() {
        return createDateTime;
    }

    public void setCreateDateTime(Date createDateTime) {
        this.createDateTime = createDateTime;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "man_user_id")
    public User getManUser() {
        return manUser;
    }

    public void setManUser(User manUser) {
        this.manUser = manUser;
    }

    @OneToMany(fetch = FetchType.LAZY ,mappedBy = "myGroup")
    @Where(clause = "status=1")
    public List<PurchaseOrderGroup> getPurchaseOrderGroupList() {
        return purchaseOrderGroupList;
    }

    public void setPurchaseOrderGroupList(List<PurchaseOrderGroup> purchaseOrderGroupList) {
        this.purchaseOrderGroupList = purchaseOrderGroupList;
    }
}
