package com.ming800.core.p.service;

import com.ming800.core.p.model.ObjectRecommended;

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
    List getRecommendedList(String group) throws Exception;

    /**
     * 保存推荐对象
     * @param objectRecommended
     */
    void saveObjectRecommend(ObjectRecommended objectRecommended);


    /**
     * 更新排序
     * @param objectRecommended
     * @return
     */
    Integer updateSort(ObjectRecommended objectRecommended);

    /**
     * 删除推荐对象
     * @param objectRecommended
     */
    void  deleteObjectRecommend(ObjectRecommended objectRecommended);

    /**
     * 根据推荐对象id删除删除推荐对象
     * 在推荐状态下直接删除推荐对象时调用
     * @param recommendId
     */
    void deleteObjectRecommendByRecommendId(String recommendId);




}
