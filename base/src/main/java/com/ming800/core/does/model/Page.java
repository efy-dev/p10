package com.ming800.core.does.model;

import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 13-1-8
 * Time: 下午5:00
 * To change this template use File | Settings | File Templates.
 */
public interface Page {

    public String getName();

    public void setName(String name);

    public String getLabel();

    public void setLabel(String label);

    public String getType();

    public void setType(String type);

    public String getUrl();

    public void setUrl(String url);

    public String getTotal();

    public void setTotal(String total);

    public String getSortName();

    public void setSortName(String sortName);

    public List<PageField> getFieldList();

    public void setFieldList(List<PageField> fieldList);

    public List<Command> getCommandList();

    public void setCommandList(List<Command> commandList);

    public List<Command> getOperationList();

    public void setOperationList(List<Command> operationList);

    public List<Command> getBatchOperationList();

    public void setBatchOperationList(List<Command> batchOperationList);
}
