package com.efeiyi.pal.organization.model;

import com.efeiyi.pal.product.model.Product;
import com.efeiyi.pal.product.model.TenantProductSeries;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import org.hibernate.annotations.GenericGenerator;
import org.hibernate.annotations.NotFound;
import org.hibernate.annotations.NotFoundAction;
import org.hibernate.annotations.Where;

import javax.persistence.*;
import java.util.List;

/**
 * Created by Administrator on 2015/7/16.
 */

@Entity
@Table(name = "organization_tenant")
@JsonIgnoreProperties(value={"hibernateLazyInitializer","handler","operations","roles","menus"})
public class Tenant {

    private String id;
    private String name;
    private AddressProvince province;
    private AddressCity city;
    private AddressDistrict district;
    private String status;
    private List<TenantCertification> tenantCertificationList;
    private List<TenantProductSeries> tenantProductSeriesList;
    private List<Product> productList;

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

    @JsonIgnore
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "province_id")
    @NotFound(action= NotFoundAction.IGNORE)
    public AddressProvince getProvince() {
        return province;
    }

    public void setProvince(AddressProvince province) {
        this.province = province;
    }

    @JsonIgnore
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "city_id")
    @NotFound(action= NotFoundAction.IGNORE)
    public AddressCity getCity() {
        return city;
    }

    public void setCity(AddressCity city) {
        this.city = city;
    }

    @JsonIgnore
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "district_id")
    @NotFound(action= NotFoundAction.IGNORE)
    public AddressDistrict getDistrict() {
        return district;
    }

    public void setDistrict(AddressDistrict district) {
        this.district = district;
    }

    @Column(name = "status")
    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @JsonIgnore
    @OneToMany(fetch = FetchType.LAZY, mappedBy = "tenant")
    @Where(clause = "status='1'")
    public List<TenantCertification> getTenantCertificationList() {
        return tenantCertificationList;
    }

    public void setTenantCertificationList(List<TenantCertification> tenantCertificationList) {
        this.tenantCertificationList = tenantCertificationList;
    }

    @JsonIgnore
    @OneToMany(fetch = FetchType.LAZY, mappedBy = "tenant")
    @Where(clause = "status='1'")
    public List<TenantProductSeries> getTenantProductSeriesList() {
        return tenantProductSeriesList;
    }

    public void setTenantProductSeriesList(List<TenantProductSeries> tenantProductSeriesList) {
        this.tenantProductSeriesList = tenantProductSeriesList;
    }

    @JsonIgnore
    @OneToMany(fetch = FetchType.LAZY, mappedBy = "tenant")
    @Where(clause = "status='1'")
    public List<Product> getProductList() {
        return productList;
    }

    public void setProductList(List<Product> productList) {
        this.productList = productList;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Tenant tenant = (Tenant) o;

        return id.equals(tenant.id);

    }

    @Override
    public int hashCode() {
        return id.hashCode();
    }

}
