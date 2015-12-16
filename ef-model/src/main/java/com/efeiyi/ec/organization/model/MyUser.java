package com.efeiyi.ec.organization.model;

import com.efeiyi.ec.tenant.model.BigTenant;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.ming800.core.base.model.BaseUser;
import org.hibernate.annotations.GenericGenerator;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import javax.persistence.*;
import java.io.Serializable;
import java.util.*;

/**
 * Created with IntelliJ IDEA.
 * User: ming
 * Date: 13-3-6
 * Time: 下午2:16
 * To change this template use File | Settings | File Templates.
 */
@Entity
@Table(name = "organization_user")
@JsonIgnoreProperties(value = {"hibernateLazyInitializer", "handler"})
public class MyUser implements Serializable, UserDetails ,BaseUser{

    private String id;
    private String username;
    private String name;
    private String name2;    //别名
    private String password;

    /*   private Integer theType;           // 基础岗位  11前台  12出纳     21教师，22助教*/
    private Integer status;      // 0假删  1用户/人员      2人员     3用户


//    private TeachArea teachArea;
//    private TeachArea department;
//    private Student student;

    private Role role;

    /*    private String roleType;*/
    private String confirmPassword;
    private String oldPassword;


    private boolean enabled;               //是否可用
    private boolean accountExpired;       //账号过期
    private boolean accountLocked;        //账号锁定
    private boolean credentialsExpired;  //证书过期


    private String tempPageUrl;
    private BigTenant bigTenant;
    private Map<String, String> settingMap;

    private Integer utype; //总部用户，分公司用户


    private BigUser bigUser;


    private Date lastLoginDatetime;//最后一次登陆时间
    private Date lastLogoutDatetime;//最后一次登陆时间


    @Transient
    public BigUser getBigUser() {
        return bigUser;
    }

    public void setBigUser(BigUser bigUser) {
        this.bigUser = bigUser;
    }

    public MyUser() {
    }
    @JsonIgnore
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "role_id")
    public Role getRole() {
        return role;
    }

    public void setRole(Role role) {
        this.role = role;
    }

    @JsonIgnore
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "tenant_id")
    public BigTenant getBigTenant() {
        return bigTenant;
    }

    public void setBigTenant(BigTenant bigTenant) {
        this.bigTenant = bigTenant;
    }

    @Column(name = "type")
    public Integer getUtype() {
        return utype;
    }

    public void setUtype(Integer utype) {
        this.utype = utype;
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

 /*   @Column(name = "thetype")
    public Integer getTheType() {
        return theType;
    }

    public void setTheType(Integer theType) {
        this.theType = theType;
    }*/

    @Column(name = "status")
    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    //    @ManyToOne(fetch = FetchType.EAGER)
//    @JoinColumn(name = "teach_area_id")
//    public TeachArea getTeachArea() {
//        return teachArea;
//    }
//
//    public void setTeachArea(TeachArea teachArea) {
//        this.teachArea = teachArea;
//    }
//
//    @ManyToOne(fetch = FetchType.LAZY)
//    @JoinColumn(name = "department_id")
//    public TeachArea getDepartment() {
//        return department;
//    }
//
//    public void setDepartment(TeachArea department) {
//        this.department = department;
//    }

//    @ManyToOne(fetch = FetchType.EAGER)
//    @JoinColumn(name = "student_id")
//    public Student getStudent() {
//        return student;
//    }
//
//    public void setStudent(Student student) {
//        this.student = student;
//    }

    @Column(name = "account_enabled")
    public boolean isEnabled() {
        return enabled;
    }

    public void setEnabled(boolean enabled) {
        this.enabled = enabled;
    }

    @Column(name = "account_expired")
    public boolean isAccountExpired() {
        return accountExpired;
    }

    public void setAccountExpired(boolean accountExpired) {
        this.accountExpired = accountExpired;
    }

    @Column(name = "account_locked")
    public boolean isAccountLocked() {
        return accountLocked;
    }

    public void setAccountLocked(boolean accountLocked) {
        this.accountLocked = accountLocked;
    }

    @Column(name = "credentials_expited")
    public boolean isCredentialsExpired() {
        return credentialsExpired;
    }

    public void setCredentialsExpired(boolean credentialsExpired) {
        this.credentialsExpired = credentialsExpired;
    }

//    @JsonIgnore
//    @ManyToOne(fetch = FetchType.EAGER)
//    @JoinColumn(name = "role_id")
//    public Role getRole() {
//        return role;
//    }
//
//    public void setRole(Role role) {
//        this.role = role;
//    }
/*

    @Column(name = "role_type")
    public String getRoleType() {

        if (roleType == null) {
            roleType = "";
        }

        return roleType;
    }

    public void setRoleType(String roleType) {
        this.roleType = roleType;
    }*/

    @JsonIgnore
    @Transient
    public Collection<GrantedAuthority> getAuthorities() {
        List<GrantedAuthority> gList = new ArrayList<GrantedAuthority>();
      if(role!=null) {
          Permission rolePermission = new Permission();//角色即权限
          rolePermission.setAuthority(role.getName());
          gList.add(rolePermission);
//          if (role.getPermissionsList() != null) {
//              for (Permission permission : role.getPermissionsList()) {
//                  gList.add(permission);
//              }
//          }
      }
        Permission defaultPermission = new Permission();//每个用户都默认带ROLE_USER这个权限
        defaultPermission.setAuthority("ROLE_USER");//普通用户
        gList.add(defaultPermission);
        return gList;
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
    public boolean isAccountNonExpired() {
        return !isAccountExpired();
    }

    @Transient
    public boolean isAccountNonLocked() {
        return !isAccountLocked();
    }

    @Transient
    public boolean isCredentialsNonExpired() {
        return !credentialsExpired;
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

       /* BigUser user = (BigUser) o;

        if (!id.equals(user.id)) return false;
        if (!username.equals(user.username)) return false;
*/
        return true;
    }

    @Override
    public int hashCode() {
        int result = id.hashCode();
        result = 31 * result + username.hashCode();
        return result;
    }

    @Column(name = "truename2")
    public String getName2() {
        return name2;
    }

    public void setName2(String name2) {
        this.name2 = name2;
    }

    @JsonIgnore
    @Transient
    public String getTempPageUrl() {
        return tempPageUrl;
    }

    public void setTempPageUrl(String tempPageUrl) {
        this.tempPageUrl = tempPageUrl;
    }

    @JsonIgnore
    @Transient
    public Map<String, String> getSettingMap() {
        return settingMap;
    }

    public void setSettingMap(Map<String, String> settingMap) {
        this.settingMap = settingMap;
    }

    @Column(name = "last_login_datetime")
    public Date getLastLoginDatetime() {
        return lastLoginDatetime;
    }

    public void setLastLoginDatetime(Date lastLoginDatetime) {
        this.lastLoginDatetime = lastLoginDatetime;
    }
    @Transient
    public Date getLastLogoutDatetime() {
        return lastLogoutDatetime;
    }

    public void setLastLogoutDatetime(Date lastLogoutDatetime) {
        this.lastLogoutDatetime = lastLogoutDatetime;
    }
    private String source;//来源推广渠道
    private Date rdEndDay;//推广渠道有效时间
    @Column(name = "source")
    public String getSource() {
        return source;
    }

    public void setSource(String source) {
        this.source = source;
    }

    @Column(name = "rd_end_day")
    public Date getRdEndDay() {
        return rdEndDay;
    }

    public void setRdEndDay(Date rdEndDay) {
        this.rdEndDay = rdEndDay;
    }
}
