package com.efeiyi.ec.organization.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;
import java.util.List;

/**
 * Created by Administrator on 2016/9/2 0002.
 */
@Entity
@Table(name = "image")
@Inheritance(strategy = InheritanceType.JOINED)
@JsonIgnoreProperties(value = {"hibernateLazyInitializer", "handler"})
public class Image implements Serializable {

    private String id;
    private String name;
    private String src;
    private String owner;
    private String status;
    private String type;   //1.image 2.audio 3.video
    private Date createTime;
    private List<HotSpot> hotSpotList;

    public Image() {
    }

    public Image(String name, String src, String owner, String status, String type) {
        this.name = name;
        this.src = src;
        this.owner = owner;
        this.status = status;
        this.type = type;
        this.createTime = new Date();
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

    @Column(name = "name")
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Column(name = "src")
    public String getSrc() {
        return src;
    }

    public void setSrc(String src) {
        this.src = src;
    }

    @Column(name = "owner_id")
    public String getOwner() {
        return owner;
    }

    public void setOwner(String owner) {
        this.owner = owner;
    }

    @Column(name = "status")
    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Column(name = "type")
    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    @Column(name = "create_time")
    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    @JsonIgnore
    @OneToMany(fetch = FetchType.LAZY, mappedBy = "image")
    public List<HotSpot> getHotSpotList() {
        return hotSpotList;
    }

    public void setHotSpotList(List<HotSpot> hotSpotList) {
        this.hotSpotList = hotSpotList;
    }
}
