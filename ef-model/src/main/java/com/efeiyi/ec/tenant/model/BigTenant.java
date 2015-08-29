package com.efeiyi.ec.tenant.model;

import com.efeiyi.ec.organization.model.AddressProvince;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.ming800.core.base.model.BaseTenant;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;
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
@Inheritance(strategy = InheritanceType.JOINED)
@JsonIgnoreProperties(value = {"hibernateLazyInitializer", "handler"})
public class BigTenant implements Serializable,BaseTenant {

    private String id;
    private String name;//名称标识
    private String content; // 简介(长)
    private String logoUrl;
    private String tenantType;// 11:企业 12:个体 13:个人
    private Date createDateTime;
    private String status;
    //个人信息
    private String identity; // 身份证号
    private String frontPhotoUrl;//正面照片
    private String versoPhotoUrl;//反面照片
    protected AddressProvince addressProvince; //所在地
    //个体信息

    //公司信息

    //   private List<TenantProject> tenantProjectList;
    private List<TenantRecommended> tenantRecommendedList;

//    @JsonIgnore
//    @OneToMany(fetch = FetchType.LAZY, mappedBy = "tenant")
//    public List<TenantProject> getTenantProjectList() {
//        return tenantProjectList;
//    }
//
//    public void setTenantProjectList(List<TenantProject> tenantProjectList) {
//        this.tenantProjectList = tenantProjectList;
//    }

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

    @Column(name = "content")
    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    @Column(name = "logo_url")
    public String getLogoUrl() {
        return logoUrl;
    }

    public void setLogoUrl(String logoUrl) {
        this.logoUrl = logoUrl;
    }

    @Column(name = "tenant_type")
    public String getTenantType() {
        return tenantType;
    }

    public void setTenantType(String tenantType) {
        this.tenantType = tenantType;
    }

    @Column(name = "create_datetime")
    public Date getCreateDateTime() {
        return createDateTime;
    }

    public void setCreateDateTime(Date createDateTime) {
        this.createDateTime = createDateTime;
    }

    @Column(name = "status")
    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Column(name = "identity")
    public String getIdentity() {
        return identity;
    }

    public void setIdentity(String identity) {
        this.identity = identity;
    }

    @Column(name = "front_photo_url")
    public String getFrontPhotoUrl() {
        return frontPhotoUrl;
    }

    public void setFrontPhotoUrl(String frontPhotoUrl) {
        this.frontPhotoUrl = frontPhotoUrl;
    }

    @Column(name = "verso_photo_url")
    public String getVersoPhotoUrl() {
        return versoPhotoUrl;
    }

    public void setVersoPhotoUrl(String versoPhotoUrl) {
        this.versoPhotoUrl = versoPhotoUrl;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "address_province_id", updatable = false, insertable = false)
    public AddressProvince getAddressProvince() {
        return addressProvince;
    }

    public void setAddressProvince(AddressProvince addressProvince) {
        this.addressProvince = addressProvince;
    }

    @JsonIgnore
    @OneToMany(fetch = FetchType.LAZY, mappedBy = "tenant", cascade = CascadeType.ALL)
    public List<TenantRecommended> getTenantRecommendedList() {
        return tenantRecommendedList;
    }

    public void setTenantRecommendedList(List<TenantRecommended> tenantRecommendedList) {
        this.tenantRecommendedList = tenantRecommendedList;
    }
}
