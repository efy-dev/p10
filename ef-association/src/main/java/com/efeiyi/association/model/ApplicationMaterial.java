package com.efeiyi.association.model;

/**
 * Created by Administrator on 2015/9/18.
 */

import com.efeiyi.ec.tenant.model.Tenant;
import com.ming800.core.p.model.Document;
import com.ming800.core.p.model.DocumentAttachment;
import org.hibernate.annotations.GenericGenerator;
import org.hibernate.annotations.NotFound;
import org.hibernate.annotations.NotFoundAction;
import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.*;
import java.util.Date;
import java.util.List;

@Entity(name = "association_application_material")
public class ApplicationMaterial {
    private String id;
    private String applyType;
    private Tenant tenant;
    private String group;
    @DateTimeFormat(pattern="yyyy-MM-dd")
    private Date theDatetime;
    private String status;
    private Document document;

    @Id
    @GenericGenerator(name = "id", strategy = "com.ming800.core.p.model.M8idGenerator")
    @GeneratedValue(generator = "id")
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    @Column(name = "apply_type")
    public String getApplyType() {
        return applyType;
    }

    public void setApplyType(String applyType) {
        this.applyType = applyType;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "tenant_id")
    @NotFound(action = NotFoundAction.IGNORE)
    public Tenant getTenant() {
        return tenant;
    }

    public void setTenant(Tenant tenant) {
        this.tenant = tenant;
    }

    @Column(name = "group_name")
    public String getGroup() {
        return group;
    }

    public void setGroup(String group) {
        this.group = group;
    }

    @Column(name = "the_datetime")
    public Date getTheDatetime() {
        return theDatetime;
    }

    public void setTheDatetime(Date theDatetime) {
        this.theDatetime = theDatetime;
    }

    @Column(name = "status")
    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "document_id")
    @NotFound(action = NotFoundAction.IGNORE)
    public Document getDocument() {
        return document;
    }

    public void setDocument(Document document) {
        this.document = document;
    }
}
