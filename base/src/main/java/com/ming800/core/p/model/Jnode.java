package com.ming800.core.p.model;

import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: ming
 * Date: 12-8-6
 * Time: 上午10:03
 * To change this template use File | Settings | File Templates.
 */
public class Jnode {
    private String id;
    private String text_zh_CN;
    private String text_en_US;
    private String url;
    private String state;
    private String setting;
    private String access;
    private String branch;
    private List<Jnode> children;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getText_zh_CN() {
        return text_zh_CN;
    }

    public void setText_zh_CN(String text_zh_CN) {
        this.text_zh_CN = text_zh_CN;
    }

    public String getText_en_US() {
        return text_en_US;
    }

    public void setText_en_US(String text_en_US) {
        this.text_en_US = text_en_US;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public String getSetting() {
        return setting;
    }

    public void setSetting(String setting) {
        this.setting = setting;
    }

    public String getAccess() {
        return access;
    }

    public void setAccess(String access) {
        this.access = access;
    }

    public String getBranch() {
        return branch;
    }

    public void setBranch(String branch) {
        this.branch = branch;
    }

    public List<Jnode> getChildren() {
        return children;
    }

    public void setChildren(List<Jnode> children) {
        this.children = children;
    }
}
