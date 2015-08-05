package com.efeiyi.ec.product.model;

import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.math.BigDecimal;
import java.util.List;

/**
 * Created by Administrator on 2015/8/5.
 */
@Entity
@Table(name = "product_model")
public class ProductModel {

    private String id ;
    private String serial; // 产品编号
    private BigDecimal price ;//产品价格
    private Product product ;//产品种类
    private Integer amount; //库存
    private List<ProductPropertyValue> productPropertyValueList; //属性值
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

    @OneToMany(fetch = FetchType.LAZY,mappedBy = "productModel")
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
}
