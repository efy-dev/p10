package com.efeiyi.ec.tenant.model;

import com.efeiyi.ec.master.model.Master;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;

/**
 * Created by Administrator on 2015/8/18.
 */
@Entity
@Table(name = "tenant_master")
@JsonIgnoreProperties(value = {"hibernateLazyInitializer", "handler"})
public class TenantMaster {

    private String id;
    private BigTenant tenant;
    private Master master;
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
    @JoinColumn(name = "tenant_id")
    public BigTenant getTenant() {
        return tenant;
    }

    public void setTenant(BigTenant tenant) {
        this.tenant = tenant;
    }



    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "master_id")
    public Master getMaster() {
        return master;
    }

    public void setMaster(Master master) {
        this.master = master;
    }

    @Column(name = "status")
    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
