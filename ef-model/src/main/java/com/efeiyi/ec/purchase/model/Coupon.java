package com.efeiyi.ec.purchase.model;

import com.efeiyi.ec.organization.model.Consumer;
import com.fasterxml.jackson.annotation.JsonIgnore;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.io.Serializable;

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
    private String cdkey;
    private Consumer consumer;

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

    @Column(name = "cdkey")
    public String getCdkey() {
        return cdkey;
    }

    public void setCdkey(String cdkey) {
        this.cdkey = cdkey;
    }
}
