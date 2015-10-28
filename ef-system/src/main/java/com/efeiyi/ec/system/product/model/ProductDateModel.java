package com.efeiyi.ec.system.product.model;

import com.efeiyi.ec.master.model.Master;
import com.efeiyi.ec.product.model.ProductDescription;
import com.efeiyi.ec.product.model.ProductModel;
import com.efeiyi.ec.product.model.ProductPicture;
import com.efeiyi.ec.project.model.Project;
import com.efeiyi.ec.tenant.model.Tenant;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

/**
 * Created by Administrator on 2015/10/28.
 */
public class ProductDateModel implements Serializable {
    private String id;
    private String name;
    private String serial;
    private String picture_url;
    private Master master;
    //    private ProjectCategory category;
    private BigDecimal price;
    private List<ProductPicture> productPictureList;
    private ProductDescription productDescription;
    private String status;//1:上架 2 下架
    private Project project;
    private Date createDateTime;
    private Tenant tenant;
    //    private List<ProjectProperty> projectPropertyList;//项目属性 可以使用project获得
//    private List<ProductPropertyValue> productPropertyValueList;//项目属性值（所有可能的值）可以使用project获得
    private Integer recommendedIndex;//首页推荐排序字段
    private List<ProductModel> productModelList;
    private String subName;//副标题
    private Long fsAmount;
    private Long amount;
    private  String type;//1：普通2：收藏品

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getSerial() {
        return serial;
    }

    public void setSerial(String serial) {
        this.serial = serial;
    }

    public String getPicture_url() {
        return picture_url;
    }

    public void setPicture_url(String picture_url) {
        this.picture_url = picture_url;
    }

    public Master getMaster() {
        return master;
    }

    public void setMaster(Master master) {
        this.master = master;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public List<ProductPicture> getProductPictureList() {
        return productPictureList;
    }

    public void setProductPictureList(List<ProductPicture> productPictureList) {
        this.productPictureList = productPictureList;
    }

    public ProductDescription getProductDescription() {
        return productDescription;
    }

    public void setProductDescription(ProductDescription productDescription) {
        this.productDescription = productDescription;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Project getProject() {
        return project;
    }

    public void setProject(Project project) {
        this.project = project;
    }

    public Date getCreateDateTime() {
        return createDateTime;
    }

    public void setCreateDateTime(Date createDateTime) {
        this.createDateTime = createDateTime;
    }

    public Tenant getTenant() {
        return tenant;
    }

    public void setTenant(Tenant tenant) {
        this.tenant = tenant;
    }

    public Integer getRecommendedIndex() {
        return recommendedIndex;
    }

    public void setRecommendedIndex(Integer recommendedIndex) {
        this.recommendedIndex = recommendedIndex;
    }

    public List<ProductModel> getProductModelList() {
        return productModelList;
    }

    public void setProductModelList(List<ProductModel> productModelList) {
        this.productModelList = productModelList;
    }

    public String getSubName() {
        return subName;
    }

    public void setSubName(String subName) {
        this.subName = subName;
    }

    public Long getFsAmount() {
        return fsAmount;
    }

    public void setFsAmount(Long fsAmount) {
        this.fsAmount = fsAmount;
    }

    public Long getAmount() {
        return amount;
    }

    public void setAmount(Long amount) {
        this.amount = amount;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }
}
