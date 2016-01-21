package com.efeiyi.ec.product.model;

import com.efeiyi.ec.product.model.ProductModel;
import com.efeiyi.ec.product.model.Subject;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;

/**
 * Created by Administrator on 2015/9/16 0016.
 */


@Entity
@Table(name = "subject_product_model")
public class SubjectProductModel {

    private String id;
    private Subject subject;
    private ProductModel productModel;
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

    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "subject_id")
    public Subject getSubject() {
        return subject;
    }

    public void setSubject(Subject subject) {
        this.subject = subject;
    }

    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "product_model_id")
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

    @Override
    public String toString() {
        return "SubjectProductModel{id = " + id + "}";
    }
}
