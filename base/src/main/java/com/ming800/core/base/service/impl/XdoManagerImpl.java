package com.ming800.core.base.service.impl;

import com.ming800.core.base.util.ReflectUtil;
import com.ming800.core.base.util.SystemValueUtil;
import com.ming800.core.base.dao.XdoDao;
import com.ming800.core.base.util.XDoUtil;
import com.ming800.core.does.model.*;
import com.ming800.core.does.model.Page;
import com.ming800.core.does.service.DoManager;
import com.ming800.core.does.service.ModuleManager;
import com.ming800.core.does.service.impl.WebServiceHandlerManagerImpl;
import com.ming800.core.taglib.PageEntity;

import com.ming800.core.base.service.XdoManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import java.util.*;

/**
 * Created with IntelliJ IDEA.
 * User: ming
 * Date: 12-11-10
 * Time: 上午10:14
 * To change this template use File | Settings | File Templates.
 */
@Service
public class XdoManagerImpl implements XdoManager {

    @Autowired
    private XdoDao xdoDao;
    @Autowired
    private DoManager doManager;
    @Autowired
    private ModuleManager moduleManager;
    // @Autowired
    //  private DictionaryDataManager dictionaryDataManager;
/*    @Autowired
    private PermissionManager permissionManager;*/


    /**
     * 假删
     */
    @Override
    public String removeObject(Do tempDo, String id) throws Exception {

        String resultPage = tempDo.getResult();
        if (resultPage.contains("$")) {
            resultPage = XDoUtil.convertPageUrl(resultPage, xdoDao.getObject(tempDo.getXentity().getModel(), id));
        }

        xdoDao.removeObject(tempDo.getXentity().getModel(), id);

        //saveOrUpdateOperationLog(tempDo, "id:" + id, "假删");
        return resultPage;
    }


    /**
     * 真删
     */
    @Override
    public String deleteObject(Do tempDo, String id) throws Exception {

        String resultPage = tempDo.getResult();
        if (resultPage.contains("$")) {
            resultPage = XDoUtil.convertPageUrl(resultPage, xdoDao.getObject(tempDo.getXentity().getModel(), id));
        }

        xdoDao.deleteObject(tempDo.getXentity().getModel(), id);

//        saveOrUpdateOperationLog(tempDo, "id:" + id, "真删");

        return resultPage;
    }

    @Override
    public void deleteObject(String queryModel, String id) throws Exception {
        Do tempDo = doManager.getDoByQueryModel(queryModel);
        xdoDao.deleteObject(tempDo.getXentity().getModel(), id);
    }

    @Override
    public Object saveOrUpdateObject(Do tempDo, HttpServletRequest request) throws Exception {
        Object object;
        String type;

        String idValue = request.getParameter("id");
        if (idValue == null || idValue.equals("")) {
            type = "new";
            object = Class.forName(tempDo.getXentity().getModel()).newInstance();
        } else {
            type = "edit";
            object = xdoDao.getObject(tempDo.getXentity().getModel(), idValue);
        }

        object = XDoUtil.processSaveOrUpdateTempObject(tempDo, object, object.getClass(), request, type, xdoDao);

        try {
            xdoDao.saveOrUpdateObject(object.getClass().getName(), object);
        } catch (Exception e) {

//            e.printStackTrace();
        }

        return object;
    }

    /*分页列表*/
    @Override
    public PageInfo listPage(Do tempDo, DoQuery tempDoQuery, String tempConditions, PageEntity pageEntity) throws Exception {
        XQuery xQuery = new XQuery(tempDo, tempDoQuery, pageEntity, tempConditions);

        if (tempDoQuery.getQueryExecute() != null && !tempDoQuery.getQueryExecute().equals("")) {
            xQuery = XDoUtil.executeXQueryHandler(xQuery, tempDoQuery);
        }

        PageInfo pageInfo = xdoDao.getPageByConditions(pageEntity, xQuery.getHql(), xQuery.getQueryParamMap());
//        List objectList = pageInfo.getList();
//        try {
//            WebServiceHandlerManagerImpl.dealList(objectList, xQuery.getRemoteConfig());
//        } catch (Exception e) {
//            e.printStackTrace();
//        }

        return pageInfo;  //To change body of implemented methods use File | Settings | File Templates.
    }

    /*普通列表, 参数有tempDo*/
    @Override
    public Object list(Do tempDo, DoQuery tempDoQuery, String tempConditions) throws Exception {
        XQuery xQuery = new XQuery(tempDo, tempDoQuery, null, tempConditions);

        if (tempDoQuery.getQueryExecute() != null && !tempDoQuery.getQueryExecute().equals("")) {
            xQuery = XDoUtil.executeXQueryHandler(xQuery, tempDoQuery);
        }

        List objectList = xdoDao.getObjectList(xQuery.getHql(), xQuery.getQueryParamMap());
//        try {
//            WebServiceHandlerManagerImpl.dealList(objectList, xQuery.getRemoteConfig());
//        } catch (Exception e) {
//            e.printStackTrace();
//        }

        return objectList;  //To change body of implemented methods use File | Settings | File Templates.
    }

