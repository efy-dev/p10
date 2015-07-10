package com.ming800.core.p.model;

import com.fasterxml.jackson.annotation.JsonIgnore;

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
    private String url;
    private String state;
    private String access;
    private List<Jnode> children;
    private Jnode father;//节点的父节点
    private List<String> qmList; //菜单相关页面的qm请求列表

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

    public String getAccess() {
        return access;
    }

    public void setAccess(String access) {
        this.access = access;
    }

    public List<Jnode> getChildren() {
        return children;
    }

    public void setChildren(List<Jnode> children) {
        this.children = children;
    }


    public List<String> getQmList() {
        return qmList;
    }

    public void setQmList(List<String> qmList) {
        this.qmList = qmList;
    }

    @JsonIgnore
    public Jnode getFather() {
        return father;
    }

    @JsonIgnore
    public Jnode getRootFather() {
        if (father == null) {
            return this;
        } else
            return getRootFather(father);
    }

    private Jnode getRootFather(Jnode jnode) {
        if (jnode.father == null) {
            return jnode;
        } else {
            return getRootFather(jnode.father);
        }
    }

    public void setFather(Jnode father) {
        this.father = father;
    }

    //判断是否包含qm请求
    public boolean contain(String qm) {
        if (qmList != null && qmList.size() > 0 && qm != null) {
            boolean flag = false;
            for (String qmTemp : qmList) {
                if (qm.equals(qmTemp)) {
                    flag = true;
                }
            }
            return flag;
        } else {
            return false;
        }
    }
}
