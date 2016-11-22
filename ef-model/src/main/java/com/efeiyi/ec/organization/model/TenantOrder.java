package com.efeiyi.ec.organization.model;

import com.efeiyi.ec.tenant.model.BigTenant;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import org.hibernate.annotations.GenericGenerator;
import org.hibernate.annotations.Where;

import javax.persistence.*;

/**
 * Created by Administrator on 2016/11/22.
 */
@Entity
@Table(name = "tenant_order")
@JsonIgnoreProperties(value = {"hibernateLazyInitializer", "handler"})
public class TenantOrder {
    private String id;
    private String status;
    private Order order;
    private BigTenant bigTenant;

    @Id
    @GenericGenerator(name = "id", strategy = "com.ming800.core.p.model.M8idGenerator")
    @GeneratedValue(generator = "id")
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    @Column(name = "status")
    @Where(clause = "status=1")
    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "order_id")
    public Order getOrder() {
        return order;
    }

    public void setOrder(Order order) {
        this.order = order;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "tenant_id")
    @JsonIgnore
    public BigTenant getBigTenant() {
        return bigTenant;
    }

    public void setBigTenant(BigTenant bigTenant) {
        this.bigTenant = bigTenant;
    }

    @Override
    public String toString() {
        return "TenantOrder{" +
                "id='" + id + '\'' +
                ", status='" + status + '\'' +
                ", order=" + order +
                ", bigTenant=" + bigTenant +
                '}';
    }
}
