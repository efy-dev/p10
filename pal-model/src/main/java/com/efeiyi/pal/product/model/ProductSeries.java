package com.efeiyi.pal.product.model;

import com.efeiyi.pal.organization.model.Tenant;
import com.fasterxml.jackson.annotation.JsonIgnore;
import org.hibernate.annotations.GenericGenerator;
import org.hibernate.annotations.Where;

import javax.persistence.*;
import java.util.List;

/**
 * Created by Administrator on 2015/7/15.
 */

@Entity
@Table(name = "product_series")
public class ProductSeries {

    private String id;
    private String name;
    private String serial;
    private Tenant tenant;
    private String status;
    private List<ProductSeriesPropertyName> productSeriesPropertyNameList;

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

    @Column(name = "serial")
    public String getSerial() {
        return serial;
    }

    public void setSerial(String serial) {
        this.serial = serial;
    }

    @JsonIgnore
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "tenant_id")
    public Tenant getTenant() {
        return tenant;
    }

    public void setTenant(Tenant tenant) {
        this.tenant = tenant;
    }

    @Column(name = "status")
    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @JsonIgnore
    @OneToMany(fetch = FetchType.LAZY, mappedBy = "productSeries")
    @Where(clause = "status = '1'")
    public List<ProductSeriesPropertyName> getProductSeriesPropertyNameList() {
        return productSeriesPropertyNameList;
    }

    public void setProductSeriesPropertyNameList(List<ProductSeriesPropertyName> productSeriesPropertyNameList) {
        this.productSeriesPropertyNameList = productSeriesPropertyNameList;
    }

}
