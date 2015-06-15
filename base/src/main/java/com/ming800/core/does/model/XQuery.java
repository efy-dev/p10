package com.ming800.core.does.model;

import java.util.LinkedHashMap;

/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 13-2-5
 * Time: 下午5:02
 * To change this template use File | Settings | File Templates.
 */
public class XQuery {

    private Boolean flag;
    private StringBuilder stringBuilder;
    private LinkedHashMap<String, Object> queryParamMap;


    public Boolean getFlag() {
        return flag;
    }

    public void setFlag(Boolean flag) {
        this.flag = flag;
    }

    public StringBuilder getStringBuilder() {
        return stringBuilder;
    }

    public void setStringBuilder(StringBuilder stringBuilder) {
        this.stringBuilder = stringBuilder;
    }

    public LinkedHashMap<String, Object> getQueryParamMap() {
        return queryParamMap;
    }

    public void setQueryParamMap(LinkedHashMap<String, Object> queryParamMap) {
        this.queryParamMap = queryParamMap;
    }
}
