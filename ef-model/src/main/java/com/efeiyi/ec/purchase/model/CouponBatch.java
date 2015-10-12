package com.efeiyi.ec.purchase.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;
import java.util.List;

/**
 * Created by Administrator on 2015/8/10.
 */
@Entity
@Table(name = "purchase_coupon_batch")
@JsonIgnoreProperties(value = {"hibernateLazyInitializer", "handler"})
public class CouponBatch implements Serializable{
    private String id;
    private String name;
    private Integer amount;//生成优惠券数量
    private Date startDate;//生效日期
    private Date endDate;//失效日期
    private List<Coupon> couponList;
    private Float price;//优惠价格
    private String status;//批次装填
    private Integer isCreatedCoupon;//是否创建了优惠券
    private Float priceLimit;//使用限制价格 比如满100用
    private String pictureUrl;//优惠券图片

    @Transient
    public String getStartDateString() {
        return startDateString;
    }

    public void setStartDateString(String startDateString) {
        this.startDateString = startDateString;
    }

    @Transient
    public String getEndDateString() {
        return endDateString;
    }

    public void setEndDateString(String endDateString) {
        this.endDateString = endDateString;
    }

    private String startDateString;
    private String endDateString;

    @Column(name = "picture_url")
    public String getPictureUrl() {
        return pictureUrl;
    }

    public void setPictureUrl(String pictureUrl) {
        this.pictureUrl = pictureUrl;
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

    @Column(name = "amount")
    public Integer getAmount() {
        return amount;
    }

    public void setAmount(Integer amount) {
        this.amount = amount;
    }

    @Column(name = "price")
    public Float getPrice() {
        return price;
    }

    public void setPrice(Float price) {
        this.price = price;
    }

    @Column(name = "start_date")
    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    @Column(name = "end_date")
    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }

    @JsonIgnore
    @OneToMany(fetch = FetchType.LAZY,mappedBy = "couponBatch")
    public List<Coupon> getCouponList() {
        return couponList;
    }

    public void setCouponList(List<Coupon> couponList) {
        this.couponList = couponList;
    }

    @Column(name = "status")
    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Column(name = "is_created_coupon")
    public Integer getIsCreatedCoupon() {
        return isCreatedCoupon;
    }

    public void setIsCreatedCoupon(Integer isCreatedCoupon) {
        this.isCreatedCoupon = isCreatedCoupon;
    }

    @Column(name = "price_limit")
    public Float getPriceLimit() {
        return priceLimit;
    }

    public void setPriceLimit(Float priceLimit) {
        this.priceLimit = priceLimit;
    }
}
