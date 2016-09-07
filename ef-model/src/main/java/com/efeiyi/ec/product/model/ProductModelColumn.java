package com.efeiyi.ec.product.model;

import com.efeiyi.ec.organization.model.ImageColumn;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.util.List;

/**
 * Created by Administrator on 2016/9/2 0002.
 */
@Entity
@Table(name = "description")
public class ProductModelColumn {

    private String id;
    private String text;
    private List<ImageColumn> imageList;
    private ProductModel productModel;
    private String status;
    private String type;

    @Id
    @GenericGenerator(name = "id", strategy = "com.ming800.core.p.model.M8idGenerator")
    @GeneratedValue(generator = "id")
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    @Column(name = "text")
    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

    //@TODO 待测试
    @OneToMany(fetch = FetchType.LAZY, mappedBy = "columnId")
    public List<ImageColumn> getImageList() {
        return imageList;
    }

    public void setImageList(List<ImageColumn> imageList) {
        this.imageList = imageList;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "ower_id")
    public ProductModel getProductModel() {
        return productModel;
    }

    public void setProductModel(ProductModel productModel) {
        this.productModel = productModel;
    }

    @Column(name = "status")
    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Column(name = "type")
    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }
}
