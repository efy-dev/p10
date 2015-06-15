package com.ming800.core.does.model;

import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: ming
 * Date: 13-1-22
 * Time: 上午9:51
 * To change this template use File | Settings | File Templates.
 */
public class StatusType {

    private String fieldName;
    private String required;

    private StatusTypeField statusTypeField;

    private List<StatusTypeItem> statusTypeItemList;

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
