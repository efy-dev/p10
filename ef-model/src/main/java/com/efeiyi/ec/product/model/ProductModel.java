package com.efeiyi.ec.product.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

/**
 * Created by Administrator on 2015/8/5.
 */
@Entity
@Table(name = "product_model")
@JsonIgnoreProperties(value = {"hibernateLazyInitializer", "handler"})
public class ProductModel implements Serializable {

    private String id;
    private String serial; // 产品编号
    private String status;//1.项目属性 2.自定义属性
    private String name;
    private String productModel_url; //商品主图
    private String freeDelivery;//是否包邮 1:包邮 0:不包邮
    private Product product;//产品种类
    private Integer recommendIndex;  //推荐序号
    private List<ProductPicture> productPictureList;
    private ProductModelDescription productModelDescription;

    private Double weight;
    private Integer amount; //库存
    private BigDecimal price;//产品价格
    private BigDecimal marketPrice;//市场价格

    private List<ProductPropertyValue> productPropertyValueList; //属性值
    private String customProperty;//自定义属性值
    private Integer popularityAmount;
    private Integer saleAmount;
    private Date createDateTime;
    private String audio;

    @Transient
    public String getAudio() {
        return audio;
    }

    public void setAudio(String audio) {
        this.audio = audio;
    }
    @Column(name = "create_datetime")
    public Date getCreateDateTime() {
        return createDateTime;
    }

    public void setCreateDateTime(Date createDateTime) {
        this.createDateTime = createDateTime;
    }

    @JsonIgnore
    @OneToMany(fetch = FetchType.LAZY, mappedBy = "productModel")
    public List<ProductPicture> getProductPictureList() {
        return productPictureList;
    }

    public void setProductPictureList(List<ProductPicture> productPictureList) {
        this.productPictureList = productPictureList;
    }

    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "product_description_id")
    @JsonIgnore
    public ProductModelDescription getProductModelDescription() {
        return productModelDescription;
    }

    public void setProductModelDescription(ProductModelDescription productModelDescription) {
        this.productModelDescription = productModelDescription;
    }

    @Column(name = "market_price")
    public BigDecimal getMarketPrice() {
        return marketPrice;
    }

    public void setMarketPrice(BigDecimal marketPrice) {
        this.marketPrice = marketPrice;
    }

    @Column(name = "product_model_url")
    public String getProductModel_url() {
        return productModel_url;
    }

    public void setProductModel_url(String productModel_url) {
        this.productModel_url = productModel_url;
    }

    @Column(name = "recommend_index")
    public Integer getRecommendIndex() {
        return recommendIndex;
    }

    public void setRecommendIndex(Integer recommendIndex) {
        this.recommendIndex = recommendIndex;
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

    @Column(name = "serial")
    public String getSerial() {
        return serial;
    }

    public void setSerial(String serial) {
        this.serial = serial;
    }

    @Column(name = "price")
    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "product_id")
    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    @Column(name = "amount")
    public Integer getAmount() {
        return amount;
    }

    public void setAmount(Integer amount) {
        this.amount = amount;
    }

    @JsonIgnore
    @OneToMany(fetch = FetchType.LAZY, mappedBy = "productModel")
    public List<ProductPropertyValue> getProductPropertyValueList() {
        return productPropertyValueList;
    }

    public void setProductPropertyValueList(List<ProductPropertyValue> productPropertyValueList) {
        this.productPropertyValueList = productPropertyValueList;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Column(name = "name")
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Column(name = "custom_property")
    public String getCustomProperty() {
        return customProperty;
    }

    public void setCustomProperty(String customProperty) {
        this.customProperty = customProperty;
    }

    @Column(name = "popularity_amount")
    public Integer getPopularityAmount() {
        return popularityAmount;
    }

    public void setPopularityAmount(Integer popularityAmount) {
        this.popularityAmount = popularityAmount;
    }

    @Column(name = "sale_amount")
    public Integer getSaleAmount() {
        return saleAmount;
    }

    public void setSaleAmount(Integer saleAmount) {
        this.saleAmount = saleAmount;
    }

    @Column(name = "weight")
    public Double getWeight() {
        return weight;
    }

    public void setWeight(Double weight) {
        this.weight = weight;
    }

    @Column(name = "free_delivery")
    public String getFreeDelivery() {
        return freeDelivery;
    }

    public void setFreeDelivery(String freeDelivery) {
        this.freeDelivery = freeDelivery;
    }

    @Override
    public String toString() {
        return "ProductModel{id = " + id + "}";
    }
}
