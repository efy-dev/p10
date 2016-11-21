package com.efeiyi.ec.organization.model;

import com.efeiyi.ec.product.model.ProductModel;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import org.hibernate.annotations.GenericGenerator;
import org.hibernate.annotations.Where;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;

/**
 * Created by ZLH on 2016/11/2.
 */
@Entity
@Table(name = "hot")
@JsonIgnoreProperties(value = {"hibernateLazyInitializer", "handler"})
public class HotSpot implements Serializable {
    private String id;
    private String name;
    private Double abscissa;    //横坐标
    private Double ordinate;   //纵坐标
    private String status;
    private Date createDateTime;
    private ProductModel productModel;
    private Image image;

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

    @Column(name = "abscissa")
    public Double getAbscissa() {
        return abscissa;
    }

    public void setAbscissa(Double abscissa) {
        this.abscissa = abscissa;
    }

    @Column(name = "ordinate")
    public Double getOrdinate() {
        return ordinate;
    }

    public void setOrdinate(Double ordinate) {
        this.ordinate = ordinate;
    }

    @Column(name = "status")
    @Where(clause = "status=1")
    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Column(name = "createDateTime")
    public Date getCreateDateTime() {
        return createDateTime;
    }

    public void setCreateDateTime(Date createDateTime) {
        this.createDateTime = createDateTime;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "product_model_id")
    public ProductModel getProductModel() {
        return productModel;
    }

    public void setProductModel(ProductModel productModel) {
        this.productModel = productModel;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "image_id")
    /*@JsonIgnore*/
    public Image getImage() {
        return image;
    }

    public void setImage(Image image) {
        this.image = image;
    }

    @Override
    public String toString() {
        return "HotSpot{" +
                "id='" + id + '\'' +
                ", name='" + name + '\'' +
                ", abscissa=" + abscissa +
                ", ordinate=" + ordinate +
                ", status='" + status + '\'' +
                ", createDateTime=" + createDateTime +
                ", productModel=" + productModel +
                '}';
    }
}
