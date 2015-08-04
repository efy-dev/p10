package com.ming800.core.p.service;

import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: ming
 * Date: 12-8-6
 * Time: 上午11:02
 * To change this template use File | Settings | File Templates.
 */
public interface ObjectRecommendedManager {
    /**
     * @param jmenuName
     * @param type      菜单类型
     * @return
     */
    //String getJmenuJson(String jmenuName, Integer type);

    /**
     * 获取推荐
     * @param group
     * @return
     * @throws Exception
     */
    public List getRecommendedList(String group) throws Exception;
}
