package com.ming800.core.base.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import org.hibernate.annotations.GenericGenerator;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Collection;

/**
 * Created by Administrator on 2015/7/16.
 */
@Entity
@Table(name = "organization_user")
public class BaseUser implements Serializable ,UserDetails{

    private String id;
    private String username;
    private String name;
    private BaseTenant baseTenant;
    private String password;

    private String role;

    private boolean enabled;               //是否可用
    private boolean accountExpired;       //账号过期
    private boolean accountLocked;        //账号锁定
    private boolean credentialsExpired;  //证书过期



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

    @JsonIgnore
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "branch_id")
    public BaseTenant getBaseTenant() {
        return baseTenant;
    }

    public void setBaseTenant(BaseTenant baseTenant) {
        this.baseTenant = baseTenant;
    }

    @Override
    @Transient
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return null;
    }

    @Override
    @Column(name = "password")
    public String getPassword() {
        return null;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    @Override
    @Transient
    public boolean isAccountNonExpired() {
        return false;
    }

    @Override
    @Transient
    public boolean isAccountNonLocked() {
        return false;
    }

    @Override
    @Transient
    public boolean isCredentialsNonExpired() {
        return false;
    }

    @Override
    @Transient
    public boolean isEnabled() {
        return false;
    }


    @Transient
    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public void setEnabled(boolean enabled) {
        this.enabled = enabled;
    }

    public boolean isAccountExpired() {
        return accountExpired;
    }

    public void setAccountExpired(boolean accountExpired) {
        this.accountExpired = accountExpired;
    }

    public boolean isAccountLocked() {
        return accountLocked;
    }

    public void setAccountLocked(boolean accountLocked) {
        this.accountLocked = accountLocked;
    }

    public boolean isCredentialsExpired() {
        return credentialsExpired;
    }

    public void setCredentialsExpired(boolean credentialsExpired) {
        this.credentialsExpired = credentialsExpired;
    }
}