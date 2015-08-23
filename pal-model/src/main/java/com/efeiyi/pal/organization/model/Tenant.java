package com.efeiyi.pal.organization.model;

import com.efeiyi.pal.product.model.ProductSeries;
import com.efeiyi.pal.product.model.TenantProductSeries;
import com.fasterxml.jackson.annotation.JsonIgnore;
import org.hibernate.annotations.GenericGenerator;
import org.hibernate.annotations.Where;

import javax.persistence.*;
import java.util.List;
import java.util.Set;

/**
 * Created by Administrator on 2015/7/16.
 */

@Entity
@Table(name = "organization_tenant")
public class Tenant {

    private String id;
    private String name;
//    private AddressProvince province;
//    private AddressDistrict address;
    private String province;
    private String city;
    private String address;
    private String status;
    private List<TenantSource> tenantSourceList;
    private List<TenantCertification> tenantCertificationList;

    private List<TenantProductSeries> tenantProductSeriesList;

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

//    @JsonIgnore
//    @ManyToOne(fetch = FetchType.LAZY)
//    @JoinColumn(name = "province_id")
//    public AddressProvince getProvince() {
//        return province;
//    }
//
//    public void setProvince(AddressProvince province) {
//        this.province = province;
//    }
//
//    @JsonIgnore
//    @ManyToOne(fetch = FetchType.LAZY)
//    @JoinColumn(name = "district_id")
//    public AddressDistrict getAddress() {
//        return address;
//    }
//
//    public void setAddress(AddressDistrict address) {
//        this.address = address;
//    }

    @Column(name = "province")
    public String getProvince() {
        return province;
    }

    public void setProvince(String province) {
        this.province = province;
    }

    @Column(name = "city")
    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    @Column(name = "address")
    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
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
    public List<TenantSource> getTenantSourceList() {
        return tenantSourceList;
    }

    public void setTenantSourceList(List<TenantSource> tenantSourceList) {
        this.tenantSourceList = tenantSourceList;
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

}
