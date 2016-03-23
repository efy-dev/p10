package com.ming800.core.does.model;

import java.util.LinkedHashMap;

/**
 * Created with IntelliJ IDEA.
 * User: ming
 * Date: 12-11-28
 * Time: 上午9:51
 * To change this template use File | Settings | File Templates.
 */
public class Field {


    private String name;
    private String name2;
    private String label;
    private String value;
    private String inputType;
    private String key;
    private String dataType;
    private String gtype;
    private String gvalue;

    private String orderby;
    private String viewType;
    private String formType;

    private String fieldType;

    private String reference;

    private String source;

    public String getSource() {
        return source;
    }

    public void setSource(String source) {
        this.source = source;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getName2() {
        return name2;
    }

    public void setName2(String name2) {
        this.name2 = name2;
    }

    public String getLabel() {
        return label;
    }

    public void setLabel(String label) {
        this.label = label;
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }

    public String getInputType() {
        return inputType;
    }

    public void setInputType(String inputType) {
        this.inputType = inputType;
    }

    public String getKey() {
        return key;
    }

    public void setKey(String key) {
        this.key = key;
    }

    public String getGvalue() {
        return gvalue;
    }

    public void setGvalue(String gvalue) {
        this.gvalue = gvalue;
    }

    public String getGtype() {
        return gtype;
    }

    public void setGtype(String gtype) {
        this.gtype = gtype;
    }


    public String getDataType() {
        return dataType;
    }

    public void setDataType(String dataType) {
        this.dataType = dataType;
    }

    public String getOrderby() {
        return orderby;
    }

    public void setOrderby(String orderby) {
        this.orderby = orderby;
    }

    public String getViewType() {
        return viewType;
    }

    public void setViewType(String viewType) {
        this.viewType = viewType;
    }

    public String getFormType() {
        return formType;
    }

    public void setFormType(String formType) {
        this.formType = formType;
    }

    public String getFieldType() {
        return fieldType;
    }

    public void setFieldType(String fieldType) {
        this.fieldType = fieldType;
    }

    public String getReference() {
        return reference;
    }

    public void setReference(String reference) {
        this.reference = reference;
    }
}
