package com.efeiyi.pal.product.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;

/**
 * Created by Administrator on 2015/8/23.
 */

@Entity
@Table(name = "tenant_product_series_img")
public class TenantProductSeriesImg {

    private String id;
    private TenantProductSeries tenantProductSeries;
    private String imgUrl;
    private int sort;
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

    @JsonIgnore
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "tenant_product_series_id")
    public TenantProductSeries getTenantProductSeries() {
        return tenantProductSeries;
    }

    public void setTenantProductSeries(TenantProductSeries tenantProductSeries) {
        this.tenantProductSeries = tenantProductSeries;
    }

    @Column(name = "img_url")
    public String getImgUrl() {
        return imgUrl;
    }

    public void setImgUrl(String imgUrl) {
        this.imgUrl = imgUrl;
    }

    @Column(name = "sort")
    public int getSort() {
        return sort;
    }

    public void setSort(int sort) {
        this.sort = sort;
    }

    @Column(name = "status")
    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

}
