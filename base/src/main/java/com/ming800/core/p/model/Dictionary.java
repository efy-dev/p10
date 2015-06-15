package com.ming800.core.p.model;

import com.ming800.core.does.model.Field;

import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: lxh
 * Date: 2010-4-9
 * Time: 14:51:38
 * To change this template use File | Settings | File Templates.
 */

public class Dictionary extends Field {

    private String sid;
    private String[] definedNationValue;
    private List<DictionaryData> dictionaryDataList;

    private String required; //是否必选

    public String getSid() {
        return sid;
    }

    public void setSid(String sid) {
        this.sid = sid;
    }

    public String[] getDefinedNationValue() {
        return definedNationValue;
    }

    public void setDefinedNationValue(String[] definedNationValue) {
        this.definedNationValue = definedNationValue;
    }

    public List<DictionaryData> getDictionaryDataList() {
        return dictionaryDataList;
    }

    public void setDictionaryDataList(List<DictionaryData> dictionaryDataList) {
        this.dictionaryDataList = dictionaryDataList;
    }

    public String getRequired() {
        return required;
    }

    public void setRequired(String required) {
        this.required = required;
    }
}
