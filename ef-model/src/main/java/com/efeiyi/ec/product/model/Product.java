package com.efeiyi.ec.product.model;

import com.efeiyi.ec.project.model.ProjectCategory;
import com.efeiyi.ec.master.model.Master;
import com.efeiyi.ec.project.model.Project;
import com.efeiyi.ec.project.model.ProjectProperty;
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
@Table(name = "product")
public class Product {
    private String id;
    private String name;
    private String serial;
    private String picture_url;
    private Tenant tenant;
    private ProjectCategory category;
    private BigDecimal price;
    private List<ProductPicture> productPictureList;
    private ProductDescription productDescription;
    private String status;
    private Project project;
    private Date createDateTime;
//    private List<ProjectProperty> projectPropertyList;//项目属性 可以使用project获得
//    private List<ProductPropertyValue> productPropertyValueList;//项目属性值（所有可能的值）可以使用project获得

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
    @JsonIgnore
    public Tenant getTenant() {
        return tenant;
    }

    public void setTenant(Tenant tenant) {
        this.tenant = tenant;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "category_id")
    @JsonIgnore
    public ProjectCategory getCategory() {
        return category;
    }

    public void setCategory(ProjectCategory category) {
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
    @JsonIgnore
    public List<ProductPicture> getProductPictureList() {
        return productPictureList;
    }


    public void setProductPictureList(List<ProductPicture> productPictureList) {
        this.productPictureList = productPictureList;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name="product_description_id")
    @JsonIgnore
    public ProductDescription getProductDescription() {
        return productDescription;
    }

    public void setProductDescription(ProductDescription productDescription) {
        this.productDescription = productDescription;
    }

    @Column(name="status")
    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name="project_id")
    @JsonIgnore
    public Project getProject() {
        return project;
    }

    public void setProject(Project project) {
        this.project = project;
    }

    @Column(name = "create_datetime")
    public Date getCreateDateTime() {
        return createDateTime;
    }

    public void setCreateDateTime(Date createDateTime) {
        this.createDateTime = createDateTime;
    }

}
