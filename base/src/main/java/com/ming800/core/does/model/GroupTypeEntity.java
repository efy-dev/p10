package com.ming800.core.does.model;

/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 13-1-6
 * Time: 下午5:21
 * To change this template use File | Settings | File Templates.
 */
public class GroupTypeEntity {

    private String name;
    private String value;
    private String extendName;
    private Integer counts;
    private String total;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getValue() {
        return value;
    }

    public String getExtendName() {
        return extendName;
    }

    public void setExtendName(String extendName) {
        this.extendName = extendName;
    }

    public void setValue(String value) {
        this.value = value;
    }

    public Integer getCounts() {
        return counts;
    }

    public void setCounts(Integer counts) {
        this.counts = counts;
    }

    public String getTotal() {
        return total;
    }

    public void setTotal(String total) {
        this.total = total;
    }
}
