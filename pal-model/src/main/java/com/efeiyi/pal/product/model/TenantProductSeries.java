package com.efeiyi.pal.product.model;

import com.efeiyi.pal.organization.model.Tenant;
import com.efeiyi.pal.organization.model.TenantCertification;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import org.hibernate.annotations.GenericGenerator;
import org.hibernate.annotations.NotFound;
import org.hibernate.annotations.NotFoundAction;
import org.hibernate.annotations.Where;

import javax.persistence.*;
import java.util.List;

/**
 * Created by Administrator on 2015/8/22.
 */

@Entity
@Table(name = "tenant_product_series")
@JsonIgnoreProperties(value={"hibernateLazyInitializer","handler","operations","roles","menus"})
public class TenantProductSeries {

    private String id;
    private Tenant tenant;
    private ProductSeries productSeries;
    private String status;
    private String craft;
    private String region;
    private List<TenantProductSeriesImg> imgList;
    private TenantCertification tenantCertification;

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
    @NotFound(action= NotFoundAction.IGNORE)
    public Tenant getTenant() {
        return tenant;
    }

    public void setTenant(Tenant tenant) {
        this.tenant = tenant;
    }

    @JsonIgnore
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "product_series_id")
    @NotFound(action= NotFoundAction.IGNORE)
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

    @Column(name = "craft")
    public String getCraft() {
        return craft;
    }

    public void setCraft(String craft) {
        this.craft = craft;
    }

    @Column(name = "region")
    public String getRegion() {
        return region;
    }

    public void setRegion(String region) {
        this.region = region;
    }

    @JsonIgnore
    @OneToMany(fetch = FetchType.LAZY, mappedBy = "tenantProductSeries")
    @Where(clause = "status='1'")
    public List<TenantProductSeriesImg> getImgList() {
        return imgList;
    }

    public void setImgList(List<TenantProductSeriesImg> imgList) {
        this.imgList = imgList;
    }

    @JsonIgnore
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "tenant_certification_id")
    @NotFound(action= NotFoundAction.IGNORE)
    public TenantCertification getTenantCertification() {
        return tenantCertification;
    }

    public void setTenantCertification(TenantCertification tenantCertification) {
        this.tenantCertification = tenantCertification;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        TenantProductSeries that = (TenantProductSeries) o;

        if (!tenant.equals(that.tenant)) return false;
        if (!productSeries.equals(that.productSeries)) return false;
        return status.equals(that.status);

    }

    @Override
    public int hashCode() {
        int result = tenant.hashCode();
        result = 31 * result + productSeries.hashCode();
        result = 31 * result + status.hashCode();
        return result;
    }

}
