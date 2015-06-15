package com.ming800.core.does.model;


/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 13-4-16
 * Time: 下午2:04
 * To change this template use File | Settings | File Templates.
 */
public class ConfigProperty {

    private String name;
    private String label;
    private String type;
    private Module module;
    private String defaultValue;
    private String values;
    private String memo;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getLabel() {
        return label;
    }

    public void setLabel(String label) {
        this.label = label;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public Module getModule() {
        return module;
    }

    public void setModule(Module module) {
        this.module = module;
    }


    public String getDefaultValue() {
        return defaultValue;
    }

    public void setDefaultValue(String defaultValue) {
        this.defaultValue = defaultValue;
    }

    public String getValues() {
        return values;
    }

    public void setValues(String values) {
        this.values = values;
    }

    public String getMemo() {
        return memo;
    }

    public void setMemo(String memo) {
        this.memo = memo;
    }
}
