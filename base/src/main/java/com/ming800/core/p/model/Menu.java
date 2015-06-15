package com.ming800.core.p.model;

import java.util.HashMap;

/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 13-6-18
 * Time: 下午2:50
 * To change this template use File | Settings | File Templates.
 */
public class Menu {

    private String name;
    private HashMap<String, Jmenu> jmenuHashMap;


    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public HashMap<String, Jmenu> getJmenuHashMap() {
        return jmenuHashMap;
    }

    public void setJmenuHashMap(HashMap<String, Jmenu> jmenuHashMap) {
        this.jmenuHashMap = jmenuHashMap;
    }
}
