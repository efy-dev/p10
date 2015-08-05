package com.ming800.core.p.dao;
import com.ming800.core.p.model.ObjectRecommended;

import java.util.List;


public interface RecommendedDao {

    /**
     * 分页
     * @param queryHql
     * @param firstResult
     * @param maxResult
     * @param params
     * @return
     */
    List getObjectListByLimit(String queryHql,Integer firstResult,Integer maxResult,Object... params);
    /***
     * 保存推荐对象
     * @param objectRecommended
     */
    void saveObjectRecommend(ObjectRecommended objectRecommended);

    /**
     * 更新排序字段
     * @param objectRecommended
     * @return
     */
    Integer  updateSort(ObjectRecommended objectRecommended);

    /**
     * 删除推荐对象
     * @param objectRecommended
     */
    void  deleteObjectRecommend(ObjectRecommended objectRecommended);


}
