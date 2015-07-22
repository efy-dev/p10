package com.efeiyi.ec.product.model;

import com.efeiyi.ec.project.model.Category;
import com.efeiyi.ec.project.model.Project;
import com.efeiyi.ec.tenant.model.Tenant;
import com.fasterxml.jackson.annotation.JsonIgnore;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

/**
 * Created by Administrator on 2015/5/28.
 */
@Entity
@Table(name = "product_tenant_catalog")
public class ProductTenantCatalog {
    private String id;
    private Product product;
    private ProductTenantCatalogValue productTenantCatalogValue;

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
    @JoinColumn(name = "product_tenant_catalog_value_id")
    @JsonIgnore
    public ProductTenantCatalogValue getProductTenantCatalogValue() {
        return productTenantCatalogValue;
    }

    public void setProductTenantCatalogValue(ProductTenantCatalogValue productTenantCatalogValue) {
        this.productTenantCatalogValue = productTenantCatalogValue;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "product_id")
    @JsonIgnore
    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }


}
