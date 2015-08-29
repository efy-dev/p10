package com.efeiyi.ec.tenant.model;

import com.efeiyi.ec.organization.model.BigUser;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

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
public class Tenant extends BigUser implements Serializable {

    private String name;//名称标识
    private String content; // 简介(长)
    private String logoUrl;
    private String tenantType;// 11:企业 12:个体 13:个人
    private Date createDateTime;
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
}
