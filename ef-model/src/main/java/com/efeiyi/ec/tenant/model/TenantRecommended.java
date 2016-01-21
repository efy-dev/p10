package com.efeiyi.ec.tenant.model;

import com.efeiyi.ec.master.model.Master;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import org.hibernate.annotations.GenericGenerator;
import org.hibernate.annotations.Where;

import javax.persistence.*;
import java.io.Serializable;


/**
 * Created by IntelliJ IDEA.
 * User: ming
 * Date: 12-10-15
 * Time: 上午11:06
 * To change this template use File | Settings | File Templates.
 */

@Entity
@Table(name = "base_recommended")
@JsonIgnoreProperties(value = {"hibernateLazyInitializer", "handler"})
public class TenantRecommended implements Serializable {

    private String id;
    private Tenant tenant;
    private Integer sort;
    private String status;
    private String group;


    @Id
    @GenericGenerator(name = "id", strategy = "com.ming800.core.p.model.M8idGenerator")
    @GeneratedValue(generator = "id")
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "recommend_id")
    public Tenant getTenant() {
        return tenant;
    }

    public void setTenant(Tenant tenant) {
        this.tenant = tenant;
    }





    @Column(name = "sort")
    public Integer getSort() {
        return sort;
    }

    public void setSort(Integer sort) {
        this.sort = sort;
    }

    @Column(name = "status")
    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Column(name = "group_name")
    @Where(clause = "group_name = masterRecommended")
    public String getGroup() {
        return group;
    }

    public void setGroup(String group) {
        this.group = group;
    }

    @Override
    public String toString() {
        return "TenantRecommended{id = " + id + "}";
    }
}
