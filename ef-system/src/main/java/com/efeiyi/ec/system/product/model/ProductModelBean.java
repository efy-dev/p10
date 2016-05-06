package com.efeiyi.ec.system.product.model;

import java.io.Serializable;

/**
 * Created by Administrator on 2015/8/5.
 */

public class ProductModelBean implements Serializable {

    private String[] modelId;
    private String[] modelName;
    private String[] modelAmount;
    private String[] modelPrice;
    private String[] modelStatus;
    private String[] modelProperty;
    private String[] property;
    private String[] marketPrice;
    private Double[] weight;
    private String[] freeDelivery;
    private String productId;
    private String defaultId;
    private String defaultStatus;
    private String defaultName;
    private String defaultAmount;
    private String defaultPrice;
    private String defaultMarketPrice;
    private Double defaultWeight;
    private String defaultFreeDelivery;

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


    public String[] getProperty() {
        return property;
    }

    public void setProperty(String[] property) {
        this.property = property;
    }

    public String getDefaultId() {
        return defaultId;
    }

    public void setDefaultId(String defaultId) {
        this.defaultId = defaultId;
    }

    public String getDefaultStatus() {
        return defaultStatus;
    }

    public void setDefaultStatus(String defaultStatus) {
        this.defaultStatus = defaultStatus;
    }

    public String getDefaultName() {
        return defaultName;
    }

    public void setDefaultName(String defaultName) {
        this.defaultName = defaultName;
    }

    public String getDefaultAmount() {
        return defaultAmount;
    }

    public void setDefaultAmount(String defaultAmount) {
        this.defaultAmount = defaultAmount;
    }

    public String getDefaultPrice() {
        return defaultPrice;
    }

    public void setDefaultPrice(String defaultPrice) {
        this.defaultPrice = defaultPrice;
    }

    public String getDefaultMarketPrice() {
        return defaultMarketPrice;
    }

    public void setDefaultMarketPrice(String defaultMarketPrice) {
        this.defaultMarketPrice = defaultMarketPrice;
    }

    public String[] getMarketPrice() {
        return marketPrice;
    }

    public void setMarketPrice(String[] marketPrice) {
        this.marketPrice = marketPrice;
    }

    public Double[] getWeight() {
        return weight;
    }

    public void setWeight(Double[] weight) {
        this.weight = weight;
    }

    public Double getDefaultWeight() {
        return defaultWeight;
    }

    public void setDefaultWeight(Double defaultWeight) {
        this.defaultWeight = defaultWeight;
    }

    public String[] getFreeDelivery() {
        return freeDelivery;
    }

    public void setFreeDelivery(String[] freeDelivery) {
        this.freeDelivery = freeDelivery;
    }

    public String getDefaultFreeDelivery() {
        return defaultFreeDelivery;
    }

    public void setDefaultFreeDelivery(String defaultFreeDelivery) {
        this.defaultFreeDelivery = defaultFreeDelivery;
    }
}
