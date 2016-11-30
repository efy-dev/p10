package com.ming800.core.base.service.impl;

import com.ming800.core.base.util.XDoUtil;
import com.ming800.core.does.model.*;
import com.ming800.core.does.service.DoManager;
import com.ming800.core.does.service.impl.ModuleManagerImpl;
import com.ming800.core.base.dao.XdoDao;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.service.ModuleManager;
import com.ming800.core.does.service.impl.WebServiceHandlerManagerImpl;
import com.ming800.core.taglib.PageEntity;
import com.ming800.core.does.model.PageInfo;
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
public class BaseManagerImpl implements BaseManager {

    @Autowired
    private XdoDao xdoDao;

    @Autowired
    private DoManager doManager;


    @Override
    public Object getObject(String model, String id) {
        Object object = xdoDao.getObject(model, id);
//        try {
//            WebServiceHandlerManagerImpl.dealObject(object);
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
        return object;
    }

    /**
     * 保存
     */
    @Override
    public void saveOrUpdate(String model, Object object) {
        xdoDao.saveOrUpdateObject(model, object);
    }

    /***
     * 临时添加测试使用
     *
     * @param object
     */
    @Override
    public void saveOrUpdateObject(Object object) {
        xdoDao.saveOrUpdateObject(object);
    }

    /**
     * 保存
     */
    @Override
    public void saveOrUpdate(String doQueryName, HttpServletRequest request) throws Exception {
        Do tempDo = null;
        Object object;
        String type;
        String idValue = request.getParameter("id");
        try {
            tempDo = doManager.getDoByQueryModel(doQueryName.split("_")[0]);
        } catch (Exception e) {
            e.printStackTrace();
        }
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

    }

    /**
     * 保存
     */
    @Override
    public Object saveOrUpdate(XSaveOrUpdate xSaveOrUpdate) throws Exception {
        Object object;
        String type;
        Object idValue = xSaveOrUpdate.getParamMap().get("id");
        if (idValue == null || idValue.equals("")) {
            type = "new";
            object = Class.forName(xSaveOrUpdate.getTempDo().getXentity().getModel()).newInstance();
        } else {
            type = "edit";
            object = xdoDao.getObject(xSaveOrUpdate.getTempDo().getXentity().getModel(), idValue.toString());
        }

        object = XDoUtil.processSaveOrUpdateTempObject(xSaveOrUpdate.getTempDo(), object, object.getClass(), xSaveOrUpdate.getParamMap(), type, xdoDao);

        try {
            xdoDao.saveOrUpdateObject(object.getClass().getName(), object);
        } catch (Exception e) {

//            e.printStackTrace();
        }

        return object;

    }


    @Override
    public void delete(String model, String id) {
        xdoDao.deleteObject(model, id);
    }

    @Override
    public void remove(String model, String id) {
        xdoDao.removeObject(model, id);
    }

    /**
     * 不需要配置文件的查询，需要在controller中写查询语句和查询参数
     */
    @Override
    public List listObject(String queryHql, LinkedHashMap<String, Object> queryParamMap) {
//        List objectList = xdoDao.getObjectList(queryHql, queryParamMap);
//        try {
//            WebServiceHandlerManagerImpl.dealList(objectList);
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
        return xdoDao.getObjectList(queryHql, queryParamMap);
    }

    @Override
    public List listObject(String queryHql, Object... params) {
        List objectList = xdoDao.getObjectList(queryHql, params);
//        try {
//            WebServiceHandlerManagerImpl.dealList(objectList);
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
        return objectList;
    }

    /*
    这里传入doQueryName的目的是直接得到DoQuery对象，该对象中包含了某个查询的所有信息，查询条件查询参数的种类和参数类型
     */
    @Override
    public List listObject(XQuery xQuery) {
        List objectList = xdoDao.getObjectList(xQuery.getHql(), xQuery.getQueryParamMap());
//        try {
//            WebServiceHandlerManagerImpl.dealList(objectList, xQuery.getRemoteConfig());
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
        return objectList;
    }

    @Override
    public PageInfo listPageInfo(XQuery xQuery) {
        PageInfo pageInfo = xdoDao.getPageByConditions(xQuery.getPageEntity(), xQuery.getHql(), xQuery.getQueryParamMap());
//        List objectList = pageInfo.getList();
//        try {
//            WebServiceHandlerManagerImpl.dealList(objectList, xQuery.getRemoteConfig());
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
        return pageInfo;  //To change body of implemented methods use File | Settings | File Templates.
    }


