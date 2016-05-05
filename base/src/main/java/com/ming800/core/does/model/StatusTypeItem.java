package com.ming800.core.does.model;


import com.fasterxml.jackson.annotation.JsonProperty;

/**
 * Created with IntelliJ IDEA.
 * User: ming
 * Date: 13-1-22
 * Time: 上午9:51
 * To change this template use File | Settings | File Templates.
 */

public class StatusTypeItem {

    @JsonProperty(value = "text")
    private String label;
    @JsonProperty(value = "id")
    private String value;

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
}
