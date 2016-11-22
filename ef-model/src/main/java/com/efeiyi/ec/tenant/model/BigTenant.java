package com.efeiyi.ec.tenant.model;

import com.efeiyi.ec.organization.model.*;
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
public class BigTenant implements Serializable, BaseTenant {

    public static final String TENANT_TYPE_OFFLINE = "111"; //线下实体店铺
    public static final String REVIEW_STATUS_WILL = "1"; //未审核
    public static final String REVIEW_STATUS_SUCCESS = "4"; //审核成功
    public static final String TENANT_TYPE_SCENIC = "112"; //线下景区

    private String id;
    private String name;//名称标识
    private String content; // 简介(长)
    private String logoUrl;
    private String tenantType;// 11:企业 12:个体 13:个人 111线下店铺
    private Date createDateTime;
    private String status;
    private String serial;//商家编号
    private String contractNumber;//商家合同号
    private String epositBank;//开户行
    private String account;//账号
    //个人信息
    private String identity; // 身份证号
    private String frontPhotoUrl;//正面照片
    private String versoPhotoUrl;//反面照片
    protected AddressProvince addressProvince; //省
    protected AddressCity addressCity;//城市
    //个体信息

    //公司信息
    private List<TenantMaster> tenantMasterList;
    private List<TenantProject> tenantProjectList;
    private List<TenantRecommended> tenantRecommendedList;
    private String pictureUrl;
    private String address;//商户地址
    private String phone;
    private String review;//审核 1:未审核 2:正在审核 3:审核失败 4:审核成功


    private Double latitude;    //纬度
    private Double longitude;   //经度

    private String audio;
    private List<UserTenant> userTenant;
    private List<TenantOrder> tenantOrders;

    @JsonIgnore
    @OneToMany(fetch = FetchType.LAZY, mappedBy = "bigTenant")
    public List<TenantOrder> getTenantOrders() {
        return tenantOrders;
    }

    public void setTenantOrders(List<TenantOrder> tenantOrders) {
        this.tenantOrders = tenantOrders;
    }

    @JsonIgnore
    @OneToMany(fetch = FetchType.LAZY, mappedBy = "tenant")
    public List<UserTenant> getUserTenant() {
        return userTenant;
    }

    public void setUserTenant(List<UserTenant> userTenant) {
        this.userTenant = userTenant;
    }

    @Transient
    public String getAudio() {
        return audio;
    }

    public void setAudio(String audio) {
        this.audio = audio;
    }

    @Column(name = "latitude")
    public Double getLatitude() {
        return latitude;
    }

    public void setLatitude(Double latitude) {
        this.latitude = latitude;
    }

    @Column(name = "longitude")
    public Double getLongitude() {
        return longitude;
    }

    public void setLongitude(Double longitude) {
        this.longitude = longitude;
    }

    //    @JsonIgnore
    @OneToMany(fetch = FetchType.LAZY, mappedBy = "tenant")
    public List<TenantProject> getTenantProjectList() {
        return tenantProjectList;
    }

    public void setTenantProjectList(List<TenantProject> tenantProjectList) {
        this.tenantProjectList = tenantProjectList;
    }


    @Column(name = "picture_url")
    public String getPictureUrl() {
        return pictureUrl;
    }

    public void setPictureUrl(String pictureUrl) {
        this.pictureUrl = pictureUrl;
    }

    //    @JsonIgnore
    @OneToMany(fetch = FetchType.LAZY, mappedBy = "tenant")
    public List<TenantMaster> getTenantMasterList() {
        return tenantMasterList;
    }

    public void setTenantMasterList(List<TenantMaster> tenantMasterList) {
        this.tenantMasterList = tenantMasterList;
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
    @JoinColumn(name = "address_province_id")
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

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "address_city_id")
    public AddressCity getAddressCity() {
        return addressCity;
    }

    public void setAddressCity(AddressCity addressCity) {
        this.addressCity = addressCity;
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

    @Column(name = "contract_number")
    public String getContractNumber() {
        return contractNumber;
    }

    public void setContractNumber(String contractNumber) {
        this.contractNumber = contractNumber;
    }

    @Column(name = "eposit_bank")
    public String getEpositBank() {
        return epositBank;
    }

    public void setEpositBank(String epositBank) {
        this.epositBank = epositBank;
    }

    @Column(name = "account")
    public String getAccount() {
        return account;
    }

    public void setAccount(String account) {
        this.account = account;
    }

    @Override
    public String toString() {
        return "BigTenant{id = " + id + "}";
    }
}
