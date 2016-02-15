package com.ming800.core.base.service;

import com.ming800.core.does.model.Field;
import com.ming800.core.does.model.StatusTypeItem;
import com.ming800.core.does.model.XQuery;
import com.ming800.core.does.model.XSaveOrUpdate;
import com.ming800.core.taglib.PageEntity;
import com.ming800.core.does.model.PageInfo;

import javax.servlet.http.HttpServletRequest;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

/**
 * Created with IntelliJ IDEA.
 * User: ming
 * Date: 12-11-10
 * Time: 上午11:27
 * To change this template use File | Settings | File Templates.
 */
public interface BaseManager {


    Object getObject(String model, String id);

    void saveOrUpdate(String model, Object object);

    @Deprecated
    void saveOrUpdate(String doQueryName, HttpServletRequest request) throws Exception;

    Object saveOrUpdate(XSaveOrUpdate xSaveOrUpdate) throws Exception;

    void delete(String model, String id);

    void remove(String model, String id);

    List listObject(String queryHql, LinkedHashMap<String, Object> queryParamMap);

    @Deprecated
    List listObject(String queryHql, Object... params);


    List listObject(XQuery xQuery);

    @Deprecated
    PageInfo listPageInfo(String queryHql, PageEntity pageEntity, LinkedHashMap<String, Object> queryParamMap);

    PageInfo listPageInfo(XQuery xQuery);

    Object getUniqueObjectByConditions(String queryHql, LinkedHashMap<String, Object> queryParamMap);

    int batchRemove(String model, String[] idArray);

    int batchDelete(String model, String[] idArray);

    void batchSaveOrUpdate(String type, String modelType, List<Object> objectList);

    Object executeSql(String type, String queryStr, LinkedHashMap<String, Object> queryParamMap);

    Map<Field, List<StatusTypeItem>> listStatusType(String entityName, List<String> fieldNameList);

    Map<Field, List<StatusTypeItem>> listStatusType(String entityName, String[] fieldNameList);

    List<StatusTypeItem> listStatusType(String entityName, String fieldName);
    /***
     * 临时添加测试使用
     * @param object
     */
    @Deprecated
    void saveOrUpdateObject(Object object) ;
}
