package com.efeiyi.ec.organization.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import org.hibernate.annotations.GenericGenerator;
import org.hibernate.annotations.Where;

import javax.persistence.*;
import java.io.Serializable;
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
    private String status;
    private String count;
    private String idCard;
    private String orderNumber;

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

    @Column(name = "orderNumber")
    public String getOrderNumber() {
        return orderNumber;
    }

    public void setOrderNumber(String orderNumber) {
        this.orderNumber = orderNumber;
    }

    @Column(name = "idCard")
    public String getIdCard() {
        return idCard;
    }

    public void setIdCard(String idCard) {
        this.idCard = idCard;
    }

    @Column(name = "count")
    public String getCount() {
        return count;
    }

    public void setCount(String count) {
        this.count = count;
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
                ", date='" + date + '\'' +
                ", message='" + message + '\'' +
                ", status='" + status + '\'' +
                ", count='" + count + '\'' +
                ", idCard='" + idCard + '\'' +
                ", tenantOrders=" + tenantOrders +
                '}';
    }
}
