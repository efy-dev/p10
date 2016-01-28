package com.efeiyi.ec.rebate.model;

import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.util.Date;

/**
 * Created by Administrator on 2016/1/14.
 */
@Entity
@Table(name = "rebate")
public class Rebate {
    private String id;
    private String userId;
    private String nickname;
    private String unionid;
    private String headurl;
    private Date createDateTime;
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
    @Column(name = "user_id")
    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }
    @Column(name = "nickname")
    public String getNickname() {
        return nickname;
    }

    public void setNickname(String nickname) {
        this.nickname = nickname;
    }
    @Column(name = "head_url ")
    public String getHeadurl() {
        return headurl;
    }
    @Column(name = "unionid")
    public String getUnionid() {
        return unionid;
    }

    public void setUnionid(String unionid) {
        this.unionid = unionid;
    }
    public void setHeadurl(String headurl) {
        this.headurl = headurl;
    }

    @Column(name = "create_date_time")
    public Date getCreateDateTime() {
        return createDateTime;
    }

    public void setCreateDateTime(Date createDateTime) {
        this.createDateTime = createDateTime;
    }

    @Column(name = "status")
    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "Rebate{id = " + id + "}";
    }
}
