package com.ming800.core.base.dao;

import com.ming800.core.taglib.PageEntity;
import com.ming800.core.util.PageInfo;

import java.util.LinkedHashMap;
import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: ming
 * Date: 12-10-15
 * Time: 下午2:01
 * To change this template use File | Settings | File Templates.
 */
public interface XdoDao {

    void saveOrUpdateObject(Class modelType, Object object);

    void deleteObject(Class model, String id);

    int removeObject(Class model, String id);

    Object getObject(Class model, String id);

    List getObjectList(String queryHql, LinkedHashMap<String, Object> queryParamMap);

    List getObjectList(String queryHql, Object... params);

    List<Object> getObjectList(String hql, LinkedHashMap<String, Object> params, Integer limit, Integer offset);

    PageInfo getPageByConditions(PageEntity pageEntity, String queryHql, LinkedHashMap<String, Object> queryParamMap);

    int execteBulk(final String hql, final LinkedHashMap<String, Object> queryParamMap);

    Object getUniqueObjectByConditions(String queryHql, LinkedHashMap<String, Object> queryParamMap);


    void batchSaveOrUpdate(String type, Class model, List<Object> objectList);

    Object executeSql(String type, String queryStr, LinkedHashMap<String, Object> queryParamMap);


}
