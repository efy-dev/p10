package com.efeiyi.ec.system.product.model;

import com.efeiyi.ec.product.model.Product;
import com.efeiyi.ec.product.model.ProductModel;
import com.efeiyi.ec.product.model.ProductPropertyValue;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.io.Serializable;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by Administrator on 2015/8/5.
 */

public class ProductModelBean implements Serializable {

    private  String [] modelId;
    private  String [] modelName;
    private  String [] modelAmount;
    private  String [] modelPrice;
    private  String [] modelStatus;
    private  String [] modelProperty;
    private  String productId;

    public String getProductId() {
        return productId;
    }

    public void setProductId(String productId) {
        this.productId = productId;
    }

    public String[] getModelId() {
        return modelId;
    }

    public void setModelId(String[] modelId) {
        this.modelId = modelId;
    }

    public String[] getModelName() {
        return modelName;
    }

    public void setModelName(String[] modelName) {
        this.modelName = modelName;
    }

    public String[] getModelAmount() {
        return modelAmount;
    }

    public void setModelAmount(String[] modelAmount) {
        this.modelAmount = modelAmount;
    }

    public String[] getModelPrice() {
        return modelPrice;
    }

    public void setModelPrice(String[] modelPrice) {
        this.modelPrice = modelPrice;
    }

    public String[] getModelStatus() {
        return modelStatus;
    }

    public void setModelStatus(String[] modelStatus) {
        this.modelStatus = modelStatus;
    }

    public String[] getModelProperty() {
        return modelProperty;
    }

    public void setModelProperty(String[] modelProperty) {
        this.modelProperty = modelProperty;
    }
}
