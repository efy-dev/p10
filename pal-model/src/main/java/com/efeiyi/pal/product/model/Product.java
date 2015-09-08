package com.efeiyi.pal.product.model;

import com.efeiyi.pal.organization.model.Tenant;
import com.efeiyi.pal.organization.model.TenantCertification;
import com.fasterxml.jackson.annotation.JsonIgnore;
import org.hibernate.annotations.GenericGenerator;
import org.hibernate.annotations.NotFound;
import org.hibernate.annotations.NotFoundAction;
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
    private String status;//1：商品图片 2：主图片 3：详情图片
    private Date madeYear;
    private List<ProductPropertyValue> productPropertyValueList;
    private String logo;
    private String shoppingUrl;
    private List<ProductImg> imgList;
    private TenantProductSeries tenantProductSeries;

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
    @NotFound(action= NotFoundAction.IGNORE)
    public ProductSeries getProductSeries() {
        return productSeries;
    }

    public void setProductSeries(ProductSeries productSeries) {
        this.productSeries = productSeries;
    }

    @JsonIgnore
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "tenant_id")
    @NotFound(action= NotFoundAction.IGNORE)
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
    @OneToMany(fetch = FetchType.LAZY, mappedBy = "product")
    @Where(clause = "status='1'")
    public List<ProductPropertyValue> getProductPropertyValueList() {
        return productPropertyValueList;
    }

    public void setProductPropertyValueList(List<ProductPropertyValue> productPropertyValueList) {
        this.productPropertyValueList = productPropertyValueList;
    }

    @Column(name = "logo")
    public String getLogo() {
        return logo;
    }

    public void setLogo(String logo) {
        this.logo = logo;
    }

    @Column(name = "shopping_url")
    public String getShoppingUrl() {
        return shoppingUrl;
    }

    public void setShoppingUrl(String shoppingUrl) {
        this.shoppingUrl = shoppingUrl;
    }

    @JsonIgnore
    @OneToMany(fetch = FetchType.LAZY, mappedBy = "product")
    @Where(clause = "status='1'")
    public List<ProductImg> getImgList() {
        return imgList;
    }

    public void setImgList(List<ProductImg> imgList) {
        this.imgList = imgList;
    }

    @JsonIgnore
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "tenant_product_series_id")
    @NotFound(action= NotFoundAction.IGNORE)
    public TenantProductSeries getTenantProductSeries() {
        return tenantProductSeries;
    }

    public void setTenantProductSeries(TenantProductSeries tenantProductSeries) {
        this.tenantProductSeries = tenantProductSeries;
    }

}
