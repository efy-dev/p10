package com.ming800.core.does.model;

import org.codehaus.jackson.annotate.JsonIgnore;

import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: ming
 * Date: 13-1-22
 * Time: 上午9:51
 * To change this template use File | Settings | File Templates.
 */
public class StatusType {

    private String fieldName; //名称
    private String required;
    private String label;  //标题
    private StatusTypeField statusTypeField;
    private List<StatusTypeItem> statusTypeItemList;
    private String data; //额外的数据


    public String getData() {
        return data;
    }

    public void setData(String data) {
        this.data = data;
    }

    public String getLabel() {
        return label;
    }

    public void setLabel(String label) {
        this.label = label;
    }

    @JsonIgnore
    public StatusTypeField getStatusTypeField() {
        return statusTypeField;
    }

    public void setStatusTypeField(StatusTypeField statusTypeField) {
        this.statusTypeField = statusTypeField;
    }

    public String getFieldName() {
        return fieldName;
    }

    public void setFieldName(String fieldName) {
        this.fieldName = fieldName;
    }

    public String getRequired() {
        return required;
    }

    public void setRequired(String required) {
        this.required = required;
    }

    public List<StatusTypeItem> getStatusTypeItemList() {
        return statusTypeItemList;
    }

    public void setStatusTypeItemList(List<StatusTypeItem> statusTypeItemList) {
        this.statusTypeItemList = statusTypeItemList;
    }
}
