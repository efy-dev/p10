package com.efeiyi.ec.product.model;

import com.efeiyi.ec.master.model.Master;
import com.efeiyi.ec.master.model.MasterWork;
import org.hibernate.annotations.GenericGenerator;
import org.hibernate.annotations.Where;

import javax.persistence.*;

/**
 * Created by Administrator on 2015/5/28.
 */
@Entity
@Table(name = "product_picture")
public class ProductPicture {
    private String id;
    private String pictureUrl;
    private String status;//1:商品图片 2: 主图片 3:详情页的图片
    private Product product;
    private ProductModel productModel;//规格商品
 //   private Integer sort;

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
    @JoinColumn(name = "product_id")
    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    @Column(name = "picture_url")
    public String getPictureUrl() {
        return pictureUrl;
    }

    public void setPictureUrl(String pictureUrl) {
        this.pictureUrl = pictureUrl;
    }

    @Column(name = "status")
    @Where(clause = "status!=0")
    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "product_model_id")
    public ProductModel getProductModel() {
        return productModel;
    }

    public void setProductModel(ProductModel productModel) {
        this.productModel = productModel;
    }
}
