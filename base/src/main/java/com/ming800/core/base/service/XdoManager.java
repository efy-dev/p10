package com.ming800.core.base.service;

import com.ming800.core.does.model.*;
import com.ming800.core.taglib.PageEntity;
import com.ming800.core.does.model.PageInfo;

import javax.servlet.http.HttpServletRequest;

/**
 * Created with IntelliJ IDEA.
 * User: ming
 * Date: 12-11-10
 * Time: 上午11:27
 * To change this template use File | Settings | File Templates.
 */
public interface XdoManager {


    String generateTotalMoney(Do tempDo, DoQuery tempDoQuery, String tempConditions, String countField) throws Exception;

    Object list(Do tempDo, DoQuery tempDoQuery, String tempConditions) throws Exception;

    Object list(String queryModel, String tempConditions) throws Exception;

    PageInfo listPage(Do tempDo, DoQuery tempDoQuery, String tempConditions, PageEntity pageEntity) throws Exception;

    Object fetchObject(Do tempDo, String id, String conditions) throws Exception;

    String removeObject(Do tempDo, String id) throws Exception;

    String deleteObject(Do tempDo, String id) throws Exception;

    void deleteObject(String queryModel, String id) throws Exception;

    Object saveOrUpdateObject(Do tempDo, HttpServletRequest request) throws Exception;

    /**
     * 批量更新
     *
     * @param tempDo basic_do.xml中配置的name
     * @param ids    要更新的数据的主键
     * @return 更新的条数
     */
    int batchUpdate(Do tempDo, String ids) throws Exception;
}
