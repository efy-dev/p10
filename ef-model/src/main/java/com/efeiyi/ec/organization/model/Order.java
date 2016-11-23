package com.efeiyi.ec.organization.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import org.hibernate.annotations.GenericGenerator;
import org.hibernate.annotations.Where;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;
import java.util.List;

/**
 * Created by Administrator on 2016/11/22.
 */
@Entity
@Table(name = "garden_order")
@JsonIgnoreProperties(value = {"hibernateLazyInitializer", "handler"})
public class Order implements Serializable {
    private String id;
    private String name;
    private String phone;
    private String date;
    private String message;
    private BigUser bigUser;
    private String status;
    private String count;
    private String address;

    private List<TenantOrder> tenantOrders;

    @Id
    @GenericGenerator(name = "id", strategy = "com.ming800.core.p.model.M8idGenerator")
    @GeneratedValue(generator = "id")
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    @Column(name = "count")
    public String getCount() {
        return count;
    }

    public void setCount(String count) {
        this.count = count;
    }

    @Column(name = "address")
    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    @JsonIgnore
    @OneToMany(fetch = FetchType.LAZY, mappedBy = "order")
    public List<TenantOrder> getTenantOrders() {
        return tenantOrders;
    }

    public void setTenantOrders(List<TenantOrder> tenantOrders) {
        this.tenantOrders = tenantOrders;
    }

    @Column(name = "name")
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Column(name = "phone")
    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    @Column(name = "date")
    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    @Column(name = "message")
    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id")
    @JsonIgnore
    public BigUser getBigUser() {
        return bigUser;
    }

    public void setBigUser(BigUser bigUser) {
        this.bigUser = bigUser;
    }

    @Column(name = "status")
    @Where(clause = "status=1")
    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "Order{" +
                "id='" + id + '\'' +
                ", name='" + name + '\'' +
                ", phone='" + phone + '\'' +
                ", date=" + date +
                ", message='" + message + '\'' +
                ", bigUser=" + bigUser +
                ", status='" + status + '\'' +
                ", tenantOrders=" + tenantOrders +
                '}';
    }
}
