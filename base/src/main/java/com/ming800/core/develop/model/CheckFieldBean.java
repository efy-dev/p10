package com.ming800.core.develop.model;

/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 13-4-25
 * Time: 上午10:50
 * To change this template use File | Settings | File Templates.
 */
public class CheckFieldBean {


    private String moduleName;
    private String xentityName;
    private String tempDoName;
    private String tempDoQueryName;
    private String queryConditionName;


    public String getModuleName() {
        return moduleName;
    }

    public void setModuleName(String moduleName) {
        this.moduleName = moduleName;
    }

    public String getXentityName() {
        return xentityName;
    }

    public void setXentityName(String xentityName) {
        this.xentityName = xentityName;
    }

    public String getTempDoName() {
        return tempDoName;
    }

    public void setTempDoName(String tempDoName) {
        this.tempDoName = tempDoName;
    }

    public String getTempDoQueryName() {
        return tempDoQueryName;
    }

    public void setTempDoQueryName(String tempDoQueryName) {
        this.tempDoQueryName = tempDoQueryName;
    }

    public String getQueryConditionName() {
        return queryConditionName;
    }

    public void setQueryConditionName(String queryConditionName) {
        this.queryConditionName = queryConditionName;
    }
}
