package com.efeiyi.ec.zero.virtual.model;

import javax.persistence.*;
import java.util.Date;
import java.util.List;

/**
 * Created by Administrator on 2015/11/25.
 */
@Entity
@Table(name = "virtual_order_plan")
public class VirtualOrderPlan extends VirtualPlan{

    private Integer orderAmountFloor;
    private Integer orderAmountCeil;
    private List<VirtualProductModel> virtualProductModelList;
    private VirtualUserPlan virtualUserPlan;
    private Date peakTime;//均值小时
    private Integer standardDeviation; //标准差小时
    private List<VirtualPurchaseOrder> virtualPurchaseOrderList;

    @Column(name = "amount_floor")
    public Integer getOrderAmountFloor() {
        return orderAmountFloor;
    }

    public void setOrderAmountFloor(Integer orderAmountFloor) {
        this.orderAmountFloor = orderAmountFloor;
    }
    @Column(name = "amount_ceil")
    public Integer getOrderAmountCeil() {
        return orderAmountCeil;
    }

    public void setOrderAmountCeil(Integer orderAmountCeil) {
        this.orderAmountCeil = orderAmountCeil;
    }

    @OneToMany(fetch = FetchType.LAZY,mappedBy = "virtualOrderPlan")
    public List<VirtualProductModel> getVirtualProductModelList() {
        return virtualProductModelList;
    }

    public void setVirtualProductModelList(List<VirtualProductModel> virtualProductModelList) {
        this.virtualProductModelList = virtualProductModelList;
    }

    @Column(name = "peak_time")
    public Date getPeakTime() {
        return peakTime;
    }

    public void setPeakTime(Date peakTime) {
        this.peakTime = peakTime;
    }

    @Column(name = "standard_deviation")
    public Integer getStandardDeviation() {
        return standardDeviation;
    }

    public void setStandardDeviation(Integer standardDeviation) {
        this.standardDeviation = standardDeviation;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "virtual_user_plan_id")
    public VirtualUserPlan getVirtualUserPlan() {
        return virtualUserPlan;
    }

    public void setVirtualUserPlan(VirtualUserPlan virtualUserPlan) {
        this.virtualUserPlan = virtualUserPlan;
    }

    @OneToMany(fetch = FetchType.LAZY,mappedBy = "virtualOrderPlan")
    public List<VirtualPurchaseOrder> getVirtualPurchaseOrderList() {
        return virtualPurchaseOrderList;
    }

    public void setVirtualPurchaseOrderList(List<VirtualPurchaseOrder> virtualPurchaseOrderList) {
        this.virtualPurchaseOrderList = virtualPurchaseOrderList;
    }
}
