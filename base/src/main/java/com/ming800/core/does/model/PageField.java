package com.ming800.core.does.model;

/**
 * Created with IntelliJ IDEA.
 * User: ming
 * Date: 12-11-20
 * Time: 上午9:41
 * To change this template use File | Settings | File Templates.
 */

public class PageField {

    private String label;
    private String name;
    private String value;
    private String url;
    private String group;
    private String position;
    private String dataType;
    private String key;
    private String viewType;
    private String inputType;
    private String validateType;
    private Boolean isRequired;

    private String widths;
    private String aligns;
    private String dataOptions;
/*    *//*处理radio*//*
    private String prefix;
    private String checkValues;
    private String checkedValue;*/


    public String getLabel() {
        return label;
    }

    public void setLabel(String label) {
        this.label = label;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public String getGroup() {
        return group;
    }

    public void setGroup(String group) {
        this.group = group;
    }

    public String getPosition() {
        return position;
    }

    public void setPosition(String position) {
        this.position = position;
    }

    public String getViewType() {
        return viewType;
    }

    public void setViewType(String viewType) {
        this.viewType = viewType;
    }

    public String getInputType() {
        return inputType;
    }

    public void setInputType(String inputType) {
        this.inputType = inputType;
    }

    public String getDataType() {
        return dataType;
    }

    public String getKey() {
        return key;
    }

    public void setKey(String key) {
        this.key = key;
    }

    public void setDataType(String dataType) {
        this.dataType = dataType;
    }

    public Boolean getRequired() {
        return isRequired;
    }

    public void setRequired(Boolean required) {
        isRequired = required;
    }

    public String getValidateType() {
        return validateType;
    }

    public void setValidateType(String validateType) {
        this.validateType = validateType;
    }

    public String getWidths() {
        return widths;
    }

    public void setWidths(String widths) {
        this.widths = widths;
    }

    public String getAligns() {
        return aligns;
    }

    public void setAligns(String aligns) {
        this.aligns = aligns;
    }

    public String getDataOptions() {

        if (widths == null) {
            widths = "20";
        }
        String str = "field:'" + name + "',width:" + widths;

        if (aligns != null && !aligns.equals("")) {
            str += ",align:'" + aligns + "'";
        }
        return str;
    }


    /*    public String getPrefix() {
        return prefix;
    }

    public void setPrefix(String prefix) {
        this.prefix = prefix;
    }

    public String getCheckValues() {
        return checkValues;
    }

    public void setCheckValues(String checkValues) {
        this.checkValues = checkValues;
    }

    public String getCheckedValue() {
        return checkedValue;
    }

    public void setCheckedValue(String checkedValue) {
        this.checkedValue = checkedValue;
    }*/
}
