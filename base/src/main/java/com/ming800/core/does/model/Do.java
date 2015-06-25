package com.ming800.core.does.model;

import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: ming
 * Date: 12-11-10
 * Time: 上午9:59
 * To change this template use File | Settings | File Templates.
 */
public class Do{


    private String name;
    private String label;
    //    private String model;
    private String type;
    private Xentity xentity;
    private String execute;
    //    private String entity;
    private String result;
    private List<DoQuery> doQueryList;
    private List<Page> pageList;
    private String access;

    private String data;

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

/*public String getModel() {
        return model;
    }

    public void setModel(String model) {
        this.model = model;
    }*/

    public String getAccess() {
        return access;
    }

    public void setAccess(String access) {
        this.access = access;
    }

    public Xentity getXentity() {
        return xentity;
    }

    public void setXentity(Xentity xentity) {
        this.xentity = xentity;
    }

    public String getExecute() {
        return execute;
    }

    public void setExecute(String execute) {
        this.execute = execute;
    }

/*    public String getEntity() {
        return entity;
    }

    public void setEntity(String entity) {
        this.entity = entity;
    }*/

    public String getResult() {
        return result;
    }

    public void setResult(String result) {
        this.result = result;
    }

    public List<DoQuery> getDoQueryList() {
        return doQueryList;
    }

    public void setDoQueryList(List<DoQuery> doQueryList) {
        this.doQueryList = doQueryList;
    }

    public List<Page> getPageList() {
        return pageList;
    }

    public void setPageList(List<Page> pageList) {
        this.pageList = pageList;
    }

    public DoQuery getDoQueryByName(String name) {

        DoQuery doQuery = doQueryList.get(0);

        for (DoQuery tempDoQuery : doQueryList) {
            if (tempDoQuery.getName() != null && tempDoQuery.getName().equals(name)) {
                doQuery = tempDoQuery;
                break;
            }
        }

        return doQuery;  //To change body of implemented methods use File | Settings | File Templates.
    }

    public String getData() {
        return data;
    }

    public void setData(String data) {
        this.data = data;
    }
}
