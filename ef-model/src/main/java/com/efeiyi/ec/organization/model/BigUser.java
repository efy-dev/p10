package com.efeiyi.ec.organization.model;


import com.efeiyi.ec.master.model.Master;
import com.efeiyi.ec.tenant.model.BigTenant;
import com.fasterxml.jackson.annotation.JsonIgnore;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.math.BigDecimal;
import java.util.Date;

@Entity
@Table(name = "organization_user")
@Inheritance(strategy = InheritanceType.JOINED)
public class BigUser {

    protected String id;
    protected String username;
    protected String name; //真实姓名
    protected String name2;    //别名
    protected String password;
    protected String cardNumber;  //卡号


    protected String status;      // 0假删  1用户/人员      2人员     3用户
    protected Integer workStatus;      //   -1  离职   1  正常

    protected Master branch;
    protected String pictureUrl;
    protected Role role;
    /*    protected String roleType;//角色类型  摄影师 经纪人 化妆师  管理员  修片师*/
    //确认密码
    protected String confirmPassword;
    protected String oldPassword;

    //    spring security
    protected Boolean enabled;               //是否可用  激活
    protected Boolean accountExpired;       //账号过期
    protected Boolean accountLocked;        //账号锁定   禁用
    protected Boolean credentialsExpired;  //证书过期

    protected String phone;
    protected String email;
    protected String serial;
    protected String identity;    //身份证号
    protected String memo;

    protected Integer sex;            //1男   2女

    protected Date birthDate;

    protected Date createDatetime;

/*    protected Integer utype;  //用户类型*/

    protected String cityId;//已开通城市（若addressCityId不在已开通城市时，此字段置空）
    protected String cityName;
    protected BigTenant bigTenant;
    protected String provinceId;
    protected String addressCityId;
    protected String provinceName;
    protected String addressCityName;
    protected AddressProvince addressProvince;
    protected Date lastLoginDatetime; //最后一次登陆时间
    protected BigDecimal redPacket;//红包（相当于钱包）

/*    protected  UserTenant userTenant;

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "user")
    public UserTenant getUserTenant() {
        return userTenant;
    }

    public void setUserTenant(UserTenant userTenant) {
        this.userTenant = userTenant;
    }*/

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "province_id", updatable = false, insertable = false)
    public AddressProvince getAddressProvince() {
        return addressProvince;
    }

    public void setAddressProvince(AddressProvince addressProvince) {
        this.addressProvince = addressProvince;
    }

    @Column(name = "province_id")
    public String getProvinceId() {
        return provinceId;
    }

    public void setProvinceId(String provinceId) {
        this.provinceId = provinceId;
    }

    @Column(name = "address_city_id")
    public String getAddressCityId() {
        return addressCityId;
    }

    public void setAddressCityId(String addressCityId) {
        this.addressCityId = addressCityId;
    }

    @Column(name = "city_id")
    public String getCityId() {
        return cityId;
    }

    public void setCityId(String cityId) {
        this.cityId = cityId;
    }

    public BigUser() {
    }

    @Column(name = "picture")
    public String getPictureUrl() {
        return pictureUrl;
    }

    public void setPictureUrl(String pictureUrl) {
        this.pictureUrl = pictureUrl;
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

    @Column(name = "username")
    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    @Column(name = "truename")
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Column(name = "password")
    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    @Column(name = "card_number")
    public String getCardNumber() {
        return cardNumber;
    }

    public void setCardNumber(String cardNumber) {
        this.cardNumber = cardNumber;
    }

    @Column(name = "memo")
    public String getMemo() {
        return memo;
    }

    public void setMemo(String memo) {
        this.memo = memo;
    }

    @Column(name = "phone")
    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    @Column(name = "email")
    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    @Column(name = "status")
    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Column(name = "work_status")
    public Integer getWorkStatus() {
        return workStatus;
    }

    public void setWorkStatus(Integer workStatus) {
        this.workStatus = workStatus;
    }

    @JsonIgnore
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "tenant_id")
    public BigTenant getBigTenant() {
        return bigTenant;
    }

    public void setBigTenant(BigTenant bigTenant) {
        this.bigTenant = bigTenant;
    }

    @JsonIgnore
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "branch_id")
    public Master getBranch() {
        return branch;
    }

    public void setBranch(Master branch) {
        this.branch = branch;
    }

