package com.efeiyi.ec.tenant.model;

import com.efeiyi.ec.product.model.ProductDescription;
import com.efeiyi.ec.product.model.ProductPicture;
import com.efeiyi.ec.product.model.ProductTenantCatalog;
import com.efeiyi.ec.project.model.Category;
import com.efeiyi.ec.project.model.Project;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

/**
 * Created by Administrator on 2015/6/26.
 */
@Entity
@Table(name = "product")
public class TenantWork {
    private String id;
    private String name;
    private String serial;
    private String picture_url;
    private Tenant tenant;
    private Category category;
    private BigDecimal price;
    private List<ProductPicture> productPictureList;
    private ProductDescription productDescription;
    private String status;
    private Project project;
    private Date createDateTime;
    private List<ProductTenantCatalog> productTenantCatalogList;



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

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "tenant_id")
    public Tenant getTenant() {
        return tenant;
    }

    public void setTenant(Tenant tenant) {
        this.tenant = tenant;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "category_id")
    public Category getCategory() {
        return category;
    }

    public void setCategory(Category category) {
        this.category = category;
    }

    @Column(name = "picture_url")
    public String getPicture_url() {
        return picture_url;
    }

    public void setPicture_url(String picture_url) {
        this.picture_url = picture_url;
    }

    @Column(name = "price")
    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "product")
    public List<ProductPicture> getProductPictureList() {
        return productPictureList;
    }


    public void setProductPictureList(List<ProductPicture> productPictureList) {
        this.productPictureList = productPictureList;
    }

    @OneToMany(fetch = FetchType.LAZY,mappedBy = "product")
    public List<ProductTenantCatalog> getProductTenantCatalogList() {
        return productTenantCatalogList;
    }

    public void setProductTenantCatalogList(List<ProductTenantCatalog> productTenantCatalogList) {
        this.productTenantCatalogList = productTenantCatalogList;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "product_description_id")
    public ProductDescription getProductDescription() {
        return productDescription;
    }

    public void setProductDescription(ProductDescription productDescription) {
        this.productDescription = productDescription;
    }

    @Column(name = "status")
    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "project_id")
    public Project getProject() {
        return project;
    }

    public void setProject(Project project) {
        this.project = project;
    }

    @Column(name="create_datetime")
    public Date getCreateDateTime() {
        return createDateTime;
    }

    public void setCreateDateTime(Date createDateTime) {
        this.createDateTime = createDateTime;
    }
}
