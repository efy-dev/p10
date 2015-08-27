package com.efeiyi.pal.product.model;

import org.hibernate.annotations.GenericGenerator;
import org.hibernate.annotations.NotFound;
import org.hibernate.annotations.NotFoundAction;
import org.hibernate.annotations.Where;

import javax.persistence.*;

/**
 * Created by Administrator on 2015/7/15.
 */

@Entity
@Table(name = "product_series_property_name")
public class ProductSeriesPropertyName {

    private String id;
    private ProductSeries productSeries;
    private String name;
    private String status;
    private ProductPropertyValue productPropertyValue;

    @OneToOne
    @JoinColumn(name="id")
    @Where(clause = "status='1'")
    @NotFound(action= NotFoundAction.IGNORE)
    public ProductPropertyValue getProductPropertyValue() {
        return productPropertyValue;
    }

    public void setProductPropertyValue(ProductPropertyValue productPropertyValue) {
        this.productPropertyValue = productPropertyValue;
    }

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
    @JoinColumn(name = "product_series_id")
    @Where(clause = "status='1'")
    @NotFound(action= NotFoundAction.IGNORE)
    public ProductSeries getProductSeries() {
        return productSeries;
    }

    public void setProductSeries(ProductSeries productSeries) {
        this.productSeries = productSeries;
    }

    @Column(name = "name")
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Column(name = "status")
    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

}