/*    @Column(name = "role_type")
    public String getRoleType() {
        return roleType;
    }

    public void setRoleType(String roleType) {
        this.roleType = roleType;
    }*/

    @Column(name = "account_enabled")
    public Boolean getEnabled() {
        return enabled;
    }

    public void setEnabled(Boolean enabled) {
        this.enabled = enabled;
    }

    @Column(name = "account_expired")
    public Boolean getAccountExpired() {
        return accountExpired;
    }

    public void setAccountExpired(Boolean accountExpired) {
        this.accountExpired = accountExpired;
    }

    @Column(name = "account_locked")
    public Boolean getAccountLocked() {
        return accountLocked;
    }

    public void setAccountLocked(Boolean accountLocked) {
        this.accountLocked = accountLocked;
    }

    @Column(name = "credentials_expited")
    public Boolean getCredentialsExpired() {
        return credentialsExpired;
    }

    public void setCredentialsExpired(Boolean credentialsExpired) {
        this.credentialsExpired = credentialsExpired;
    }

    @JsonIgnore
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "role_id")
    public Role getRole() {
        return role;
    }

    public void setRole(Role role) {
        this.role = role;
    }

    @Transient
    public String getConfirmPassword() {
        return confirmPassword;
    }

    public void setConfirmPassword(String confirmPassword) {
        this.confirmPassword = confirmPassword;
    }

    @Transient
    public String getOldPassword() {
        return oldPassword;
    }

    public void setOldPassword(String oldPassword) {
        this.oldPassword = oldPassword;
    }


    @Transient
    public String getFullName() {
        return this.name + "[" + this.username + "]";
    }

    @Override
    public String toString() {
        return "User{id = " + id + ", username = " + username + "}";
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        BigUser user = (BigUser) o;

        if (!id.equals(user.id)) return false;
        if (!username.equals(user.username)) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = id.hashCode();
        if (username != null) {
            result = 31 * result + username.hashCode();
        }
        return result;
    }

    @Column(name = "sex")
    public Integer getSex() {
        return sex;
    }

    public void setSex(Integer sex) {
        this.sex = sex;
    }

    @Column(name = "serial")
    public String getSerial() {
        return serial;
    }

    public void setSerial(String serial) {
        this.serial = serial;
    }

    @Column(name = "identity")
    public String getIdentity() {
        return identity;
    }

    public void setIdentity(String identity) {
        this.identity = identity;
    }


    @Column(name = "birth")
    public Date getBirthDate() {
        return birthDate;
    }

    public void setBirthDate(Date birthDate) {
        this.birthDate = birthDate;
    }


    @Column(name = "create_datetime")
    public Date getCreateDatetime() {
        return createDatetime;
    }

    public void setCreateDatetime(Date createDatetime) {
        this.createDatetime = createDatetime;
    }


/*
    @Column(name = "utype")
    public Integer getUtype() {
        return utype;
    }

    public void setUtype(Integer utype) {
        this.utype = utype;
    }
*/

    @Column(name = "truename2")
    public String getName2() {
        return name2;
    }

    public void setName2(String name2) {
        this.name2 = name2;
    }

    @Transient
    public String getProvinceName() {
        return provinceName;
    }

    public void setProvinceName(String provinceName) {
        this.provinceName = provinceName;
    }

    @Transient
    public String getAddressCityName() {
        return addressCityName;
    }

    public void setAddressCityName(String addressCityName) {
        this.addressCityName = addressCityName;
    }

    @Column(name = "last_login_datetime")
    public Date getLastLoginDatetime() {
        return lastLoginDatetime;
    }

    public void setLastLoginDatetime(Date lastLoginDatetime) {
        this.lastLoginDatetime = lastLoginDatetime;
    }

    @Transient
    public String getCityName() {
        return cityName;
    }

    public void setCityName(String cityName) {
        this.cityName = cityName;
    }

    @Column(name = "red_packet")
    public BigDecimal getRedPacket() {
        return redPacket;
    }

    public void setRedPacket(BigDecimal redPacket) {
        this.redPacket = redPacket;
    }
}
