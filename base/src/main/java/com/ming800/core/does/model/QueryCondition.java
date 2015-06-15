package com.ming800.core.does.model;

/**
 * Created with IntelliJ IDEA.
 * User: ming
 * Date: 12-11-19
 * Time: 上午9:08
 * To change this template use File | Settings | File Templates.
 */
public interface QueryCondition {

    public String getName();

    public void setName(String name);

    public String getValue();

    public void setValue(String value);

    public String getLabel();

    public void setLabel(String label);

    public String getOperation();

    public void setOperation(String operation);

    public String getInputType();

    public void setInputType(String inputType);

    public String getKey();

    public void setKey(String key);

    public String getDataType();

    public void setDataType(String dataType);

    public Boolean getRequired();

    public void setRequired(Boolean required);

}
