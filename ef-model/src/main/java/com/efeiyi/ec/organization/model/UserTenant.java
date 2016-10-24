package com.efeiyi.ec.organization.model;

import com.efeiyi.ec.tenant.model.BigTenant;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import org.hibernate.annotations.GenericGenerator;
import org.hibernate.annotations.Where;

import javax.persistence.*;

/**
 * Created by Administrator on 2016/10/24.
 */
@Entity
@Table(name = "user_tenant")
@JsonIgnoreProperties(value = {"hibernateLazyInitializer", "handler"})
public class UserTenant {
    private String id;
    private BigUser user;
    private BigTenant tenant;
    private String status;

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
    @JoinColumn(name = "user_id")
    public BigUser getUser() {
        return user;
    }

    public void setUser(BigUser user) {
        this.user = user;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "tenant_id")
    public BigTenant getTenant() {
        return tenant;
    }

    public void setTenant(BigTenant tenant) {
        this.tenant = tenant;
    }

    @Column(name = "status")
    @Where(clause = "status=1")
    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "UserTenant{" +
                "id='" + id + '\'' +
                ", user=" + user +
                ", tenant=" + tenant +
                ", status='" + status + '\'' +
                '}';
    }
}
