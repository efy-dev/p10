package com.efeiyi.ec.product.model;

import com.efeiyi.ec.project.model.ProjectProperty;
import com.efeiyi.ec.project.model.ProjectPropertyValue;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;

/**
 * Created by Administrator on 2015/8/5.
 * 每个产品种类有多个属性 颜色 材料 每种属性又有多种值 红色 绿色 ，金属 瓷
 * 在产品种类中记录着该类产品的所有属性，以及所有属性可能包含的值
 * ProductPropertyValue类 与产品规格类相关联
 * 每个产品属于一个项目，每个项目都有很多属性，那么产品的属性也就是项目的属性，然后每个项目的属性都有一些可能的值，那么这些值也是产品可能的值
 * 这样的话就没有必要再在product类中添加项目属性的引用了
 * 在新建一个产品规格的时候需要重产品种类中选择产品属性以及对应的值然后生成一个ProductPropertyValue对象，该对象与ProductModel关联
 *
 * 在产品列表的时候列的是ProductModel
 *
 */
@Entity
@Table(name = "product_property_value")
public class ProductPropertyValue {

    private String id;
    private ProductModel productModel;
    private ProjectProperty projectProperty;   //属于哪个项目属性
    private ProjectPropertyValue projectPropertyValue;  //对应项目属性的哪个值

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
    @JoinColumn(name = "product_model_id")
    public ProductModel getProductModel() {
        return productModel;
    }

    public void setProductModel(ProductModel productModel) {
        this.productModel = productModel;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "project_property_id")
    public ProjectProperty getProjectProperty() {
        return projectProperty;
    }

    public void setProjectProperty(ProjectProperty projectProperty) {
        this.projectProperty = projectProperty;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "project_property_value_id")
    public ProjectPropertyValue getProjectPropertyValue() {
        return projectPropertyValue;
    }

    public void setProjectPropertyValue(ProjectPropertyValue projectPropertyValue) {
        this.projectPropertyValue = projectPropertyValue;
    }


    @Override
    public String toString() {
        return "ProductPropertyValue{id = " + id + "}";
    }
}
