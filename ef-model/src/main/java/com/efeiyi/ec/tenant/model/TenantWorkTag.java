package com.efeiyi.ec.tenant.model;

import com.efeiyi.ec.project.model.ProjectTag;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;

/**
 * Created by Administrator on 2015/6/26.
 */
@Entity
@Table(name = "tenant_work_tag")
public class TenantWorkTag {
    private String id;
    private TenantWork tenantWork;
    private ProjectTag projectTag;
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
    @JoinColumn(name = "tenant_work_id")
    public TenantWork getTenantWork() {
        return tenantWork;
    }

    public void setTenantWork(TenantWork tenantWork) {
        this.tenantWork = tenantWork;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "project_tag_id")
    public ProjectTag getProjectTag() {
        return projectTag;
    }

    public void setProjectTag(ProjectTag projectTag) {
        this.projectTag = projectTag;
    }

    @Column(name = "status")
    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
