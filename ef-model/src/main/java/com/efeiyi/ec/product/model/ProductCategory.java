package com.efeiyi.ec.product.model;

import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;

/**
 * Created by Administrator on 2015/5/28.
 */
@Entity
@Table(name = "product_category")
public class ProductCategory {
    private String id;
    private String name;
    private String fatherCategory;

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

    @Column(name = "fathercategory_id")
    public String getFatherCategory() {
        return fatherCategory;
    }

    public void setFatherCategory(String fatherCategory) {
        this.fatherCategory = fatherCategory;
    }
}
