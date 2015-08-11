package com.ming800.core.p.service;

import com.ming800.core.p.model.CommonBanner;
import com.ming800.core.p.model.CommonDocument;
import com.ming800.core.p.model.CommonRecommended;
import com.ming800.core.p.model.CommonTag;

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
     CommonRecommended getRecommended(String group) throws Exception;

    /**
     * 字典
     * @param group
     * @return
     * @throws Exception
     */
    CommonTag getTag(String group) throws  Exception;

    /**
     * 轮播图
     * @param group
     * @return
     * @throws Exception
     */
    CommonBanner getBanner(String group) throws  Exception;

    /**
     * 文档
     * @param group
     * @return
     * @throws Exception
     */
    CommonDocument getDocument(String group) throws  Exception;

}
