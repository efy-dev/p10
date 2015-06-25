package com.ming800.core.does.model;

import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 13-1-8
 * Time: 下午5:01
 * To change this template use File | Settings | File Templates.
 */
public class Page{


    private String name;
    private String label;
    private String type;       /*分页*/
    private String url;        /*form  页面的保存链接*/
    private String total;
    private String sortName;

    private List<PageField> fieldList;
    private List<Command> commandList;
    private List<Command> operationList;
    private List<Command> batchOperationList;

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

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public String getTotal() {
        return total;
    }

    public void setTotal(String total) {
        this.total = total;
    }

    public String getSortName() {
        return sortName;
    }

    public void setSortName(String sortName) {
        this.sortName = sortName;
    }

    public List<Command> getCommandList() {
        return commandList;
    }

    public void setCommandList(List<Command> commandList) {
        this.commandList = commandList;
    }

    public List<PageField> getFieldList() {
        return fieldList;
    }

    public void setFieldList(List<PageField> fieldList) {
        this.fieldList = fieldList;
    }

    public List<Command> getOperationList() {
        return operationList;
    }

    public void setOperationList(List<Command> operationList) {
        this.operationList = operationList;
    }

    public List<Command> getBatchOperationList() {
        return batchOperationList;
    }

    public void setBatchOperationList(List<Command> batchOperationList) {
        this.batchOperationList = batchOperationList;
    }
}
