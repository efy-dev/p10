package com.efeiyi.ec.tenant.model;

import com.efeiyi.ec.project.model.Project;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.io.Serializable;

/**
 * Created by Administrator on 2015/7/17.
 */
@Entity
@Table(name = "tenant_project")
@JsonIgnoreProperties(value = {"hibernateLazyInitializer", "handler"})
public class TenantProject implements Serializable {
    private String id;
    private BigTenant tenant;
    private Project project;
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
    @JoinColumn(name = "project_id")
    public Project getProject() {
        return project;
    }

    public void setProject(Project project) {
        this.project = project;
    }

    @Column(name="status")
    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
