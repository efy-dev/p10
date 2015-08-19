package com.ming800.core.p.model;

import java.io.Serializable;

/**
 * Created by Administrator on 2015/8/18.
 *
 */
public class CommonSerial implements Serializable {
    private String step;//跨度
    private String prefix;//前缀
    private String group;//组别
    private String note;//说明
    private String length;//长度
    private String cacheSize;
    private String autoserialModel;
    public String getStep() {
        return step;
    }

    public void setStep(String step) {
        this.step = step;
    }

    public String getPrefix() {
        return prefix;
    }

    public void setPrefix(String prefix) {
        this.prefix = prefix;
    }

    public String getGroup() {
        return group;
    }

    public void setGroup(String group) {
        this.group = group;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public String getLength() {
        return length;
    }

    public void setLength(String length) {
        this.length = length;
    }

    public String getCacheSize() {
        return cacheSize;
    }

    public void setCacheSize(String cacheSize) {
        this.cacheSize = cacheSize;
    }

    public String getAutoserialModel() {
        return autoserialModel;
    }

    public void setAutoserialModel(String autoserialModel) {
        this.autoserialModel = autoserialModel;
    }
}
