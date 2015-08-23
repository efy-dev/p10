package com.efeiyi.pal.product.model;

import com.efeiyi.pal.organization.model.Tenant;
import com.fasterxml.jackson.annotation.JsonIgnore;
import org.hibernate.annotations.GenericGenerator;
import org.hibernate.annotations.Where;

import javax.persistence.*;
import java.util.List;
import java.util.Set;

/**
 * Created by Administrator on 2015/7/15.
 */

@Entity
@Table(name = "product_series")
public class ProductSeries {

    private String id;
    private String name;
    private String serial;
    private String status;
    private List<ProductSeriesPropertyName> productSeriesPropertyNameList;

    private List<TenantProductSeries> tenantProductSeriesList;

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

    @JsonIgnore
    @OneToMany(fetch = FetchType.LAZY, mappedBy = "productSeries")
    @Where(clause = "status = '1'")
    public List<TenantProductSeries> getTenantProductSeriesList() {
        return tenantProductSeriesList;
    }

    public void setTenantProductSeriesList(List<TenantProductSeries> tenantProductSeriesList) {
        this.tenantProductSeriesList = tenantProductSeriesList;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        ProductSeries that = (ProductSeries) o;

        return id.equals(that.id);

    }

    @Override
    public int hashCode() {
        return id.hashCode();
    }

}
