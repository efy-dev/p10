package com.efeiyi.ec.group.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.util.Date;
import java.util.List;

/**
 * Created by Administrator on 2015/10/21.
 */
@Entity
@Table(name = "group")
public class Group {
    private String id;
    private GroupProduct groupProduct;//团购商品
    private List<Member> memberList;
    private String status;
    private Date createDateTime;
    private Member manMember;

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

    @JsonIgnore
    @OneToMany(fetch = FetchType.LAZY, mappedBy = "member")
    public List<Member> getMemberList() {
        return memberList;
    }

    public void setMemberList(List<Member> memberList) {
        this.memberList = memberList;
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

    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "manmember_id")
    public Member getManMember() {
        return manMember;
    }

    public void setManMember(Member manMember) {
        this.manMember = manMember;
    }
}
