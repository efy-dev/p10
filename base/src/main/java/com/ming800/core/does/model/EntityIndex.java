package com.ming800.core.does.model;

import java.util.LinkedHashMap;

/**
 * Created with IntelliJ IDEA.
 * User: ming
 * Date: 12-11-28
 * Time: 上午9:51
 * To change this template use File | Settings | File Templates.
 */
public class EntityIndex {


    private String name;
    private String label;
    private String model;

    private LinkedHashMap<String, Field> fieldMap;

    public String getLabel() {
        return label;
    }

    public void setLabel(String label) {
        this.label = label;
    }

    public String getModel() {
        return model;
    }

    public void setModel(String model) {
        this.model = model;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public LinkedHashMap<String, Field> getFieldMap() {
        return fieldMap;
    }

    public void setFieldMap(LinkedHashMap<String, Field> fieldMap) {
        this.fieldMap = fieldMap;
    }
}
