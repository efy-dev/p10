package com.efeiyi.ec.tenant.model;

import com.efeiyi.ec.organization.model.ImageColumn;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.util.List;

/**
 * Created by Administrator on 2016/9/2 0002.
 */
@Entity
@Table(name = "description")
public class TenantColumn {

    private String id;
    private String text;
    private List<ImageColumn> imageList;
    private BigTenant bigTenant;
    private String status;
    private String type;

    @Id
    @GenericGenerator(name = "id", strategy = "com.ming800.core.p.model.M8idGenerator")
    @GeneratedValue(generator = "id")
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    @Column(name = "text")
    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "columnId")
    public List<ImageColumn> getImageList() {
        return imageList;
    }

    public void setImageList(List<ImageColumn> imageList) {
        this.imageList = imageList;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "ower_id")
    public BigTenant getBigTenant() {
        return bigTenant;
    }

    @Column(name = "status")
    public void setBigTenant(BigTenant bigTenant) {
        this.bigTenant = bigTenant;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Column(name = "type")
    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }
}
