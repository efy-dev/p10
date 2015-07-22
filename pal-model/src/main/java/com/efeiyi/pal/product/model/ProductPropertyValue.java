package com.efeiyi.pal.product.model;

import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;

/**
 * Created by Administrator on 2015/7/15.
 */

@Entity
@Table(name = "product_property_value")
public class ProductPropertyValue {

    private String id;
    private ProductSeriesPropertyName productSeriesPropertyName;
    private String value;
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
    @JoinColumn(name = "product_series_property_name_id")
    public ProductSeriesPropertyName getProductSeriesPropertyName() {
        return productSeriesPropertyName;
    }

    public void setProductSeriesPropertyName(ProductSeriesPropertyName productSeriesPropertyName) {
        this.productSeriesPropertyName = productSeriesPropertyName;
    }

    @Column(name = "value")
    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }

    @Column(name = "status")
    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

}
