package com.efeiyi.ec.tenant.model;

import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;

/**
 * Created by AC丶man on 2015/7/17.
 */
@Entity
@Table(name = "tenant_attachment")
public class TenantAttachment {

    private String id ;
    private String path;
    private TenantIntroduction introduction;

    @Id
    @GenericGenerator(name = "id", strategy = "com.ming800.core.p.model.M8idGenerator")
    @GeneratedValue(generator = "id")
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    @Column(name = "path")
    public String getPath() {
        return path;
    }

    public void setPath(String path) {
        this.path = path;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "tenant_introduction_id")
    public TenantIntroduction getIntroduction() {
        return introduction;
    }

    public void setIntroduction(TenantIntroduction introduction) {
        this.introduction = introduction;
    }
}
