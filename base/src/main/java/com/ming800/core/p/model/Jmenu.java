package com.ming800.core.p.model;

import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: ming
 * Date: 12-8-6
 * Time: 上午9:58
 * To change this template use File | Settings | File Templates.
 */
public class Jmenu {
    private String id;
    private String base;
    private List<Jnode> children;

    public String getBase() {
        return base;
    }

    public void setBase(String base) {
        this.base = base;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public List<Jnode> getChildren() {
        return children;
    }

    public void setChildren(List<Jnode> children) {
        this.children = children;
    }


}
