package com.efeiyi.ec.tenant.model;

import com.efeiyi.ec.organization.model.AddressProvince;
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
@Inheritance(strategy = InheritanceType.JOINED)
@JsonIgnoreProperties(value = {"hibernateLazyInitializer", "handler"})
public class BigTenant implements Serializable {

    private String id;
    private String name;//名称标识
    private String content; // 简介(长)
    private String logoUrl;
    private String tenantType;// 11:企业 12:个体 13:个人
    private Date createDateTime;
    //个人信息
    private String identity; // 身份证号
    private String frontPhoto;//正面照片
    private String versoPhoto;//反面照片
    protected AddressProvince addressProvince; //所在地
    //个体信息
    private String operatorName;//经营者姓名//法定代表人姓名
    private Date indateBegin;//营业执照有效期开始时间;
    private Date indateEnd; // 营业执照有效期结束时间;
    private String businessScope;//经营范围
    private String businessLicense;//营业执照
    private String taxRegistrationAttachment;//税务登记附件
    //公司信息
    private String registeredAssets;
    private String organizationAttachment;//组织机构附件
    private String bankAttachment;//银行开户附件
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

    @Column(name = "identity")
    public String getIdentity() {
        return identity;
    }

    public void setIdentity(String identity) {
        this.identity = identity;
    }

    @Column(name = "front_photo")
    public String getFrontPhoto() {
        return frontPhoto;
    }

    public void setFrontPhoto(String frontPhoto) {
        this.frontPhoto = frontPhoto;
    }

    @Column(name = "verso_photo")
    public String getVersoPhoto() {
        return versoPhoto;
    }

    public void setVersoPhoto(String versoPhoto) {
        this.versoPhoto = versoPhoto;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "province_id", updatable = false, insertable = false)
    public AddressProvince getAddressProvince() {
        return addressProvince;
    }

    public void setAddressProvince(AddressProvince addressProvince) {
        this.addressProvince = addressProvince;
    }

    @Column(name = "operator_name")
    public String getOperatorName() {
        return operatorName;
    }

    public void setOperatorName(String operatorName) {
        this.operatorName = operatorName;
    }

    @Column(name = "indate_begin")
    public Date getIndateBegin() {
        return indateBegin;
    }

    public void setIndateBegin(Date indateBegin) {
        this.indateBegin = indateBegin;
    }

    @Column(name = "indate_end")
    public Date getIndateEnd() {
        return indateEnd;
    }

    public void setIndateEnd(Date indateEnd) {
        this.indateEnd = indateEnd;
    }

    @Column(name = "business_scope")
    public String getBusinessScope() {
        return businessScope;
    }

    public void setBusinessScope(String businessScope) {
        this.businessScope = businessScope;
    }

    @Column(name = "business_license")
    public String getBusinessLicense() {
        return businessLicense;
    }

    public void setBusinessLicense(String businessLicense) {
        this.businessLicense = businessLicense;
    }

    @Column(name = "tax_registration_attachment")
    public String getTaxRegistrationAttachment() {
        return taxRegistrationAttachment;
    }

    public void setTaxRegistrationAttachment(String taxRegistrationAttachment) {
        this.taxRegistrationAttachment = taxRegistrationAttachment;
    }

    @Column(name = "registered_assets")
    public String getRegisteredAssets() {
        return registeredAssets;
    }

    public void setRegisteredAssets(String registeredAssets) {
        this.registeredAssets = registeredAssets;
    }

    @Column(name = "organization_attachment")
    public String getOrganizationAttachment() {
        return organizationAttachment;
    }

    public void setOrganizationAttachment(String organizationAttachment) {
        this.organizationAttachment = organizationAttachment;
    }

    @Column(name = "bank_attachment")
    public String getBankAttachment() {
        return bankAttachment;
    }

    public void setBankAttachment(String bankAttachment) {
        this.bankAttachment = bankAttachment;
    }
}
