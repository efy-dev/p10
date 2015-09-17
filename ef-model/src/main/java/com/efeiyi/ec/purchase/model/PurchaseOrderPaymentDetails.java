package com.efeiyi.ec.purchase.model;

import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.math.BigDecimal;

/**
 * Created by Administrator on 2015/9/16 0016.
 */
@Entity
@Table(name = "purchase_order_payment_details")
public class PurchaseOrderPaymentDetails {


    private String id ;
    private String payWay;
    private BigDecimal money;
    private Coupon coupon;
    private PurchaseOrderPayment purchaseOrderPayment;
    private String transactionNumber; //交易号


    @Id
    @GenericGenerator(name = "id", strategy = "com.ming800.core.p.model.M8idGenerator")
    @GeneratedValue(generator = "id")
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    @Column(name = "payway")
    public String getPayWay() {
        return payWay;
    }

    public void setPayWay(String payWay) {
        this.payWay = payWay;
    }

    @Column(name = "money")
    public BigDecimal getMoney() {
        return money;
    }

    public void setMoney(BigDecimal money) {
        this.money = money;
    }

    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "coupon_id")
    public Coupon getCoupon() {
        return coupon;
    }

    public void setCoupon(Coupon coupon) {
        this.coupon = coupon;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "purchase_order_payment_id")
    public PurchaseOrderPayment getPurchaseOrderPayment() {
        return purchaseOrderPayment;
    }

    public void setPurchaseOrderPayment(PurchaseOrderPayment purchaseOrderPayment) {
        this.purchaseOrderPayment = purchaseOrderPayment;
    }

    @Column(name = "transaction_number")
    public String getTransactionNumber() {
        return transactionNumber;
    }

    public void setTransactionNumber(String transactionNumber) {
        this.transactionNumber = transactionNumber;
    }
}
