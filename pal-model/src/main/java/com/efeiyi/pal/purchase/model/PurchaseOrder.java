package com.efeiyi.pal.purchase.model;

import com.efeiyi.pal.organization.model.Tenant;
import com.efeiyi.pal.organization.model.User;
import com.fasterxml.jackson.annotation.JsonIgnore;
import org.hibernate.annotations.GenericGenerator;
import org.hibernate.annotations.Where;

import javax.persistence.*;
import java.util.Date;
import java.util.List;

/**
 * Created by Administrator on 2015/7/16.
 */

@Entity
@Table(name = "purchase_order")
public class PurchaseOrder {

    private String id;
    private String serial;
    private Tenant tenant;
    private User user;
    private Date createDatetime;
    private String status;
    private List<PurchaseOrderLabel> purchaseOrderLabelList;
    private List<PurchaseOrderPayment> purchaseOrderPaymentList;

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

    @JsonIgnore
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "tenant_id")
    public Tenant getTenant() {
        return tenant;
    }

    public void setTenant(Tenant tenant) {
        this.tenant = tenant;
    }

    @JsonIgnore
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id")
    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    @Column(name = "create_datetime")
    public Date getCreateDatetime() {
        return createDatetime;
    }

    public void setCreateDatetime(Date createDatetime) {
        this.createDatetime = createDatetime;
    }

    @Column(name = "status")
    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @JsonIgnore
    @OneToMany(fetch = FetchType.LAZY, mappedBy = "purchaseOrder")
    @Where(clause = "status='1'")
    public List<PurchaseOrderLabel> getPurchaseOrderLabelList() {
        return purchaseOrderLabelList;
    }

    public void setPurchaseOrderLabelList(List<PurchaseOrderLabel> purchaseOrderLabelList) {
        this.purchaseOrderLabelList = purchaseOrderLabelList;
    }

    @JsonIgnore
    @OneToMany(fetch = FetchType.LAZY, mappedBy = "purchaseOrder")
    @Where(clause = "status='1'")
    public List<PurchaseOrderPayment> getPurchaseOrderPaymentList() {
        return purchaseOrderPaymentList;
    }

    public void setPurchaseOrderPaymentList(List<PurchaseOrderPayment> purchaseOrderPaymentList) {
        this.purchaseOrderPaymentList = purchaseOrderPaymentList;
    }

}
