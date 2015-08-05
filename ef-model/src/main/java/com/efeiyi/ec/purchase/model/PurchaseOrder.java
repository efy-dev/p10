package com.efeiyi.ec.purchase.model;

import com.efeiyi.ec.organization.model.ConsumerAddress;
import com.efeiyi.ec.organization.model.Consumer;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

/**
 * Created by Administrator on 2015/5/28.
 */
@Entity
@Table(name = "purchase_order")
public class PurchaseOrder {

    public static String ORDER_STATUS_WPAY = "1";  //等待付款
    public static String ORDER_STATUS_WRECEIVE = "5"; //等待收货
    public static String ORDER_STATUS_UNCOMMENT = "9"; //未评价
    public static String ORDER_STATUS_FINISHED = "13"; //已完成
    public static String ORDER_STATUS_CONSEL = "17"; //已取消

    private String id;
    private String serial;          //订单号
    private List<PurchaseOrderProduct> purchaseOrderProductList;
    private List<PurchaseOrderDelivery> purchaseOrderDeliveryList;  //发货记录 订单配送
    private List<PurchaseOrderPayment> purchaseOrderPaymentList;
    private Date createDatetime;       //下单时间
    private Consumer user;
    private ConsumerAddress consumerAddress;  //收获地址
    private String status;
    private BigDecimal total;  //订单总价
    private String orderStatus; //订单状态

    @Id
    @GenericGenerator(name = "id", strategy = "com.ming800.core.p.model.M8idGenerator")
    @GeneratedValue(generator = "id")
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    @Column(name = "serial")
    public String getSerial() {
        return serial;
    }

    public void setSerial(String serial) {
        this.serial = serial;
    }

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "purchaseOrder", cascade = CascadeType.ALL)
    public List<PurchaseOrderProduct> getPurchaseOrderProductList() {
        return purchaseOrderProductList;
    }

    public void setPurchaseOrderProductList(List<PurchaseOrderProduct> purchaseOrderProductList) {
        this.purchaseOrderProductList = purchaseOrderProductList;
    }

    @Column(name = "create_datetime")
    public Date getCreateDatetime() {
        return createDatetime;
    }

    public void setCreateDatetime(Date createDatetime) {
        this.createDatetime = createDatetime;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id")
    public Consumer getUser() {
        return user;
    }

    public void setUser(Consumer user) {
        this.user = user;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name="user_address_id")
    public ConsumerAddress getConsumerAddress() {
        return consumerAddress;
    }

    public void setConsumerAddress(ConsumerAddress consumerAddress) {
        this.consumerAddress = consumerAddress;
    }


    @OneToMany(fetch = FetchType.LAZY, mappedBy = "purchaseOrder", cascade = CascadeType.ALL)
    public List<PurchaseOrderDelivery> getPurchaseOrderDeliveryList() {
        return purchaseOrderDeliveryList;
    }

    public void setPurchaseOrderDeliveryList(List<PurchaseOrderDelivery> purchaseOrderDeliveryList) {
        this.purchaseOrderDeliveryList = purchaseOrderDeliveryList;
    }

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "purchaseOrder", cascade = CascadeType.ALL)
    public List<PurchaseOrderPayment> getPurchaseOrderPaymentList() {
        return purchaseOrderPaymentList;
    }

    public void setPurchaseOrderPaymentList(List<PurchaseOrderPayment> purchaseOrderPaymentList) {
        this.purchaseOrderPaymentList = purchaseOrderPaymentList;
    }

    @Column(name = "status")
    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Column(name = "total")
    public BigDecimal getTotal() {
        return total;
    }

    public void setTotal(BigDecimal total) {
        this.total = total;
    }

    @Column(name = "order_status")
    public String getOrderStatus() {
        return orderStatus;
    }

    public void setOrderStatus(String orderStatus) {
        this.orderStatus = orderStatus;
    }
}