    /*统计收费总额, */
    @Override
    public String generateTotalMoney(Do tempDo, DoQuery tempDoQuery, String tempConditions, String countField) throws Exception {

        XQuery xQuery = new XQuery(tempDo, tempDoQuery, null, tempConditions);

        String queryStr = xQuery.getHql();
        queryStr = queryStr.substring(queryStr.indexOf("from"), queryStr.length());
        queryStr = "select sum(s." + countField + ") " + queryStr;

        Object totalMoney = xdoDao.getObjectList(queryStr, xQuery.getQueryParamMap()).get(0);
        if (totalMoney == null) {
            return "0";
        } else {
            return totalMoney.toString();
        }
    }

    /*普通列表， 参数为queryModel*/
    @Override
    public Object list(String queryModel, String tempConditions) throws Exception {

        Do tempDo = doManager.getDoByQueryModel(queryModel.split("_")[0]);
        DoQuery tempDoQuery = tempDo.getDoQueryByName(queryModel.split("_")[1]);
        XQuery xQuery = new XQuery(tempDo, tempDoQuery, null, tempConditions);

        List objectList = xdoDao.getObjectList(xQuery.getHql(), xQuery.getQueryParamMap());
//        try {
//            WebServiceHandlerManagerImpl.dealList(objectList, xQuery.getRemoteConfig());
//        } catch (Exception e) {
//            e.printStackTrace();
//        }

        return objectList;  //To change body of implemented methods use File | Settings | File Templates.
    }

    /*获取对象，  form  view页面*/
    @Override                 //view ==> fetchObject(), 取得一个对象
    public Object fetchObject(Do tempDo, String id, String conditions) throws Exception {

        Object object;
        if (id != null) {
            object = xdoDao.getObject(tempDo.getXentity().getModel(), id);
        } else {
            object = ReflectUtil.getNewInstance(tempDo.getXentity().getModel());
            if (tempDo.getPageList() != null && tempDo.getPageList().size() > 0) {
                Page tempPage = tempDo.getPageList().get(0);
                for (PageField pageField : tempPage.getFieldList()) {
                    String propertyValue = pageField.getValue();
                    Object paramObject = SystemValueUtil.getValue(propertyValue, "object");
                    if (pageField.getDataType().equals("int")) {
                        paramObject = Integer.parseInt(paramObject.toString());
                    } else if (pageField.getDataType().startsWith("boolean")) {
                        paramObject = Boolean.valueOf(paramObject.toString());
                    }
                    XDoUtil.generateFetchObjectSetValue(object, object.getClass(), pageField.getName(), paramObject);
                }
            }

            object = XDoUtil.fetchObjectByConditions(object, conditions, xdoDao);
            /*if (conditions != null && !conditions.equals("")) {
                String[] tempConditions = conditions.split(";");
                for (String str : tempConditions) {
                    String[] tempStr = str.split(":");
                    if (tempStr[0].contains(".")) {
                        tempStr[0] = tempStr[0].split("\\.")[0];
                    }
                    Field field = ReflectUtil.getDeclaredField(object, tempStr[0]);
                    field.setAccessible(true);

                    Object tempObject = null;
                    if (field.getType().getName().startsWith("com.ming800")) {
                        tempObject = xdoDao.getObject(field.getType().getName(), tempStr[1]);

                    } else if (field.getType().getName().equals("java.lang.Integer")) {
                        tempObject = Integer.parseInt(tempStr[1]);
                    } else if (field.getType().getName().equals("java.util.Date")) {
                        tempObject = DateUtil.parseDate(tempStr[1]);
                    } else {
                        tempObject = tempStr[1];
                    }

                    generateFetchObjectSetValue(object, object.getClass(), tempStr[0], tempObject);
                }
            }*/
        }
//        try {
//            WebServiceHandlerManagerImpl.dealObject(object);
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
        return object;  //To change body of implemented methods use File | Settings | File Templates.
    }

    /*批量更新*/
    @Override
    public int batchUpdate(Do tempDo, String ids) throws Exception {

        StringBuilder queryStrBuilder = new StringBuilder("update ").append(tempDo.getXentity().getModel());
        queryStrBuilder.append(" set");
        Page tempPage = tempDo.getPageList().get(0);
        for (PageField pageField : tempPage.getFieldList()) {
            String filed = pageField.getName();
            String value = pageField.getValue();
            queryStrBuilder.append(" ").append(filed).append(" = '").append(value).append("'").append(",");
        }
        queryStrBuilder.deleteCharAt(queryStrBuilder.length() - 1);

        queryStrBuilder.append(" where id in (:ids)");
        LinkedHashMap<String, Object> queryParamMap = new LinkedHashMap<>();
        queryParamMap.put("ids", ids.split(","));
        return xdoDao.execteBulk(queryStrBuilder.toString(), queryParamMap);
    }


}
