package com.efeiyi.ec.group.model;

import com.efeiyi.ec.organization.model.BigUser;
import com.fasterxml.jackson.annotation.JsonIgnore;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.util.List;

/**
 * Created by Administrator on 2015/10/20.
 */
@Entity
@Table(name = "member")
public class Member {

    private String id;
    private BigUser user;//用户
    private String level;//
    private Member supMember;
    private List<Member> subMemberList;
    private String status;

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
    public BigUser getUser() {
        return user;
    }

    public void setUser(BigUser user) {
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
    public Member getSupMember() {
        return supMember;
    }

    public void setSupMember(Member supMember) {
        this.supMember = supMember;
    }

    @JsonIgnore
    @OneToMany(fetch = FetchType.LAZY, mappedBy = "member")
    public List<Member> getSubMemberList() {
        return subMemberList;
    }

    public void setSubMemberList(List<Member> subMemberList) {
        this.subMemberList = subMemberList;
    }

    @Column(name = "status")
    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
