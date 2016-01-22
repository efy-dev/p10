package com.efeiyi.ec.tenant.model;

import com.efeiyi.ec.product.model.Product;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.io.Serializable;

/**
 * Created by Administrator on 2015/7/17.
 */
@Entity
@Table(name = "tenant_product_tag")
@JsonIgnoreProperties(value = {"hibernateLazyInitializer", "handler"})
public class TenantProductTag implements Serializable {
    private String id;
    private TenantCategory tenantCategory;
    private Product product;
    private String status;

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
    @JoinColumn(name = "value")
    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "group_id")
    public TenantCategory getTenantCategory() {

        return tenantCategory;
    }

    public void setTenantCategory(TenantCategory tenantCategory) {
        this.tenantCategory = tenantCategory;
    }

    @Column(name="status")
    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "TenantProductTag{id = " + id + "}";
    }
}
