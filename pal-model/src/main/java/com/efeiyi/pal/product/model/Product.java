package com.efeiyi.pal.product.model;

import com.efeiyi.pal.organization.model.Tenant;
import com.efeiyi.pal.organization.model.TenantCertification;
import com.efeiyi.pal.organization.model.TenantSource;
import com.fasterxml.jackson.annotation.JsonIgnore;
import org.hibernate.annotations.GenericGenerator;
import org.hibernate.annotations.Where;

import javax.persistence.*;
import java.util.Date;
import java.util.List;


/**
 * Created by Administrator on 2015/7/15.
 */

@Entity
@Table(name = "product")
public class Product {

    private String id;
    private String name;
    private String serial;
    private ProductSeries productSeries;
    private Tenant tenant;
    private String masterName;
    private String status;
    private Date madeYear;
    private TenantSource tenantSource;
    private TenantCertification tenantCertification;
    private List<ProductPropertyValue> productPropertyValueList;
    private String imgUrl;
    private String shoppingUrl;

    @Id
    @GenericGenerator(name = "id", strategy = "com.ming800.core.p.model.M8idGenerator")
    @GeneratedValue(generator = "id")
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    @Column(name = "name")
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
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
    @JoinColumn(name = "product_series_id")
    @Where(clause = "status='1'")
    public ProductSeries getProductSeries() {
        return productSeries;
    }

    public void setProductSeries(ProductSeries productSeries) {
        this.productSeries = productSeries;
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

    @Column(name = "master_name")
    public String getMasterName() {
        return masterName;
    }

    public void setMasterName(String masterName) {
        this.masterName = masterName;
    }

    @Column(name = "status")
    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Column(name = "made_year")
    public Date getMadeYear() {
        return madeYear;
    }

    public void setMadeYear(Date madeYear) {
        this.madeYear = madeYear;
    }

    @JsonIgnore
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "tenant_source_id")
    public TenantSource getTenantSource() {
        return tenantSource;
    }

    public void setTenantSource(TenantSource tenantSource) {
        this.tenantSource = tenantSource;
    }

    @JsonIgnore
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "tenant_certification_id")
    public TenantCertification getTenantCertification() {
        return tenantCertification;
    }

    public void setTenantCertification(TenantCertification tenantCertification) {
        this.tenantCertification = tenantCertification;
    }

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "product")
    public List<ProductPropertyValue> getProductPropertyValueList() {
        return productPropertyValueList;
    }

    public void setProductPropertyValueList(List<ProductPropertyValue> productPropertyValueList) {
        this.productPropertyValueList = productPropertyValueList;
    }

    @Column(name = "img_url")
    public String getImgUrl() {
        return imgUrl;
    }

    public void setImgUrl(String imgUrl) {
        this.imgUrl = imgUrl;
    }

    @Column(name = "shopping_url")
    public String getShoppingUrl() {
        return shoppingUrl;
    }

    public void setShoppingUrl(String shoppingUrl) {
        this.shoppingUrl = shoppingUrl;
    }

}
