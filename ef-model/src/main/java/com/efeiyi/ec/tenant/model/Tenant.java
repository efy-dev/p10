package com.efeiyi.ec.tenant.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.io.Serializable;
import java.util.List;


/**
 * Created by IntelliJ IDEA.
 * User: ming
 * Date: 12-10-15
 * Time: 上午11:06
 * To change this template use File | Settings | File Templates.
 */

@Entity
@Table(name = "tenant")
@JsonIgnoreProperties(value = {"hibernateLazyInitializer", "handler"})
public class Tenant implements Serializable {

    private String id;
    private String name;//名称标识
    private String logoUrl;
    private String tenantType;// 11:企业 12:个体 13:个人
    private String status;
    private String serial;//商家编号
    private List<TenantMaster> tenantMasterList;
    private List<TenantProject> tenantProjectList;
    private List<TenantRecommended> tenantRecommendedList;
    private String pictureUrl;
    private Integer discount;

    private List<TenantGroup> tenantGroups;

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "tenant")
    public List<TenantGroup> getTenantGroups() {
        return tenantGroups;
    }

    public void setTenantGroups(List<TenantGroup> tenantGroups) {
        this.tenantGroups = tenantGroups;
    }

    @Column(name = "discount")
    public Integer getDiscount() {
        return discount;
    }

    public void setDiscount(Integer discount) {
        this.discount = discount;
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


    @Column(name = "picture_url")
    public String getPictureUrl() {
        return pictureUrl;
    }

    public void setPictureUrl(String pictureUrl) {
        this.pictureUrl = pictureUrl;
    }

    @JsonIgnore
    @OneToMany(fetch = FetchType.LAZY, mappedBy = "tenant")
    public List<TenantProject> getTenantProjectList() {
        return tenantProjectList;
    }

    public void setTenantProjectList(List<TenantProject> tenantProjectList) {
        this.tenantProjectList = tenantProjectList;
    }

    @JsonIgnore
    @OneToMany(fetch = FetchType.LAZY, mappedBy = "tenant")
    public List<TenantMaster> getTenantMasterList() {
        return tenantMasterList;
    }

    public void setTenantMasterList(List<TenantMaster> tenantMasterList) {
        this.tenantMasterList = tenantMasterList;
    }

    @Column(name = "name")
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Column(name = "logo_url")
    public String getLogoUrl() {
        return logoUrl;
    }

    public void setLogoUrl(String logoUrl) {
        this.logoUrl = logoUrl;
    }

    @JsonIgnore
    @OneToMany(fetch = FetchType.LAZY, mappedBy = "tenant", cascade = CascadeType.ALL)
    public List<TenantRecommended> getTenantRecommendedList() {
        return tenantRecommendedList;
    }

    public void setTenantRecommendedList(List<TenantRecommended> tenantRecommendedList) {
        this.tenantRecommendedList = tenantRecommendedList;
    }

    @Column(name = "tenant_type")
    public String getTenantType() {
        return tenantType;
    }

    public void setTenantType(String tenantType) {
        this.tenantType = tenantType;
    }

    @Column(name = "status")
    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Column(name = "serial")
    public String getSerial() {
        return serial;
    }

    public void setSerial(String serial) {
        this.serial = serial;
    }

    @Override
    public String toString() {
        return "Tenant{id = " + id + "}";
    }
}
