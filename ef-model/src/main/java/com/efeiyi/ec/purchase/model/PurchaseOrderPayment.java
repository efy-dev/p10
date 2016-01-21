package com.efeiyi.ec.purchase.model;

import com.efeiyi.ec.organization.model.User;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

/**
 * Created by Administrator on 2015/5/28.
 */
@Entity
@Table(name = "purchase_order_payment")
public class PurchaseOrderPayment {
    private String id;
    private String  transactionNumber; //交易号
    private PurchaseOrder purchaseOrder;
    private Date createDateTime;
    private BigDecimal paymentAmount; //支付金额
    private String payWay;//订单的支付方式 1支付宝 2银行卡 3微信 4优惠券 5.余额
    private List<PurchaseOrderPaymentDetails> purchaseOrderPaymentDetailsList;
    private User user;
    private String serial;//支付记录编号
    private String status;//1待支付  2已支付 3 支付失败~  4 已退款

    @Id
    @GenericGenerator(name = "id", strategy = "com.ming800.core.p.model.M8idGenerator")
    @GeneratedValue(generator = "id")
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "purchase_order_id")
    public PurchaseOrder getPurchaseOrder() {
        return purchaseOrder;
    }

    public void setPurchaseOrder(PurchaseOrder purchaseOrder) {
        this.purchaseOrder = purchaseOrder;
    }

    @Column(name = "create_datetime")
    public Date getCreateDateTime() {
        return createDateTime;
    }

    public void setCreateDateTime(Date createDateTime) {
        this.createDateTime = createDateTime;
    }

    @Column(name = "payway")
    public String getPayWay() {
        return payWay;
    }

    public void setPayWay(String payWay) {
        this.payWay = payWay;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name="user_id")
    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    @Column(name = "payment_amount")
    public BigDecimal getPaymentAmount() {
        return paymentAmount;
    }

    public void setPaymentAmount(BigDecimal paymentAmount) {
        this.paymentAmount = paymentAmount;
    }

    @Column(name = "serial")
    public String getSerial() {
        return serial;
    }

    public void setSerial(String serial) {
        this.serial = serial;
    }

    @Column(name = "status")
    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Column(name = "transaction_number")
    public String getTransactionNumber() {
        return transactionNumber;
    }

    public void setTransactionNumber(String transactionNumber) {
        this.transactionNumber = transactionNumber;
    }

    @OneToMany(fetch = FetchType.LAZY,mappedBy = "purchaseOrderPayment")
    public List<PurchaseOrderPaymentDetails> getPurchaseOrderPaymentDetailsList() {
        return purchaseOrderPaymentDetailsList;
    }

    public void setPurchaseOrderPaymentDetailsList(List<PurchaseOrderPaymentDetails> purchaseOrderPaymentDetailsList) {
        this.purchaseOrderPaymentDetailsList = purchaseOrderPaymentDetailsList;
    }

    @Override
    public String toString() {
        return "PurchaseOrderPayment{id = " + id + "}";
    }
}
