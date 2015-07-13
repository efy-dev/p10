package com.efeiyi.ec.purchase.model;

import com.efeiyi.ec.organization.model.ConsumerAddress;
import com.efeiyi.ec.organization.model.Consumer;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.util.Date;
import java.util.List;

/**
 * Created by Administrator on 2015/5/28.
 */
@Entity
@Table(name = "purchase_order")
public class PurchaseOrder {
    private String id;
    private String serial;
    private List<PurchaseOrderProduct> purchaseOrderProductList;
    private Date createDatetime;
    private String payWay;
    private Consumer user;
    private ConsumerAddress consumerAddress;

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

    @OneToMany(fetch = FetchType.LAZY)
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

    @Column(name = "payway")
    public String getPayWay() {
        return payWay;
    }

    public void setPayWay(String payWay) {
        this.payWay = payWay;
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
}
