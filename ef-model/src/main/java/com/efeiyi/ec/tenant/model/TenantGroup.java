package com.efeiyi.ec.tenant.model;

import com.efeiyi.ec.product.model.ProductModel;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import org.hibernate.annotations.GenericGenerator;
import org.hibernate.annotations.Where;

import javax.persistence.*;
import java.util.List;

/**
 * Created by Administrator on 2016/12/5.
 */
@Entity
@Table(name = "tenant_group")
@JsonIgnoreProperties(value = {"hibernateLazyInitializer", "handler"})
public class TenantGroup {

    private String id;
    private BigTenant tenant;
    private String status;
    private String name;//组名
    private String pictureUrl;
    private String context;//分组简介
    private List<ProductModel> productModels;

    @JsonIgnore
    @OneToMany(fetch = FetchType.LAZY, mappedBy = "tenantGroup")
    public List<ProductModel> getProductModels() {
        return productModels;
    }

    public void setProductModels(List<ProductModel> productModels) {
        this.productModels = productModels;
    }

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
    public BigTenant getTenant() {
        return tenant;
    }

    public void setTenant(BigTenant tenant) {
        this.tenant = tenant;
    }

    public String getStatus() {
        return status;
    }

    @Column(name = "status")
    @Where(clause = "status=1")
    public void setStatus(String status) {
        this.status = status;
    }

    @Column(name = "name")
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Column(name = "picture_url")
    public String getPictureUrl() {
        return pictureUrl;
    }

    public void setPictureUrl(String pictureUrl) {
        this.pictureUrl = pictureUrl;
    }

    @Column(name = "context")
    public String getContext() {
        return context;
    }

    public void setContext(String context) {
        this.context = context;
    }
}
