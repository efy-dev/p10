package com.ming800.core.p.service;

/**
 * Created by IntelliJ IDEA.
 * User: ming
 * Date: 12-8-6
 * Time: 上午11:02
 * To change this template use File | Settings | File Templates.
 */
public interface JmenuManager {
    /**
     * @param jmenuName
     * @param type      菜单类型
     * @return
     */
    String getJmenuJson(String jmenuName, Integer type);
}
