package com.ming800.core.does.model;

import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 13-6-4
 * Time: 下午3:47
 * To change this template use File | Settings | File Templates.
 */
public class TypeXml {

    private String name;
    private String label;
    private List<TypeXml> typeXmlList;


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

    public List<TypeXml> getTypeXmlList() {
        return typeXmlList;
    }

    public void setTypeXmlList(List<TypeXml> typeXmlList) {
        this.typeXmlList = typeXmlList;
    }
}
