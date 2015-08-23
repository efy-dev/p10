package com.efeiyi.pal.product.model;

import com.efeiyi.pal.organization.model.Tenant;
import com.efeiyi.pal.organization.model.TenantSource;
import com.fasterxml.jackson.annotation.JsonIgnore;
import org.hibernate.annotations.GenericGenerator;
import org.hibernate.annotations.Where;

import java.util.List;

import javax.persistence.*;

/**
 * Created by Administrator on 2015/8/22.
 */
@Entity
@Table(name = "tenant_product_series")
public class TenantProductSeries {

    private String id;
    private Tenant tenant;
    private ProductSeries productSeries;
    private String status;
    private List<TenantSource> tenantSourceList;

    @Id
    @GenericGenerator(name = "id", strategy = "com.ming800.core.p.model.M8idGenerator")
    @GeneratedValue(generator = "id")
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
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
    @JoinColumn(name = "product_series_id")
    public ProductSeries getProductSeries() {
        return productSeries;
    }

    public void setProductSeries(ProductSeries productSeries) {
        this.productSeries = productSeries;
    }

    @Column(name = "status")
    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @JsonIgnore
    @OneToMany(fetch = FetchType.LAZY, mappedBy = "tenantProductSeries")
    @Where(clause = "status = '1'")
    public List<TenantSource> getTenantSourceList() {
        return tenantSourceList;
    }

    public void setTenantSourceList(List<TenantSource> tenantSourceList) {
        this.tenantSourceList = tenantSourceList;
    }
}
