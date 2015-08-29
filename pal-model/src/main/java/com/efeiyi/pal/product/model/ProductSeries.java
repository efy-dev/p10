package com.efeiyi.pal.product.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import org.hibernate.annotations.GenericGenerator;
import org.hibernate.annotations.Where;

import javax.persistence.*;
import java.util.List;

/**
 * Created by Administrator on 2015/7/15.
 */

@Entity
@Table(name = "product_series")
@JsonIgnoreProperties(value={"hibernateLazyInitializer","handler","operations","roles","menus"})
public class ProductSeries {

    private String id;
    private String name;
    private String serial;
    private String status;
    private List<ProductSeriesPropertyName> productSeriesPropertyNameList;

    private List<TenantProductSeries> tenantProductSeriesList;
    private List<Product> productList;

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

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "productSeries")
    @Where(clause = "status = '1'")
    public List<Product> getProductList() {
        return productList;
    }

    public void setProductList(List<Product> productList) {
        this.productList = productList;
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
