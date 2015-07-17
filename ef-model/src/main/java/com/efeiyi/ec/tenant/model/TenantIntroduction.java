package com.efeiyi.ec.tenant.model;

import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.util.List;

/**
 * Created by Administrator on 2015/6/24.
 */
@Entity
@Table(name="tenant_introduction")
public class TenantIntroduction {
    private String id;
    private Tenant tenant;
    private String type;
    private String title;
    private List<TenantAttachment> attachmentList;


    @Id
    @GenericGenerator(name = "id", strategy = "com.ming800.core.p.model.M8idGenerator")
    @GeneratedValue(generator = "id")
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    @ManyToOne(fetch=FetchType.LAZY)
    @JoinColumn(name = "tenant_id")
    public Tenant getTenant() {
        return tenant;
    }

    public void setTenant(Tenant tenant) {
        this.tenant = tenant;
    }

    @Column(name="type")
    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    @Column(name="title")
    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "introduction")
    public List<TenantAttachment> getAttachmentList() {
        return attachmentList;
    }

    public void setAttachmentList(List<TenantAttachment> attachmentList) {
        this.attachmentList = attachmentList;
    }
}
