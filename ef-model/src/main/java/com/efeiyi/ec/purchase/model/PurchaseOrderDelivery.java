package com.efeiyi.ec.purchase.model;

import com.efeiyi.ec.organization.model.ConsumerAddress;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.util.Date;

/**
 * Created by Administrator on 2015/5/28.
 */
@Entity
@Table(name = "purchase_order_delivery")
public class PurchaseOrderDelivery {
    private String id;
    private PurchaseOrder purchaseOrder;
    private ConsumerAddress consumerAddress;
    private Date createDateTime;
    private String serial;
    private String status; // 1已发货 2未发货
    private String logisticsCompany;//物流公司
    private String bigPen; //物流bigpen

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
    @JoinColumn(name = "purchase_order_id")
    public PurchaseOrder getPurchaseOrder() {
        return purchaseOrder;
    }

    public void setPurchaseOrder(PurchaseOrder purchaseOrder) {
        this.purchaseOrder = purchaseOrder;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name="user_address_id")
    public ConsumerAddress getConsumerAddress() {
        return consumerAddress;
    }

    public void setConsumerAddress(ConsumerAddress consumerAddress) {
        this.consumerAddress = consumerAddress;
    }

    @Column(name = "create_datetime")
    public Date getCreateDateTime() {
        return createDateTime;
    }

    public void setCreateDateTime(Date createDateTime) {
        this.createDateTime = createDateTime;
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

    @Column(name= "logistics_company")
    public String getLogisticsCompany() {
        return logisticsCompany;
    }

    public void setLogisticsCompany(String logisticsCompany) {
        this.logisticsCompany = logisticsCompany;
    }

    @Column(name = "big_pen")
    public String getBigPen() {
        return bigPen;
    }

    public void setBigPen(String bigPen) {
        this.bigPen = bigPen;
    }


    @Override
    public String toString() {
        return "PurchaseOrderDelivery{id = " + id + "}";
    }
}
