package com.efeiyi.ec.product.model;

import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;

/**
 * Created by Administrator on 2015/10/22 0022.
 */
@Entity
@Table(name = "advertisement")
public class Advertisement {

    private String id;
    private String name;
    private String img;
    private String redirect;
    private Integer adsOrder;
    private String status;
    private String price;
    private String groupName;
    private String wapRedirect;//移动跳转链接
    @Column(name = "price")
    public String getPrice() {
        return price;
    }

    public void setPrice(String price) {
        this.price = price;
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

    @Column(name = "img")
    public String getImg() {
        return img;
    }

    public void setImg(String img) {
        this.img = img;
    }

    @Column(name = "redirect")
    public String getRedirect() {
        return redirect;
    }

    public void setRedirect(String redirect) {
        this.redirect = redirect;
    }

    @Column(name = "name")
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Column(name = "ads_order")
    public Integer getAdsOrder() {
        return adsOrder;
    }

    public void setAdsOrder(Integer adsOrder) {
        this.adsOrder = adsOrder;
    }

    @Column(name = "status")
    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Column(name = "group_name")
    public String getGroupName() {
        return groupName;
    }

    public void setGroupName(String groupName) {
        this.groupName = groupName;
    }

    @Column(name = "wap_redirect")
    public String getWapRedirect() {
        return wapRedirect;
    }

    public void setWapRedirect(String wapRedirect) {
        this.wapRedirect = wapRedirect;
    }

    @Override
    public String toString() {
        return "Advertisement{id = " + id + "}";
    }
}
