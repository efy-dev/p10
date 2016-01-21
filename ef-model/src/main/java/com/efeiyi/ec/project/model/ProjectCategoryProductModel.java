package com.efeiyi.ec.project.model;

import com.efeiyi.ec.product.model.ProductModel;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import org.hibernate.annotations.GenericGenerator;
import org.hibernate.annotations.Where;

import javax.persistence.*;
import java.io.Serializable;
import java.util.List;

/**
 * Created by Administrator on 2015/7/22.
 * 非遗类别管理
 */
@Entity
@Table(name = "project_category_product_model")
@JsonIgnoreProperties(value = {"hibernateLazyInitializer", "handler"})
public class ProjectCategoryProductModel implements Serializable{
    private String id;

    private ProjectCategory projectCategory;

    private ProductModel productModel;

    private  String status;

    private  Integer sort;

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
    @JoinColumn(name = "project_category_id")
    public ProjectCategory getProjectCategory() {
        return projectCategory;
    }

    public void setProjectCategory(ProjectCategory projectCategory) {
        this.projectCategory = projectCategory;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "product_model_id")
    public ProductModel getProductModel() {
        return productModel;
    }

    public void setProductModel(ProductModel productModel) {
        this.productModel = productModel;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Column(name = "sort")
    public Integer getSort() {
        return sort;
    }

    public void setSort(Integer sort) {
        this.sort = sort;
    }

    @Override
    public String toString() {
        return "ProjectCategoryProductModel{id = " + id + "}";
    }
}

