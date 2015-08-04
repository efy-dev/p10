package com.ming800.core.p.service;

import com.ming800.core.p.model.CommonRecommended;

/**
 * Created by IntelliJ IDEA.
 * User: ming
 * Date: 12-8-6
 * Time: 上午11:02
 * To change this template use File | Settings | File Templates.
 */
public interface CommonManager {
    /**
     * @param jmenuName
     * @param
     * @return
     */
    //String getJmenuJson(String jmenuName, Integer type);

    /**
     * 推荐
     * @param group
     * @return
     * @throws Exception
     */
    public CommonRecommended getRecommended(String group) throws Exception;

}
