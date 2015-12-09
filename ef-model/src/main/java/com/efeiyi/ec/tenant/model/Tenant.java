package com.efeiyi.ec.tenant.model;

import com.efeiyi.ec.organization.model.BigUser;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
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
@JsonIgnoreProperties(value = {"hibernateLazyInitializer", "handler"})
public class Tenant implements Serializable {

    private String id;
    private String name;//名称标识
    private String content; // 简介(长)
    private String logoUrl;
    private String tenantType;// 11:企业 12:个体 13:个人
    private Date createDateTime;
    private String status;
    private String serial;//商家编号
    private List<TenantMaster> tenantMasterList;
    private List<TenantProject> tenantProjectList;
    private List<TenantRecommended> tenantRecommendedList;
    private  String pictureUrl;
    private  String address;//商户地址
    private  String phone;
    private  String review;//审核 1:未审核 2:正在审核 3:审核失败 4:审核成功
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



    @Column(name = "create_datetime")
    public Date getCreateDateTime() {
        return createDateTime;
    }

    public void setCreateDateTime(Date createDateTime) {
        this.createDateTime = createDateTime;
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

    @Column(name = "address")
    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    @Column(name = "phone")
    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    @Column(name = "review_status")
    public String getReview() {
        return review;
    }

    public void setReview(String review) {
        this.review = review;
    }
}
