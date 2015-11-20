package com.efeiyi.ec.organization.model;

import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.io.Serializable;
import java.util.List;

@Entity
@Table(name = "organization_role")
public class Role implements Serializable {
    private String id;
    private String name;
    private String cname;//中文名称
    private String basicType;
    private Integer superPermission;        //1具有超级权限  2不具有超级权限

    private String status;
    private List<Permission> permissionsList;
    /*private HashMap<String,Permission> permissionMap;
    private Map<String,String> settingMap;
    private Set<String> lisenceSet;*/

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

    @Column(name = "basic_type")
    public String getBasicType() {
        return basicType;
    }

    public void setBasicType(String basicType) {
        this.basicType = basicType;
    }

    @Column(name = "is_super")
    public Integer getSuperPermission() {
        return superPermission;
    }

    public void setSuperPermission(Integer superPermission) {
        this.superPermission = superPermission;
    }


    @Column(name = "thestatus")
    public String  getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @OneToMany(fetch = FetchType.EAGER, cascade = CascadeType.ALL, mappedBy = "role")
    public List<Permission> getPermissionsList() {
        return permissionsList;
    }

    public void setPermissionsList(List<Permission> permissionsList) {
        this.permissionsList = permissionsList;
    }

    /*@JsonIgnore
    @Transient
    public HashMap<String, Permission> getPermissionMap() {
        return permissionMap;
    }

    public void setPermissionMap(HashMap<String, Permission> permissionMap) {
        this.permissionMap = permissionMap;
    }

    @JsonIgnore
    @Transient
    public Map<String, String> getSettingMap() {
        return settingMap;
    }

    public void setSettingMap(Map<String, String> settingMap) {
        this.settingMap = settingMap;
    }

    @JsonIgnore
    @Transient
    public Set<String> getLisenceSet() {
        return lisenceSet;
    }

    public void setLisenceSet(Set<String> lisenceSet) {
        this.lisenceSet = lisenceSet;
    }*/

    @Column(name = "c_name")
    public String getCname() {
        return cname;
    }

    public void setCname(String cname) {
        this.cname = cname;
    }
}
