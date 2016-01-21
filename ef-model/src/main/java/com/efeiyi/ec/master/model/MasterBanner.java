package com.efeiyi.ec.master.model;

import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;

/**
 * Created by Administrator on 2015/7/20.
 */
@Entity
@Table(name = "master_banner")
public class MasterBanner {

    private String id;
    private String group;
    private String title;
    private Integer bannerOrder;
    private String imageUrl;
    private String directUrl;
    private String status;
    private Master master;

    @Id
    @GenericGenerator(name = "id", strategy = "com.ming800.core.p.model.M8idGenerator")
    @GeneratedValue(generator = "id")
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    @Column(name = "title")
    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    @Column(name = "banner_order")
    public Integer getBannerOrder() {
        return bannerOrder;
    }

    public void setBannerOrder(Integer bannerOrder) {
        this.bannerOrder = bannerOrder;
    }

    @Column(name = "image_url")
    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    @Column(name = "direct_url")
    public String getDirectUrl() {
        return directUrl;
    }

    public void setDirectUrl(String directUrl) {
        this.directUrl = directUrl;
    }

    @Column(name = "group_id")
    public String getGroup() {
        return group;
    }

    public void setGroup(String group) {
        this.group = group;
    }

    @Column(name = "the_status")
    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }


    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "master_id")
    public Master getMaster() {
        return master;
    }

    public void setMaster(Master master) {
        this.master = master;
    }


    @Override
    public String toString(){
        return  "MasterBanner{id = "+id+"}";
    }
}
