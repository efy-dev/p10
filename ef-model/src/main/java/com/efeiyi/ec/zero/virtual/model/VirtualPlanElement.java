package com.efeiyi.ec.zero.virtual.model;

/**
 * Created by Administrator on 2015/12/9.
 * 显示虚拟计划 记录关联数量及完成数量
 */
public class VirtualPlanElement {

    private VirtualPlan virtualPlan;
    private Integer relation;//关联数量
    private Integer complete;//完成数量
    private String type;

    public VirtualPlan getVirtualPlan() {
        return virtualPlan;
    }

    public void setVirtualPlan(VirtualPlan virtualPlan) {
        this.virtualPlan = virtualPlan;
    }

    public Integer getRelation() {
        return relation;
    }

    public void setRelation(Integer relation) {
        this.relation = relation;
    }

    public Integer getComplete() {
        return complete;
    }

    public void setComplete(Integer complete) {
        this.complete = complete;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }
}
