package com.efeiyi.ec.zero.promotion.model;


/**
 * Created by Administrator on 2015/12/7.
 * 用于页面显示 返利计划、注册量、订单数量及支付总额
 */
public class PromotionPlanElement {
    private PromotionPlan promotionPlan;//返利计划
    private String registerCount;//注册量
    private String orderCount;//订单数量
    private String orderAmount;//订单总额
    private String ordePaidAmount;//实付金额

    public PromotionPlan getPromotionPlan() {
        return promotionPlan;
    }

    public void setPromotionPlan(PromotionPlan promotionPlan) {
        this.promotionPlan = promotionPlan;
    }

    public String getRegisterCount() {
        return registerCount;
    }

    public void setRegisterCount(String registerCount) {
        this.registerCount = registerCount;
    }

    public String getOrderCount() {
        return orderCount;
    }

    public void setOrderCount(String orderCount) {
        this.orderCount = orderCount;
    }

    public String getOrderAmount() {
        return orderAmount;
    }

    public void setOrderAmount(String orderAmount) {
        this.orderAmount = orderAmount;
    }

    public String getOrdePaidAmount() {
        return ordePaidAmount;
    }

    public void setOrdePaidAmount(String ordePaidAmount) {
        this.ordePaidAmount = ordePaidAmount;
    }
}
