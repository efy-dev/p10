package com.efeiyi.ec.purchase.model;

import com.efeiyi.ec.organization.model.Consumer;
import com.fasterxml.jackson.annotation.JsonIgnore;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;

/**
 * Created by Administrator on 2015/8/10.
 */
@Entity
@Table(name = "purchase_coupon")
public class Coupon implements Serializable {
    private String id;
    private String serial;//优惠券的编号
    private CouponBatch couponBatch;//批次
    private String status;//1未使用 2已使用 3关闭
    private String uniqueKey;
    private Consumer consumer;
    private String rangeLabel;
    private String startTimeL;
    private String endTimeL;
    private String isUseful;
    private String whetherBind;//优惠券是否绑定 1-未绑定  2-已绑定
    private Date bindTime;//绑定时间

    @Column(name = "bind_time")
    public Date getBindTime() {
        return bindTime;
    }

    public void setBindTime(Date bindTime) {
        this.bindTime = bindTime;
    }

    @Column(name = "cdkey")
    public String getUniqueKey() {
        return uniqueKey;
    }

    public void setUniqueKey(String uniqueKey) {
        this.uniqueKey = uniqueKey;
    }

    @Transient
    public String getIsUseful() {
        return isUseful;
    }

    public void setIsUseful(String isUseful) {
        this.isUseful = isUseful;
    }

    @Transient
    public String getStartTimeL() {
        return startTimeL;
    }

    public void setStartTimeL(String startTimeL) {
        this.startTimeL = startTimeL;
    }

    @Transient
    public String getEndTimeL() {
        return endTimeL;
    }

    public void setEndTimeL(String endTimeL) {
        this.endTimeL = endTimeL;
    }

    @Transient
    public String getRangeLabel() {
        return rangeLabel;
    }

    public void setRangeLabel(String rangeLabel) {
        this.rangeLabel = rangeLabel;
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
    @JoinColumn(name = "coupon_batch_id")
    public CouponBatch getCouponBatch() {
        return couponBatch;
    }

    public void setCouponBatch(CouponBatch couponBatch) {
        this.couponBatch = couponBatch;
    }

    @Column(name = "status")
    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Column(name = "serial")
    public String getSerial() {
        return serial;
    }

    public void setSerial(String serial) {
        this.serial = serial;
    }

    @JsonIgnore
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "consumer_id")
    public Consumer getConsumer() {
        return consumer;
    }

    public void setConsumer(Consumer consumer) {
        this.consumer = consumer;
    }

    @Column(name = "isbind")
    public String getWhetherBind() {
        return whetherBind;
    }

    public void setWhetherBind(String whetherBind) {
        this.whetherBind = whetherBind;
    }


    @Override
    public String toString() {
        return "Coupon{id = " + id + "}";
    }
}