    @Override
    public PageInfo listPageInfo(String queryHql, PageEntity pageEntity, LinkedHashMap<String, Object> queryParamMap) {

        PageInfo pageInfo = xdoDao.getPageByConditions(pageEntity, queryHql, queryParamMap);
//        List objectList = pageInfo.getList();
//        try {
//            WebServiceHandlerManagerImpl.dealList(objectList);
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
        return pageInfo;  //To change body of implemented methods use File | Settings | File Templates.
    }

    @Override
    public Object getUniqueObjectByConditions(String queryHql, LinkedHashMap<String, Object> queryParamMap) {

        Object object = xdoDao.getUniqueObjectByConditions(queryHql, queryParamMap);
//        try {
//            WebServiceHandlerManagerImpl.dealObject(object);
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
        return object;
    }


    /**
     * 批量假删  将theStatus状态改为0
     */
    public int batchRemove(String model, String[] idArray) {
        if (idArray == null || idArray.length == 0) {
            return 0;
        } else {
            StringBuilder queryStrBuilder = new StringBuilder("update " + model + " set status = 0 where id in (:ids)");
            LinkedHashMap<String, Object> queryParamMap = new LinkedHashMap<>();
            queryParamMap.put("ids", idArray);
            return xdoDao.execteBulk(queryStrBuilder.toString(), queryParamMap);
        }

    }

    /**
     * 批量真删
     */
    public int batchDelete(String model, String[] idArray) {
        if (idArray == null || idArray.length == 0) {
            return 0;
        } else {
            StringBuilder queryStrBuilder = new StringBuilder("delete from " + model + " where id in (:ids)");
            LinkedHashMap<String, Object> queryParamMap = new LinkedHashMap<>();
            queryParamMap.put("ids", idArray);
            return xdoDao.execteBulk(queryStrBuilder.toString(), queryParamMap);
        }
    }


    @Override
    public void batchSaveOrUpdate(String type, String modelType, List<Object> objectList) {

        xdoDao.batchSaveOrUpdate(type, modelType, objectList);

        //To change body of implemented methods use File | Settings | File Templates.
    }

    @Override
    public Object executeSql(String type, String queryStr, LinkedHashMap<String, Object> queryParamMap) {
        return xdoDao.executeSql(type, queryStr, queryParamMap);  //To change body of implemented methods use File | Settings | File Templates.
    }

/*    @Override
    public Boolean executeBranchData(String name) {

        String tNameQueryStr = " show tables ";
        List<String> tableNameList = (List<String>) xdoDao.executeSql("list", tNameQueryStr, null);

        int i = 0;
        for (Object tableName : tableNameList) {
            String tempSqlStr = "delete from " + tableName.toString() + " where id not like '" + name + "%'";
            xdoDao.executeSql("delete", tempSqlStr, null);
            i++;
        }
        System.err.print(i);

        return true;  //To change body of implemented methods use File | Settings | File Templates.
    }*/


    @Override
    public Map<Field, List<StatusTypeItem>> listStatusType(String entityName, List<String> fieldNameList) {
        ModuleManager mm = new ModuleManagerImpl();
        //Map<String, Module> mmap = mm.fetchModuleMap();
        Map<String, Xentity> xmap = mm.fetchXentityMap();
        Map<Field, List<StatusTypeItem>> categaryList = new LinkedHashMap<Field, List<StatusTypeItem>>();
        Xentity xentity = xmap.get(entityName);
        for (String fieldName : fieldNameList) {
            StatusTypeField statusTypeField = (StatusTypeField) xentity.getFieldMap().get(fieldName);
            List<StatusTypeItem> statusTypeItemList = statusTypeField.getStatusTypeList().get(0).getStatusTypeItemList();
            categaryList.put(xentity.getFieldMap().get(fieldName), statusTypeItemList);
        }
        return categaryList;
    }

    @Override
    public Map<Field, List<StatusTypeItem>> listStatusType(String entityName, String[] fieldNameList) {
        return this.listStatusType(entityName, Arrays.asList(fieldNameList));
    }

    @Override
    public List<StatusTypeItem> listStatusType(String entityName, String fieldName) {
        List<StatusTypeItem> statusTypeItemList = null;
        for (Field field : this.listStatusType(entityName, Arrays.asList(fieldName)).keySet()) {
            statusTypeItemList = this.listStatusType(entityName, Arrays.asList(fieldName)).get(field);
        }
        this.listStatusType(entityName, Arrays.asList(fieldName));
        return statusTypeItemList;
    }


}
