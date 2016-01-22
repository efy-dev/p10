package com.efeiyi.ec.activity.group.model;

import com.efeiyi.ec.organization.model.User;
import com.fasterxml.jackson.annotation.JsonIgnore;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

/**
 * Created by Administrator on 2015/10/20.
 */
@Entity
@Table(name = "activity_member")
public class GroupMember implements Serializable {

    private String id;
    private User user;//用户
    private String level;//
    private GroupMember supGroupMember;
    private List<GroupMember> subGroupMemberList;
    private String status;//0:取消 1进行中 2:未激活 3：组团成功 5：组团失败
    private MyGroup myGroup;
    private BigDecimal redPacket;
    private Date createDateTime;

    @Column(name = "create_datetime")
    public Date getCreateDateTime() {
        return createDateTime;
    }

    public void setCreateDateTime(Date createDateTime) {
        this.createDateTime = createDateTime;
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
    @JoinColumn(name = "user_id")
    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    @Column(name = "level")
    public String getLevel() {
        return level;
    }

    public void setLevel(String level) {
        this.level = level;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "sup_member_id")
    public GroupMember getSupGroupMember() {
        return supGroupMember;
    }

    public void setSupGroupMember(GroupMember supGroupMember) {
        this.supGroupMember = supGroupMember;
    }

    @JsonIgnore
    @OneToMany(fetch = FetchType.LAZY, mappedBy = "supGroupMember")
    public List<GroupMember> getSubGroupMemberList() {
        return subGroupMemberList;
    }

    public void setSubGroupMemberList(List<GroupMember> subGroupMemberList) {
        this.subGroupMemberList = subGroupMemberList;
    }

    @Column(name = "status")
    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "group_id")
    public MyGroup getMyGroup() {
        return myGroup;
    }

    public void setMyGroup(MyGroup myGroup) {
        this.myGroup = myGroup;
    }

    @Column(name = "red_packet")
    public BigDecimal getRedPacket() {
        return redPacket;
    }

    public void setRedPacket(BigDecimal redPacket) {
        this.redPacket = redPacket;
    }

    @Override
    public String toString(){
        return  "GroupMember{id = "+id+"}";
    }
}
