package com.ming800.core.base.service.impl;

import com.ming800.core.base.util.ReflectUtil;
import com.ming800.core.base.util.SystemValueUtil;
import com.ming800.core.base.dao.XdoDao;
import com.ming800.core.base.util.XDoUtil;
import com.ming800.core.does.model.*;
import com.ming800.core.does.model.Page;
import com.ming800.core.does.service.DoManager;
import com.ming800.core.does.service.QueryHandler;
import com.ming800.core.p.model.DictionaryData;
import com.ming800.core.base.model.MethodCache;
import com.ming800.core.p.model.OperationLog;
import com.ming800.core.p.service.DictionaryDataManager;
import com.ming800.core.does.service.ModuleManager;
import com.ming800.core.taglib.PageEntity;
import com.ming800.core.util.*;

import com.ming800.core.base.service.XdoManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import java.lang.reflect.Field;
import java.math.BigDecimal;
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
    @Autowired
    private DictionaryDataManager dictionaryDataManager;
/*    @Autowired
    private PermissionManager permissionManager;*/



    /**
     * 假删
     */
    @Override
    public String removeObject(Do tempDo, String id) throws Exception {

        String resultPage = tempDo.getResult();
        if (resultPage.contains("$")) {
            resultPage = convertPageUrl(resultPage, xdoDao.getObject(tempDo.getXentity().getModel(), id));
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
            resultPage = convertPageUrl(resultPage, xdoDao.getObject(tempDo.getXentity().getModel(), id));
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

        object = XDoUtil.processSaveOrUpdateTempObject(tempDo, object, object.getClass(), request, type,xdoDao);

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
        XQuery xQuery = XDoUtil.generateQueryString(tempDo.getXentity().getModel(), tempDoQuery, tempConditions);

        if (tempDoQuery.getQueryExecute() != null && !tempDoQuery.getQueryExecute().equals("")) {
            xQuery = executeXQueryHandler(xQuery, tempDoQuery);
        }

        return xdoDao.getPageByConditions(pageEntity, xQuery.getHql(), xQuery.getQueryParamMap());  //To change body of implemented methods use File | Settings | File Templates.
    }

    /*普通列表, 参数有tempDo*/
    @Override
    public Object list(Do tempDo, DoQuery tempDoQuery, String tempConditions) throws Exception {
        XQuery xQuery = XDoUtil.generateQueryString(tempDo.getXentity().getModel(), tempDoQuery, tempConditions);

        if (tempDoQuery.getQueryExecute() != null && !tempDoQuery.getQueryExecute().equals("")) {
            xQuery = executeXQueryHandler(xQuery, tempDoQuery);
        }

        return xdoDao.getObjectList(xQuery.getHql(), xQuery.getQueryParamMap());  //To change body of implemented methods use File | Settings | File Templates.
    }

    /*统计收费总额, */
    @Override
    public String generateTotalMoney(Do tempDo, DoQuery tempDoQuery, String tempConditions, String countField) {

        XQuery xQuery = XDoUtil.generateQueryString(tempDo.getXentity().getModel(), tempDoQuery, tempConditions);

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
        XQuery xQuery = XDoUtil.generateQueryString(tempDo.getXentity().getModel(), tempDoQuery, tempConditions);

        return xdoDao.getObjectList(xQuery.getHql(), xQuery.getQueryParamMap());  //To change body of implemented methods use File | Settings | File Templates.
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
                    generateFetchObjectSetValue(object, object.getClass(), pageField.getName(), paramObject);
                }
            }

            object = fetchObjectByConditions(object, conditions);
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


//    @Override
//    public Object processSaveOrUpdateTempObject(Do tempDo, Object object, Class objectClass, HttpServletRequest request, String type) throws Exception {
//
//        object = processSaveOrUpdateObject(tempDo, object, objectClass, request, type);
//
//        /*配置文件*/
//        if (tempDo.getPageList() != null && tempDo.getPageList().size() > 0) {
//            Page tempPage = tempDo.getPageList().get(0);
//            for (PageField pageField : tempPage.getFieldList()) {
//                String propertyValue = pageField.getValue();
//                Object paramObject = SystemValueUtil.getValue(propertyValue, "object");
//                if (pageField.getDataType().equals("int")) {
//                    paramObject = Integer.parseInt(paramObject.toString());
//                } else if (pageField.getDataType().equals("boolean")) {
//                    paramObject = Boolean.valueOf(paramObject.toString());
//                } else if (pageField.getDataType().equals("float")) {
//                    paramObject = Float.valueOf(paramObject.toString());
//                }
//
//                if (ReflectUtil.invokeGetterMethod(object, pageField.getName()) == null) {
//                    ReflectUtil.invokeSetterMethod(object, pageField.getName(), paramObject);
//                }
//            }
//        }
//
//        return object;  //To change body of implemented methods use File | Settings | File Templates.
//    }
//
//    /**
//     * 创建或者更新对象
//     */
//    public Object processSaveOrUpdateObject(Do tempDo, Object object, Class objectClass, HttpServletRequest request, String type) throws Exception {
//        Field[] fields = objectClass.getDeclaredFields();
//        String content = "";
//        for (Field field : fields) {
//            field.setAccessible(true);
//
//            if (field.getName().equals("id")) {
//                continue;
//            }
//            Object objectValue = null;
//
//            if (field.getType().getName().startsWith("com.ming800") || field.getType().getName().startsWith("com.yuepaila")) { //处理实体属性
//                String fieldValue = request.getParameter(field.getName() + ".id");
//                if (fieldValue == null) {//异步请求时，使用property_id来发送关联实体的id
//                    fieldValue = request.getParameter(field.getName() + "_id");
//                }
//                Class simpleName = Class.forName(field.getType().getName());
////                Object objectIdValue = null;
//                Object objectNameValue = null;
//                if (fieldValue != null && !fieldValue.equals("")) {
//                    objectValue = xdoDao.getObject(Class.forName(field.getType().getName()).getName(), fieldValue);
//                    objectNameValue = fetchIdValueByClassType(simpleName, objectValue);//获取对象的指定字段值
//                }
//
//                if (type.equals("edit")) {
//
//                    Object tempObjectValue = SystemValueUtil.generateTempObjectValue(object, field.getName().split("\\."));
//                    Object tempObjectIdValue = SystemValueUtil.generateTempObjectValue(object, (field.getName() + ".id").split("\\."));
//                    Object tempObjectNameValue = null;
//                    if (tempObjectValue != null) {
//                        tempObjectNameValue = fetchIdValueByClassType(simpleName, tempObjectValue);
//                    }
//
//                    if (fieldValue != null && (tempObjectIdValue == null || !tempObjectIdValue.toString().equals(fieldValue))) {
//                        if (tempDo != null) {
//                            content += field.getName() + ".id:" + tempObjectNameValue + " => " + objectNameValue==null?"":objectNameValue + "<br/>";
//                        }
//                    } else {
//                        continue;
//                    }
//                }
//            } else {                //
//                String fieldValue = request.getParameter(field.getName());
//                if (fieldValue != null) {
//
//                    if (field.getType().equals(String.class)) {
//                        objectValue = SystemValueUtil.transformSpecialSymbol(fieldValue);
//                    } else if (field.getType().equals(Integer.class) && !fieldValue.equals("")) {
//                        objectValue = Integer.parseInt(fieldValue);
//                    } else if (field.getType().equals(Date.class) && !fieldValue.equals("")) {
//                        objectValue = DateUtil.parseAllDate(fieldValue);
//                    } else if (field.getType().equals(Float.class) && !fieldValue.equals("")) {
//                        objectValue = Float.parseFloat(fieldValue);
//                    } else if (field.getType().equals(BigDecimal.class) && !fieldValue.equals("")) {
//                        objectValue = new BigDecimal(fieldValue);
//                    } else if (field.getType().equals(Byte.class) && !fieldValue.equals("")) {
//                        objectValue = Byte.parseByte(fieldValue);
//                    } else if (field.getType().equals(Boolean.class) && !fieldValue.equals("")) {
//                        objectValue = Boolean.parseBoolean(fieldValue);
//                    }
//                  /*   else {
//                        objectValue = SystemValueUtil.transformSpecialSymbol(fieldValue);
////                        objectValue = fieldValue;
//                    }*/
//                }
//
//                /*修改的时候判断属性值是否和上次相等，相等的话，不进行修改，进入下一次循环*/
//                /*暂时不考虑   子表的情况*/
//                if (type.equals("edit")) {
//                    if (!SystemValueUtil.isEqual(field.getName(), objectValue, object)) {
//                        /*continue;
//                    } else {*/
//                        if (tempDo != null) {
//                            content += field.getName() + ":" + ReflectUtil.invokeGetterMethod(object, field.getName()) + " => " + fieldValue + "<br/>";
//                        }
//                    } else {
//                        continue;
//                    }
//                }
//            }
//
////            if (type.equals("new") && objectValue == null) {              //fieldValue注解  赋默认值
////                boolean hasAnnotation = field.isAnnotationPresent(FieldValue.class);
////                if (hasAnnotation) {
////                    FieldValue annotation = field.getAnnotation(FieldValue.class);
////                    String annotationValue = annotation.value();
////
////                    /*只有当新建的时候 转换默认的值   MY_USER...*/
////                    if (!annotationValue.equals("DICTIONARY")) {
////                        objectValue = SystemValueUtil.getValue(annotationValue, "object");
////                    }
////                }
////            }
//
//            field.set(object, objectValue);
//        }
//
//        /*如果tempObject1有父类，读取*/
//        if (!objectClass.getSuperclass().getName().equals("java.lang.Object")) {
//            object = processSaveOrUpdateObject(tempDo, object, objectClass.getSuperclass(), request, type);
//        }
//
//      /*  if (!content.equals("")) {
//            saveOrUpdateOperationLog(tempDo, content.substring(0, content.length() - 1), "修改");
//        }
//*/
//        return object;
//    }
//
//
//    /**
//     * 处理  操作日志   无法识别数据字典类型的数据
//     */
//    public Object fetchIdValueByClassType(Class simpleName, Object object) throws Exception {
//
//        Object objectValue = null;
//
//        if (ReflectUtil.getDeclaredField(object, "name") != null) {
//            objectValue = SystemValueUtil.generateTempObjectValue(object, ("name").split("\\."));
//        } else if (ReflectUtil.getDeclaredField(object, "data") != null) {
//            objectValue = SystemValueUtil.generateTempObjectValue(object, ("data").split("\\."));
//        } else {
//            objectValue = SystemValueUtil.generateTempObjectValue(object, ("id").split("\\."));
//        }
//
//        return objectValue;
//    }

//    /**
//     * 处理配置文件中   同一个属性对应  开始时间，结束时间的问题
//     */
//    private String getPropertyName(String tempPropertyName) {
//        String propertyName = tempPropertyName;
//
//        if (propertyName.endsWith("2")) {
//            propertyName = propertyName.substring(0, propertyName.length() - 1);
//        }
//
//        return propertyName;
//    }
//
//    /**
//     * 处理配置文件中   操作符号的问题   大于，小雨。。。
//     */
//    private String convertOperator(String tempOperator) {
//        String operator = tempOperator;
//
//        if (tempOperator.equals("eq")) {
//            operator = "=";
//        } else if (tempOperator.equals("ne")) {
//            operator = "!=";
//        } else if (tempOperator.equals("ge")) {
//            operator = ">=";
//        } else if (tempOperator.equals("le")) {
//            operator = "<=";
//        } else if (tempOperator.equals("gt")) {
//            operator = ">";
//        } else if (tempOperator.equals("lt")) {
//            operator = "<";
//        } else if (tempOperator.equals("likes")) {
//            operator = "like";
//        }
//
//        return operator;
//    }
//
//    /**
//     * 取值
//     */
//    public Object convertPropertyValue(QueryCondition condition, String tempConditions, String tempOperator) {
//
//        Object value = "";
//        String propertyValue = condition.getValue();
//
//        if (tempConditions != null && !tempConditions.equals("")) {
//            for (String str : tempConditions.split(";")) {
//                String[] tempStr = str.split(":");
//                if (condition.getName().equals(tempStr[0].trim())) {
//                    if (tempStr.length < 2) {
//                        return null;
//                    } else {
//                        propertyValue = tempStr[1].trim();
//                        if (propertyValue.split(",")[0].trim().equals("")) {//弹窗临时处理
//                            return null;
//                        }
//                        break;
//                    }
//                }
//            }
//        }
//
//        String tempValue = SystemValueUtil.getValue(propertyValue, "id").toString();
//
//        if (tempValue.equals("")) {
//            return null;
//        }
//        if (tempOperator.equals("in") || tempOperator.equals("not in")) {
//            List<Object> list = new ArrayList<>();
//            if (tempValue.contains("_")) {
//                if (tempValue.equals("_")) {
//                    return null;
//                }
//                tempValue = tempValue.split("_")[0].trim();
//            }
//            if (!tempValue.equals("")) {
//                for (String tempStr : tempValue.split(",")) {
//                    if (condition.getDataType() != null && condition.getDataType().equals("int")) {
//                        list.add(Integer.parseInt(tempStr));
//                    } else {
//                        list.add(tempStr);
//                    }
//                }
//                value = list;
//            }
//
//        } else if (condition.getInputType().equals("dialog_do") || condition.getInputType().equals("dialog_pop")) {
//            if (tempValue.equals("_")) {
//                value = null;
//            } else {
//                value = tempValue.split("_")[0].trim();
//            }
//
//        } else if (condition.getDataType() != null && condition.getDataType().equals("float")) {
//            value = Float.parseFloat(tempValue);
//        } else if (condition.getDataType() != null && condition.getDataType().equals("int")) {
//            value = Integer.parseInt(tempValue);
//        } else if (condition.getDataType() != null && condition.getDataType().equals("date")) {
//            tempValue = SystemValueUtil.getValue(propertyValue, "name").toString();
//            value = DateUtil.parseDate(tempValue);
//        } else if (condition.getDataType() != null && condition.getDataType().equals("datetime")) {
//            tempValue = SystemValueUtil.getValue(propertyValue, "name").toString();
//            if (condition.getOperation().equals("ge")) {
//                value = DateUtil.parseDateTime(tempValue + " 00:00:00");
//            } else {
//                value = DateUtil.parseDateTime(tempValue + " 23:59:59");
//            }
//        } else if (condition.getDataType() != null && condition.getDataType().equals("boolean")) {
//            value = Boolean.valueOf(tempValue);
//        } else if (condition.getDataType() != null && condition.getDataType().equals("bigDecimal")) {
//            value = new BigDecimal(tempValue);
//        } else {
//            value = tempValue;
//        }
//
//        return value;
//    }
//
//    /**
//     * 获取查询语句  和   查询参数
//     */
//    private XQuery generateQueryString(String queryModel, DoQuery doQuery, String tempConditions) {
//        StringBuilder sb = new StringBuilder(100);
//
//        /*拼写 配置文件中的conditon*/
//        XQuery tempXQuery = fetchXQueryByConditions(doQuery.getConditionList(), doQuery, tempConditions);
//        sb.append(tempXQuery.getStringBuilder());
//
//        /*生成排序  order by 串*/
//        sb.append(fetchOrderStr(doQuery, tempConditions));
//
//        StringBuilder queryStringBuilder = new StringBuilder(150);
//        /*查询对象 select from */
//        queryStringBuilder.append(fetchQueryHead(queryModel, doQuery));
//        /*转换  第一个and  为 where*/
//        queryStringBuilder.append(sb.toString().replaceFirst("and", "where"));
//
//        XQuery xQuery = new XQuery();
//        xQuery.setStringBuilder(queryStringBuilder);
//        xQuery.setQueryParamMap(tempXQuery.getQueryParamMap());
//        return xQuery;
//    }
//
//    /*拼写  配置文件中的 condition*/
//    private XQuery fetchXQueryByConditions(List<QueryCondition> queryConditionList, DoQuery doQuery, String tempConditions) {
//
//        /*andor 在这里获取，以防后面用到*/
//        String queryExpress = "";
//        String tempQueryExpress = doQuery.getQueryExpress();
//        if (tempQueryExpress != null && !tempQueryExpress.equals("")) {
//            queryExpress = doQuery.getQueryExpress();
//        }
//
//        StringBuilder queryStr = new StringBuilder(150);
//        LinkedHashMap<String, Object> queryParamMap = new LinkedHashMap<>();
//
//        String bigBranch = "";  //大数据
//
//
//
//        for (QueryCondition queryCondition : queryConditionList) {
//            String propertyName = queryCondition.getName();
//            String tempOperator = queryCondition.getOperation();
//            String operator = "";
//            if ((queryCondition.getKey().equals("teachArea") || queryCondition.getKey().equals("singleTeachArea")) && bigBranch != null && bigBranch.equals("true")) {
//                tempOperator = "likes";
//                operator = "like";
//            } else {
//                operator = convertOperator(tempOperator);
//            }
//            Object value = convertPropertyValue(queryCondition, tempConditions, operator);
//
//            StringBuilder tempQueryStr = new StringBuilder(20);
//            if (tempQueryExpress == null || tempQueryExpress.equals("")) {
//                tempQueryStr.append(" and ");
//            }
//            if (value != null && !value.equals("") && !value.toString().trim().equals("") && !value.toString().trim().equals("headquarters")) {
//
//                if (tempOperator.equals("likes")) {
//                    value = value.toString() + "%";
//                } else if (tempOperator.equals("like")) {
//                    value = "%" + value.toString() + "%";
//                }
//
//                if (value.equals("null")) {
//                    value = null;
//                }
//                String tempPropertyName = propertyName;
//                if (propertyName.contains(".")) {
//                    tempPropertyName = propertyName.replace(".", "_");
//                }
//
//                if (!propertyName.startsWith("t.")) {
//                    tempQueryStr.append("s.");
//                }
//
//                tempQueryStr.append(getPropertyName(propertyName));
//                if (operator.equals("in")) {
//                    tempQueryStr.append(" in (:")
//                            .append(tempPropertyName)
//                            .append(")");
//                } else {
//                    tempQueryStr.append(" ")
//                            .append(operator)
//                            .append(" :")
//                            .append(tempPropertyName)
//                            .append("");
//
//                }
//                queryParamMap.put(tempPropertyName, value);
//
//
//            } else {
//                tempQueryStr.append("1=1");
//            }
//
//            if (tempQueryExpress != null && !tempQueryExpress.equals("")) {
//                queryExpress = queryExpress.replaceFirst(propertyName, tempQueryStr.toString());
//            } else {
//                queryStr.append(tempQueryStr.toString());
//            }
//        }
//
//        StringBuilder sb = new StringBuilder();
//        if (tempQueryExpress != null && !tempQueryExpress.equals("")) {
//            sb.append(queryExpress);
//        } else {
//            sb.append(queryStr.toString());
//        }
//
//        XQuery xQuery = new XQuery();
//        xQuery.setStringBuilder(sb);
//        xQuery.setQueryParamMap(queryParamMap);
//
//        return xQuery;
//    }
//
//    /*拼写  orderby 语句*/
//    private String fetchOrderStr(DoQuery doQuery, String tempConditions) {
//
//        /*页面 传递排序 参数*/
//        XQuery orderXQuery = fetchQueryOrder(tempConditions);
//
//        /*拼写  order by*/
//        String orders = doQuery.getOrderBy();
//        StringBuilder orderConditions = new StringBuilder();
//        if (orderXQuery != null && orderXQuery.getFlag()) {
//            orderConditions.append(" order by ").append(orderXQuery.getStringBuilder().toString());
//        } else if (orders != null && !orders.equals("")) {
//            orderConditions.append(" order by ");
//            for (String str : orders.split(";")) {
//                String[] strTemp = str.split(":");
//                orderConditions.append(" s.").append(strTemp[0]).append(" ").append(strTemp[1]).append(",");
//            }
//            orderConditions.deleteCharAt(orderConditions.length() - 1);
//        }
//
//        return orderConditions.toString();
//    }
//
//    /*页面  点击排序   效果*/
//    private XQuery fetchQueryOrder(String conditions) {
//        Boolean flag = false;
//        StringBuilder sb = new StringBuilder();
//
//        if (conditions != null && !conditions.equals("")) {
//            for (String condition : conditions.split(";")) {
//                String[] conditionArray = condition.split(":");
//                if (conditionArray[0].equals("asc") || conditionArray[0].equals("desc")) {
//                    flag = true;
//                    sb.append("s.").append(conditionArray[1]).append(" ").append(conditionArray[0]).append(",");
//                }
//            }
//            if (sb.length() > 1) {
//                sb.deleteCharAt(sb.length() - 1);
//            }
//        }
//
//        XQuery xQuery = new XQuery();
//        xQuery.setStringBuilder(sb);
//        xQuery.setFlag(flag);
//
//        return xQuery;
//
//    }
//
//    /*查询 对象 select from*/
//    private String fetchQueryHead(String queryModel, DoQuery doQuery) {
//
//        String tempQueryHql = doQuery.getQueryHql();
//
//        StringBuilder sb = new StringBuilder();
//        if (tempQueryHql != null && !tempQueryHql.equals("")) {
//            sb.append("select distinct s from ");
//        } else {
//            sb.append("select s from ");
//        }
//
//        sb.append(queryModel);
//        sb.append(" s ");
//        if (tempQueryHql != null && !tempQueryHql.equals("")) {
//            sb.append(doQuery.getQueryHql()).append(" ");
//        }
//
//        return sb.toString();
//
//    }
/*

    */
/*图表*//*

    @Override
    public String generateJsonData(Do tempDo, DoQuery tempDoQuery, String tempConditions) throws Exception {

        XQuery xQuery = generateGroupByQueryString(tempDo, tempDoQuery, tempConditions);
        List<Object[]> taskList = (List<Object[]>) xdoDao.getObjectList(xQuery.getStringBuilder().toString(), xQuery.getQueryParamMap());

        List<GroupType> groupTypeList = generateGroupTypeList(tempDoQuery.getGroupByList(), tempDoQuery.getConditionList(), tempConditions);

        StringBuilder stringBuilder = null;
        if (tempDo.getResult().equals("pie")) {     */
/*饼状图*//*

            stringBuilder = generatePieChartJsonData(tempDo, tempDoQuery, groupTypeList, taskList);
        } else {        */
/*其他图表*//*

            stringBuilder = generateChartJsonData(tempDo, tempDoQuery, groupTypeList, taskList);
        }


        return stringBuilder.toString();  //To change body of implemented methods use File | Settings | File Templates.
    }
*/

    /*通用list页面  json*/
    @Override
    public String generateResultListPage(String queryModel, Do tempDo, DoQuery tempDoQuery, Page tempPage, String tempConditions, PageEntity pageEntity) throws Exception {

//        long dateinit = System.currentTimeMillis();
        MethodCache methodCache = new MethodCache();
        methodCache.init(tempDo, tempPage);

//        long date1 = System.currentTimeMillis();
        PageInfo pageInfo = listPage(tempDo, tempDoQuery, tempConditions, pageEntity);
        String projectUrl = ApplicationContextUtil.getApplicationContext().getApplicationName();
//        long date2 = System.currentTimeMillis();
        StringBuilder stringBuilder = new StringBuilder(10000);
        stringBuilder.append("{").append("\"total\":").append(pageInfo.getCount()).append(",").append("\"rows\":");
        stringBuilder.append("[");
        if (pageInfo.getList() != null) {
            for (Object object : pageInfo.getList()) {

                stringBuilder.append("{");

                /*操作...修改删除*/
                if (tempPage.getOperationList() != null) {
                    stringBuilder.append(generateOperation(object, tempPage).toString());
                }

                boolean theFlag = false;
                for (PageField pageField : tempPage.getFieldList()) {

                    Object fieldValue = SystemValueUtil.fetchFieldValue(object, methodCache, pageField.getName().split("\\."));
                    StringBuilder sb = new StringBuilder(100);

                    if (fieldValue == null) {
//                        sb.append("");
                    } else {
                        /*查看*/
                        if (pageField.getUrl() != null && !pageField.getUrl().equals("")) {
                            String url = convertPageUrl(pageField.getUrl(), object);
                            url = projectUrl + url;
                            if (pageField.getInputType().equals("pop")) {
                                sb.append("<a href='###' onclick='art.dialog.open(\\\"").append(url).append("\\\", {width:800, height:600})'>");
                            } else {
                                sb.append("<a href='").append(url).append("'>");
                            }
                            sb.append(fieldValue.toString()).append("</a>");
                        } else if (!theFlag && tempDo.getType().endsWith("dialog") && !pageField.getInputType().equals("default")) {
                            /* 处理弹窗 ， 当queryModel【0】以dialog结尾，并且在循环中位于第一位,  点击后传值*/
                            theFlag = true;
                            String id = ReflectUtil.invokeMethod(object, "getId", null, null).toString();
//                            String name = ReflectUtil.invokeMethod(object, "getName", null, null).toString();          /*获取非user的对象的name值*/
                            sb.append("<a href='###' onclick='chooseObject(\\\"").append(id).append("\\\",\\\"").append(fieldValue.toString()).append("\\\")'>").append(fieldValue.toString()).append("</a>");
                        } else if (!theFlag && tempDo.getType().equals("relation") && !pageField.getInputType().equals("default")) {
                            /* 处理弹窗 ， 当queryModel【0】以dialog结尾，并且在循环中位于第一位,  点击后传值*/
                            theFlag = true;
                            String id = ReflectUtil.invokeMethod(object, "getId", null, null).toString();
                            String xentityName = tempDo.getXentity().getName();          /*获取非user的对象的name值*/
                            sb.append("<a href='###' onclick='chooseObject(\\\"").append(xentityName).append("\\\",\\\"").append(id).append("\\\")'>").append(fieldValue.toString()).append("</a>");
                        } else if (pageField.getInputType().equals("select_dictionary") || pageField.getInputType().equals("radio_dictionary")) {
                            DictionaryData dictionaryData = (DictionaryData) xdoDao.getObject(DictionaryData.class.getName(), fieldValue.toString());
                            sb.append(dictionaryData.getData());
                        } else if (pageField.getDataType().equals("status")) {
                            sb.append(moduleManager.convertStatusTypeLabel(pageField.getKey(), fieldValue.toString()));
                        } else if (pageField.getDataType().equals("datetime")) {
                            sb.append(DateUtil.formatDateMinute((Date) fieldValue));
                        } else if (pageField.getDataType().equals("date")) {
                            sb.append(DateUtil.formatDate((Date) fieldValue));
                        } else {
//                            String str = fieldValue.toString().replace("\r\n", "").replace("\r", "").replace("\n", "");           //回车键
//                            str = str.replace("\"", "\\\"");          //双引号
                            sb.append(fieldValue.toString());
                        }

                    }


                    /*String sbKey = pageField.getName();
                    if (pageField.getLabel().equals("id")) {
                        sbKey = "id";
                    }*/

                    stringBuilder.append("\"").append(pageField.getName()).append("\":\"").append(sb.toString()).append("\"");
                    stringBuilder.append(",");
                }

                if (stringBuilder.toString().endsWith(",")) {
                    stringBuilder.deleteCharAt(stringBuilder.length() - 1);
                }
                stringBuilder.append("},");
            }
            if (stringBuilder.toString().endsWith(",")) {
                stringBuilder.deleteCharAt(stringBuilder.length() - 1);
            }
        }
        stringBuilder.append("]");
        stringBuilder.append("}");
//        long date3 = System.currentTimeMillis();

//        System.out.println("=================date1-dateinit=" + (date1-dateinit) + "====================================================");
//        System.out.println("=================date2-date1=" + (date2-date1) + "====================================================");
//        System.out.println("=================date3-date2=" + (date3-date2) + "====================================================");

        return stringBuilder.toString();  //To change body of implemented methods use File | Settings | File Templates.
    }


    /*通用list  json*/
    @Override
    public String generateResultList(String queryModel, Do tempDo, DoQuery tempDoQuery, Page tempPage, String tempConditions) throws Exception {

//        Page tempPage = tempDo.getPageList().get(0);

        MethodCache methodCache = new MethodCache();
        methodCache.init(tempDo, tempPage);

        Object objectList = list(tempDo, tempDoQuery, tempConditions);
        StringBuilder stringBuilder = new StringBuilder(10000);
        stringBuilder.append("[");
        if (objectList != null) {
            for (Object object : (List<Object>) objectList) {

                stringBuilder.append("{");

                for (PageField pageField : tempPage.getFieldList()) {
                    try {
                        Object fieldValue = SystemValueUtil.fetchFieldValue(object, methodCache, pageField.getName().split("\\."));

                        StringBuilder sb = new StringBuilder(100);
                        if (fieldValue != null) {
                            if (pageField.getDataType().equals("status")) {
                                sb.append(moduleManager.convertStatusTypeLabel(pageField.getKey(), fieldValue.toString()));
                            } else if (pageField.getDataType().equals("datetime")) {
                                sb.append(DateUtil.formatDateMinute((Date) fieldValue));
                            } else if (pageField.getDataType().equals("date")) {
                                sb.append(DateUtil.formatDate((Date) fieldValue));
                            } else {
//                            String str = fieldValue.toString().replace("\r\n", "").replace("\r", "").replace("\n", "");           //回车键
//                            str = str.replace("\"", "\\\"");          //双引号
                                sb.append(fieldValue.toString());
                            }
                        }

                        stringBuilder.append("\"").append(pageField.getName().replace(".", "_")).append("\":\"").append(sb.toString()).append("\"");
                        stringBuilder.append(",");
                    } catch (Exception e) {
                        e.printStackTrace();
                    }

                }

                if (stringBuilder.toString().endsWith(",")) {
                    stringBuilder.deleteCharAt(stringBuilder.length() - 1);
                }
                stringBuilder.append("},");
            }
            if (stringBuilder.toString().endsWith(",")) {
                stringBuilder.deleteCharAt(stringBuilder.length() - 1);
            }
        }
        stringBuilder.append("]");

        return stringBuilder.toString();  //To change body of implemented methods use File | Settings | File Templates.
    }

    private Object fetchObjectByConditions(Object object, String conditions) {

        if (conditions != null && !conditions.equals("")) {
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
        }

        return object;
    }

    /*通用查看页面  json*/
    @Override
    public String generateResultViewPage(Do tempDo, String id, String conditions) throws Exception {
        Page tempPage = tempDo.getPageList().get(0);

        MethodCache methodCache = new MethodCache();
        methodCache.init(tempDo, tempPage);

        Object object;
        if (id != null && !id.equals("")) {
            object = xdoDao.getObject(tempDo.getXentity().getModel(), id);
        } else {
            object = ReflectUtil.getNewInstance(tempDo.getXentity().getModel());
            object = fetchObjectByConditions(object, conditions);

        }

        StringBuilder stringBuilder = new StringBuilder();

        stringBuilder.append(viewPageJson(tempPage, object, methodCache));

        return stringBuilder.toString();  //To change body of implemented methods use File | Settings | File Templates.
    }

    public String viewPageJson(Page tempPage, Object object, MethodCache methodCache) throws Exception {
        StringBuilder stringBuilder = new StringBuilder();
        stringBuilder.append("[");
        for (PageField pageField : tempPage.getFieldList()) {

            String pageFieldName = pageField.getName();
            if (pageFieldName.endsWith(".id")) {
                pageFieldName = pageFieldName.substring(0, pageFieldName.length() - 3);
            }

            Object fieldValue = SystemValueUtil.fetchFieldValue(object, methodCache, pageFieldName.split("\\."));

            StringBuilder sb = new StringBuilder(100);
            if (fieldValue != null) {
                if (pageField.getDataType().equals("status") || pageField.getInputType().equals("select_status") || pageField.getInputType().equals("radio_status")) {

                    String tempId = fieldValue.toString();
                    String tempName = moduleManager.convertStatusTypeLabel(pageField.getKey(), fieldValue.toString());

                    sb.append(tempId).append(",").append(tempName);
                } else if (pageField.getInputType().equals("select_dictionary") || pageField.getInputType().equals("radio_dictionary")) {
                    String tempId = ReflectUtil.invokeGetterMethod(fieldValue, "id").toString();
                    String tempName = ReflectUtil.invokeGetterMethod(fieldValue, "data").toString();

                    sb.append(tempId).append(",").append(tempName);
                } else if (pageField.getDataType().equals("datetime")) {
                    sb.append(DateUtil.formatDateMinute((Date) fieldValue));
                } else if (pageField.getDataType().equals("date")) {
                    sb.append(DateUtil.formatDate((Date) fieldValue));
                } else if (pageField.getDataType().equals("sub") || pageField.getInputType().equals("dialog_pop") || pageField.getInputType().equals("dialog_do")) {
                    String tempId = ReflectUtil.invokeGetterMethod(fieldValue, "id").toString();
                    String tempName = ReflectUtil.invokeGetterMethod(fieldValue, "name").toString();

                    sb.append(tempId).append(",").append(tempName);
                } else {
//                    String str = fieldValue.toString().replace("\r\n", "").replace("\r", "").replace("\n", "");           //回车键
//                    str = str.replace("\"", "\\\"");          //双引号
                    sb.append(fieldValue.toString());
                }

            }

            stringBuilder.append("{");
            stringBuilder.append("\"label\"").append(":").append("\"").append(pageField.getLabel()).append("\"").append(",");
            stringBuilder.append("\"name\"").append(":").append("\"").append(pageField.getName()).append("\"").append(",");
            stringBuilder.append("\"value\"").append(":").append("\"").append(sb.toString()).append("\"").append(",");
            stringBuilder.append("\"inputType\"").append(":").append("\"").append(pageField.getInputType()).append("\"").append(",");
            stringBuilder.append("\"key\"").append(":").append("\"").append(pageField.getKey()).append("\"").append(",");
            stringBuilder.append("\"position\"").append(":").append("\"").append(pageField.getPosition()).append("\"").append(",");
            stringBuilder.append("\"group\"").append(":").append("\"").append(pageField.getGroup()).append("\"").append(",");
            stringBuilder.append("\"required\"").append(":").append("\"").append(pageField.getRequired()).append("\"").append(",");
            stringBuilder.append("\"url\"").append(":").append("\"").append(pageField.getUrl()).append("\"");
            stringBuilder.append("}").append(",");

        }
        stringBuilder.deleteCharAt(stringBuilder.length() - 1);
        stringBuilder.append("]");
        return stringBuilder.toString();
    }



    private Boolean processPermission(String access, Object object, String owner) throws Exception {
   /*     if(AuthorizationUtil.getMyUser()!=null&&!("").equals(AuthorizationUtil.getMyUser().getId())){
            if (("system").equals(AuthorizationUtil.getMyUser().getRole())) {
                return true;
            }
        }*/


        String ownerId = "";
        if (!owner.equals("")) {

            String tempOwnerId = owner.substring(owner.indexOf("${") + 2, owner.indexOf("}"));
            Object id = SystemValueUtil.generateTempObjectValue(object, tempOwnerId.split("\\."));
            if (id != null) {
                ownerId = id.toString();
            }
        }
        return true;
    }


    /*FORM 或者 VIEW的时候set指定的值*/
    private void generateFetchObjectSetValue(Object object, Class objectClass, String fieldName, Object value) {

        try {
            Field field = objectClass.getDeclaredField(fieldName);
            field.setAccessible(true);
            field.set(object, value);
        } catch (Exception e) {
            generateFetchObjectSetValue(object, objectClass.getSuperclass(), fieldName, value);
        }

    }



    private XQuery executeXQueryHandler(XQuery xQuery, DoQuery doQuery) throws Exception {
        QueryHandler queryHandler = (QueryHandler) Class.forName(doQuery.getQueryExecute()).newInstance();

        return queryHandler.handle(xQuery);
    }

    /*list页面    生成operation   操作链接*/
    public StringBuilder generateOperation(Object object, Page tempPage) throws Exception {
        StringBuilder stringBuilder = new StringBuilder();
        stringBuilder.append("\"操作\":\"");
        for (Command command : tempPage.getOperationList()) {
            if (processPermission(command.getPermission(), object, command.getOwner())) {
                String url = convertPageUrl(command.getUrl(), object);
                url = ApplicationContextUtil.getApplicationContext().getApplicationName() + url;
                if (command.getType() != null && command.getType().equals("dialog")) {
                    stringBuilder.append("<a class='ho' href='###'")
                            .append(" onclick='artDialog.open(\\\"")
                            .append(url)
                            .append("\\\", {width:800,height:600})'")
                            .append("'>")
                            .append(command.getLabel())
                            .append("</a>");
                } else {
                    stringBuilder.append("<a class='ho' href='")
                            .append(url)
                            .append("'>")
                            .append(command.getLabel())
                            .append("</a>");
                }


                stringBuilder.append("   ");
            }
        }
        stringBuilder.append("\",");
        return stringBuilder;
    }

    /*转化url中${}中包含的对象属性*/
    public String convertPageUrl(String pageUrl, Object object) throws Exception {

        while (pageUrl.contains("$")) {
            String tempField = pageUrl.substring(pageUrl.indexOf("${") + 2, pageUrl.indexOf("}"));
            Object tempObjectValue2 = SystemValueUtil.generateTempObjectValue(object, tempField.split("\\."));
            if (tempObjectValue2 == null) {
                throw new Exception(pageUrl + ":" + tempField + "为空");
            }
            pageUrl = pageUrl.replace("${" + tempField + "}", tempObjectValue2.toString());
        }

        return pageUrl;
    }
    public void saveOrUpdateOperationLog(Do tempDo, String content, String operationType) {
        //Map<String, String> settingMap = AuthorizationUtil.getMyUser().getSettingMap();

        Boolean operation = true;//settingMap.get("operation");

        if (operation != null && operation.equals("true")) {

            OperationLog operationLog = new OperationLog();
            //operationLog.setUser(AuthorizationUtil.getUser());
            operationLog.setTheDateTime(new Date());
            operationLog.setEntityName(tempDo.getXentity().getName());
            operationLog.setEntityLabel(tempDo.getXentity().getLabel());
            operationLog.setContent(content);
            operationLog.setOperationType(operationType);

            xdoDao.saveOrUpdateObject(OperationLog.class.getName(), operationLog);

        }

    }
/*

    */
/*矩阵报表  (包含表达式)*//*

    @Override
    public LinkedHashMap<String, LinkedList<String>> generateReportData(Do tempDo, DoQuery tempDoQuery, String tempConditions) throws Exception {

        XQuery xQuery = generateGroupByQueryString(tempDo, tempDoQuery, tempConditions);
        List<Object[]> objectsList = (List<Object[]>) xdoDao.getObjectList(xQuery.getStringBuilder().toString(), xQuery.getQueryParamMap());
        List<GroupType> groupTypeList = generateGroupTypeList(tempDoQuery.getGroupByList(), tempDoQuery.getConditionList(), tempConditions);

        LinkedHashMap<String, LinkedList<String>> tempMap = new LinkedHashMap<>();


        String expressions = "";           //表达式
        if (groupTypeList.size() > 1) {
            LinkedList<String> stringList = new LinkedList<>();
            for (GroupTypeEntity groupTypeEntity : groupTypeList.get(1).getGroupTypeEntityList()) {
                stringList.add(groupTypeEntity.getValue());
            }

            expressions = tempDoQuery.getGroupByList().get(1).getExpression();
            if (!expressions.equals("")) {
                stringList.add(expressions.split("_")[0]);
            }

            tempMap.put("", stringList);

        } else {
            expressions = tempDoQuery.getGroupByList().get(0).getExpression();
        }


        for (GroupTypeEntity yGroupTypeEntity : groupTypeList.get(0).getGroupTypeEntityList()) {
            LinkedList<String> strList = new LinkedList<>();
            if (groupTypeList.size() > 1) {
                for (GroupTypeEntity xGroupTypeEntity : groupTypeList.get(1).getGroupTypeEntityList()) {
                    */
/*情况特殊，为了适应一维数组，X轴和Y轴的值交换一下位置*//*

                    strList.add(getTotal(xGroupTypeEntity, yGroupTypeEntity, objectsList));
                }
            } else {
                strList.add(getTotal(yGroupTypeEntity, null, objectsList));
            }

            */
/*二维矩阵*//*

            if (!expressions.equals("") && expressions.contains("/") && groupTypeList.size() > 1) {
                String tempExpression = expressions.split("_")[1];
                List<GroupTypeEntity> groupTypeEntityList = groupTypeList.get(1).getGroupTypeEntityList();

                for (int i = 0; i < groupTypeEntityList.size(); i++) {
                    String testValue = groupTypeEntityList.get(i).getValue();
                    if (tempExpression.contains(testValue)) {
                        tempExpression = tempExpression.replace(testValue, strList.get(i));
                    }
                }

                String[] es = tempExpression.split("/");
                String[] ess = es[1].substring(1, es[1].length() - 1).replace('+', ',').split(",");
                Integer totalCount = 0;
                for (String eses : ess) {
                    totalCount = totalCount + Integer.parseInt(eses);
                }
                if (totalCount == 0) {
                    strList.add("0");
                } else {
                    strList.add(BigDecimal.valueOf((Double.parseDouble(es[0]) / totalCount) * 100).setScale(2, BigDecimal.ROUND_HALF_UP) + "%");
                }

            } else if (!expressions.equals("") && expressions.contains("sum") && groupTypeList.size() > 1) {
                BigDecimal totalCount = new BigDecimal(0);
                for (String eses : strList) {
                    totalCount = totalCount.add(new BigDecimal(eses));
                }
                strList.add(totalCount.toString());
            }


            tempMap.put(yGroupTypeEntity.getValue(), strList);
        }

        */
/*一维矩阵*//*

        if (groupTypeList.size() == 1) {
            if (!expressions.equals("") && expressions.contains("/")) {
                String tempExpression = expressions.split("_")[1];
                String[] es = tempExpression.split("/");
                String[] ess = es[1].substring(1, es[1].length() - 1).replace('+', ',').split(",");
                Integer totalCount = 0;
                for (String eses : ess) {
                    totalCount = totalCount + Integer.parseInt(tempMap.get(eses).get(0));
                }
                LinkedList<String> stringList = new LinkedList<>();
                if (totalCount == 0) {
                    stringList.add("0");
                } else {
                    stringList.add(BigDecimal.valueOf((Double.parseDouble(tempMap.get(es[0]).get(0)) / totalCount) * 100).setScale(2, BigDecimal.ROUND_HALF_UP) + "%");
                }
                tempMap.put(expressions.split("_")[0], stringList);
            } else if (!expressions.equals("") && expressions.contains("sum")) {
                tempMap.put(expressions.split("_")[0], generateTotalCount(1, 1, tempMap));
            }
        } else if (groupTypeList.size() > 1) {
            String tempExpressions = tempDoQuery.getGroupByList().get(0).getExpression();
            if (!tempExpressions.equals("") && tempExpressions.contains("sum")) {
                Integer length = groupTypeList.get(1).getGroupTypeEntityList().size();
                if (!expressions.equals("")) {
                    length = length + 1;
                }
                tempMap.put(tempExpressions.split("_")[0], generateTotalCount(2, length, tempMap));
            }
        }

        return tempMap;  //To change body of implemented methods use File | Settings | File Templates.
    }
*/
/*
    @Override
    public LinkedHashMap<String, LinkedList<String>> generateNewReportData(Do tempDo, DoQuery tempDoQuery, String tempConditions) throws Exception {

        LinkedHashMap<String, LinkedList<String>> tempMap = new LinkedHashMap<>();

        List<Groupby> groupbyList = new ArrayList<>();
        Groupby tempGroupBy = null;
        Groupby tempGroupBy2 = null;
        for (Groupby groupby : tempDoQuery.getGroupByList()) {
            if (groupby.getGtype().startsWith("status_")) {
                tempGroupBy = groupby;
            } else {
                tempGroupBy2 = groupby;
                groupbyList.add(groupby);
            }
        }

        if (tempGroupBy == null) {
            return null;
        }

        *//*List<GroupType> groupTypeList = new ArrayList<>();
        if (groupbyList.size() > 0) {            //两个分组条件
            groupTypeList = generateGroupTypeList(groupbyList, tempDoQuery.getConditionList(), tempConditions);
            LinkedList<String> stringList = new LinkedList<>();
            for (GroupTypeEntity groupTypeEntity : groupTypeList.get(0).getGroupTypeEntityList()) {
                stringList.add(groupTypeEntity.getValue());
            }
            tempMap.put("", stringList);
        }

        for (String groupByKey:groupByKeys) {

            String[] groupByKeyArray = groupByKey.split(":");

            String groupByKeyName = groupByKeyArray[0];
            String groupByKeyOperation = groupByKeyArray[1];
            String groupByKeyValue = groupByKeyArray[2].substring(groupByKeyArray[2].indexOf("(") + 1, groupByKeyArray[2].indexOf(")"));

            XQuery xQuery = generateNewGroupByQueryString(tempDo, groupByKeyOperation, groupByKeyValue, tempGroupBy, tempGroupBy2, tempDoQuery.getConditionList(), tempConditions);
            List<Object[]> objectsList = (List<Object[]>) xdoDao.getObjectList(xQuery.getStringBuilder().toString(), xQuery.getQueryParamMap());


            LinkedList<String> strList = new LinkedList<>();

            if (groupbyList.size() > 0) {             //两个分组条件
                for (GroupTypeEntity yGroupTypeEntity : groupTypeList.get(0).getGroupTypeEntityList()) {
                    strList.add(getTotal(yGroupTypeEntity, null, objectsList).toString());
                }
            } else {
                String count = "0";
                if (objectsList != null && objectsList.size() > 0) {
                    count = String.valueOf(objectsList.get(0));
                }

                strList.add(count);
            }

            tempMap.put(groupByKeyName, strList);
        }


        if (!tempGroupBy.getExpression().equals("")) {

            String[] expressions = tempGroupBy.getExpression().split(";");

            for (String expression:expressions) {

                String[] exArray = expression.split("_");
                LinkedList<String> stringList = new LinkedList<>();


                if (groupbyList.size() > 0) {           //两个分组条件
                    for (int i = 0; i < groupTypeList.get(0).getGroupTypeEntityList().size(); i++) {

                        String tempExpression = exArray[1];

                        for (String groupByKey:groupByKeys) {
                            String[] groupByKeyArray = groupByKey.split(":");
                            String groupByKeyName = groupByKeyArray[0];

                            if (tempExpression.contains(groupByKeyName)) {
                                LinkedList<String> tempStrList = tempMap.get(groupByKeyName);
                                tempExpression = tempExpression.replace(groupByKeyName, tempStrList.get(i));
                            }
                        }

                        stringList.add(generatePercent(tempExpression));

                    }
                } else {
                    String tempExpression = exArray[1];
                    for (String groupByKey:groupByKeys) {
                        String[] groupByKeyArray = groupByKey.split(":");
                        String groupByKeyName = groupByKeyArray[0];

                        if (exArray[1].contains(groupByKeyName)) {
                            LinkedList<String> tempStrList = tempMap.get(groupByKeyName);
                            tempExpression = tempExpression.replace(groupByKeyName, tempStrList.get(0));
                        }
                    }

                    stringList.add(generatePercent(tempExpression));
                }

                tempMap.put(exArray[0], stringList);
            }

        }
        *//*


        String[] groupByKeys = tempGroupBy.getKey().split(";");

        LinkedList<String> strList1 = new LinkedList<>();
        for (String groupByKey : groupByKeys) {
            strList1.add(groupByKey.split(":")[0]);
        }
        if (!tempGroupBy.getExpression().equals("")) {
            String[] expressions = tempGroupBy.getExpression().split(";");
            for (String expression : expressions) {
                strList1.add(expression.split("_")[0]);
            }
        }
        tempMap.put("", strList1);


        if (groupbyList.size() > 0) {
            List<GroupType> groupTypeList = generateGroupTypeList(groupbyList, tempDoQuery.getConditionList(), tempConditions);
            for (GroupTypeEntity groupTypeEntity : groupTypeList.get(0).getGroupTypeEntityList()) {

                LinkedList<String> strList2 = new LinkedList<>();
                for (String groupByKey : groupByKeys) {
                    String[] groupByKeyArray = groupByKey.split(":");

                    String groupByKeyOperation = groupByKeyArray[1];
                    String groupByKeyValue = groupByKeyArray[2].substring(groupByKeyArray[2].indexOf("(") + 1, groupByKeyArray[2].indexOf(")"));

                    XQuery xQuery = generateNewGroupByQueryString(tempDo, groupByKeyOperation, groupByKeyValue, tempGroupBy, tempGroupBy2, tempDoQuery, tempConditions);
                    List<Object[]> objectsList = (List<Object[]>) xdoDao.getObjectList(xQuery.getStringBuilder().toString(), xQuery.getQueryParamMap());

                    String totalCount = "0";
                    for (Object[] objects : objectsList) {
                        if (objects[0].equals(groupTypeEntity.getName())) {
                            totalCount = objects[1].toString();
//                            strList2.add(objects[1].toString());
                        }
                    }

                    strList2.add(totalCount);
                }

                if (!tempGroupBy.getExpression().equals("")) {
                    String[] expressions = tempGroupBy.getExpression().split(";");
                    for (String expression : expressions) {

                        String tempExpression = expression.split("_")[1];

                        for (int i = 0; i < groupByKeys.length; i++) {
                            String tempGroupByKey = groupByKeys[i].split(":")[0];
                            if (tempExpression.contains(tempGroupByKey)) {
                                tempExpression = tempExpression.replace(tempGroupByKey, strList2.get(i));
                            }
                        }

                        strList2.add(generatePercent(tempExpression));
                    }
                }

                tempMap.put(groupTypeEntity.getValue(), strList2);
            }
        } else {

            LinkedList<String> strList2 = new LinkedList<>();
            for (String groupByKey : groupByKeys) {
                String[] groupByKeyArray = groupByKey.split(":");

                String groupByKeyOperation = groupByKeyArray[1];
                String groupByKeyValue = groupByKeyArray[2].substring(groupByKeyArray[2].indexOf("(") + 1, groupByKeyArray[2].indexOf(")"));

                XQuery xQuery = generateNewGroupByQueryString(tempDo, groupByKeyOperation, groupByKeyValue, tempGroupBy, tempGroupBy2, tempDoQuery, tempConditions);
                List<Object[]> objectsList = (List<Object[]>) xdoDao.getObjectList(xQuery.getStringBuilder().toString(), xQuery.getQueryParamMap());

                if (objectsList != null && objectsList.size() > 0) {
                    strList2.add(String.valueOf(objectsList.get(0)));
                } else {
                    strList2.add("0");
                }

            }

            if (!tempGroupBy.getExpression().equals("")) {
                String[] expressions = tempGroupBy.getExpression().split(";");
                for (String expression : expressions) {

                    String tempExpression = expression.split("_")[1];

                    for (int i = 0; i < groupByKeys.length; i++) {
                        String tempGroupByKey = groupByKeys[i];
                        if (tempExpression.contains(tempGroupByKey)) {
                            tempExpression = tempExpression.replace(tempGroupByKey, strList2.get(i));
                        }
                    }

                    strList2.add(generatePercent(tempExpression));
                }
            }

            tempMap.put("数量", strList2);


        }


        return tempMap;  //To change body of implemented methods use File | Settings | File Templates.
    }*/
/*

    private String generatePercent(String expression) {
        String percent = "";
        String[] es = expression.split("/");

        Double total = 0.00;
        if (es[1].contains("+")) {
            String[] ess = es[0].split("\\+");
            for (String eses : ess) {
                total = total + Double.valueOf(eses);
            }
        } else {
            total = Double.valueOf(es[0]);
        }

        Integer totalCount = 0;
        if (es[1].contains("+")) {
            String[] ess = es[1].split("\\+");

            for (String eses : ess) {
                totalCount = totalCount + Integer.parseInt(eses);
            }
        } else {
            totalCount = Integer.parseInt(es[1]);
        }

        if (totalCount == 0) {
            percent = "0";
        } else {
            percent = BigDecimal.valueOf((total / totalCount) * 100).setScale(2, BigDecimal.ROUND_HALF_UP) + "%";
        }

        return percent;
    }


    private Object generateGroupByKeyValue(String groupByKeyValue, String groupByKeyOperation, Groupby groupby) {

        Object object = null;
        if (groupByKeyOperation.equals("in") || groupByKeyOperation.equals("not in")) {
            List<Object> valueList = new ArrayList<>();
            Boolean flag = false;
            if (groupby.getGtype().indexOf("int") > 0) {
                flag = true;
            }
            String[] values = groupByKeyValue.split(",");
            for (String value : values) {
                if (flag) {
                    valueList.add(Integer.parseInt(value));
                } else {
                    valueList.add(value);
                }
            }
            object = valueList;
        } else {
            if (groupby.getGtype().indexOf("int") > 0) {
                object = Integer.parseInt(groupByKeyValue);
            } else {
                object = groupByKeyValue;
            }
        }

        return object;
    }

    */
/*生成   查询语句（包含group by的查询语句） 和查询参数    *//*

    private XQuery generateNewGroupByQueryString(Do tempDo, String groupByKeyOperation, String groupByKeyValue, Groupby groupby1, Groupby groupby2, DoQuery doQuery, String tempConditions) {

        String queryHql = doQuery.getQueryHql();

        LinkedHashMap<String, Object> queryParamMap = new LinkedHashMap<>();

        StringBuilder sb = new StringBuilder(100);

        */
/*拼写 配置文件中的conditon*//*

        XQuery tempXQuery = fetchXQueryByConditions(doQuery.getConditionList(), doQuery, tempConditions);
        sb.append(tempXQuery.getStringBuilder());
        queryParamMap.putAll(tempXQuery.getQueryParamMap());

        if (!groupby1.getName().startsWith("t.")) {
            sb.append(" and s.").append(groupby1.getName());
        } else {
            sb.append(" and ").append(groupby1.getName());
        }

        if (groupByKeyOperation.equals("in") || groupByKeyOperation.equals("not in")) {
            sb.append(" ").append(convertOperator(groupByKeyOperation)).append("(:groupByList)");
            queryParamMap.put("groupByList", generateGroupByKeyValue(groupByKeyValue, groupByKeyOperation, groupby1));
        } else {
            sb.append(" ").append(convertOperator(groupByKeyOperation)).append(":groupByList");
            queryParamMap.put("groupByList", generateGroupByKeyValue(groupByKeyValue, groupByKeyOperation, groupby1));
        }


        StringBuilder queryStringBuilder = new StringBuilder(300);
        queryStringBuilder.append("select");

        if (groupby2 != null) {
            sb.append(" group by");

            String tempQueryHql2 = "";
            String groupby2Name = groupby2.getName();
            if (!groupby2Name.startsWith("t.")) {
                groupby2Name = "s." + groupby2Name;
            }
            if (groupby2Name.endsWith("Datetime")) {
                tempQueryHql2 = "date_format(" + groupby2Name + ",";
                if (groupby2.getGtype().equals("date_month")) {
                    tempQueryHql2 += "'%Y-%m')";
                } else if (groupby2.getGtype().equals("date_day")) {
                    tempQueryHql2 += "'%Y-%m-%d')";
                }
            } else {
                tempQueryHql2 = groupby2Name;
            }
            sb.append(" ").append(tempQueryHql2);
            queryStringBuilder.append(" ").append(tempQueryHql2).append(",");
        }


        if (tempDo.getData() != null && !tempDo.getData().equals("")) {
            queryStringBuilder.append(" ").append(tempDo.getData());
        } else {
            queryStringBuilder.append(" count(s)");
        }
        queryStringBuilder.append(" from ");
        queryStringBuilder.append(tempDo.getXentity().getModel());
        queryStringBuilder.append(" s ");
        if (queryHql != null && !queryHql.equals("")) {
            queryStringBuilder.append(queryHql).append(" ");
        }
        queryStringBuilder.append(sb.toString().replaceFirst("and", "where"));


        XQuery xQuery = new XQuery();
        xQuery.setStringBuilder(queryStringBuilder);
        xQuery.setQueryParamMap(queryParamMap);

        return xQuery;
    }

*/
/*
*/

/* 数据矩阵报表*//*

    @Override
    public LinkedHashMap<String, LinkedList<String>> generateDataReportMatrixData(Do tempDo, DoQuery tempDoQuery, Page tempPage, String tempConditions) throws Exception {

        MethodCache methodCache = new MethodCache();
        methodCache.init(tempDo, tempPage);

        XQuery xQuery = generateQueryString(tempDo.getXentity().getModel(), tempDoQuery, tempConditions);
        List<Object> objectList = (List<Object>) xdoDao.getObjectList(xQuery.getStringBuilder().toString(), xQuery.getQueryParamMap());

        List<Groupby> groupByList = tempDoQuery.getGroupByList();
        List<GroupType> groupTypeList = generateGroupTypeList(tempDoQuery.getGroupByList(), tempDoQuery.getConditionList(), tempConditions);

        LinkedHashMap<String, LinkedList<String>> tempMap = new LinkedHashMap<>();

        LinkedList<String> stringList = new LinkedList<>();
        for (GroupTypeEntity groupTypeEntity : groupTypeList.get(1).getGroupTypeEntityList()) {
            stringList.add(groupTypeEntity.getValue());
        }
        tempMap.put("", stringList);

        for (GroupTypeEntity yGroupTypeEntity : groupTypeList.get(0).getGroupTypeEntityList()) {
            Groupby groupBy1 = groupByList.get(0);

            LinkedList<String> stringLinkedList = new LinkedList<>();
            for (GroupTypeEntity xGroupTypeEntity : groupTypeList.get(1).getGroupTypeEntityList()) {
                String str = "";
                if (isGorun(xGroupTypeEntity, yGroupTypeEntity)) {
                    Groupby groupBy2 = groupByList.get(1);

                    for (Object object : objectList) {
                        String strValue1 = generateDataReportGroupValue(object, groupBy1.getName());
                        String strValue2 = generateDataReportGroupValue(object, groupBy2.getName());
                        if (strValue1.equals(yGroupTypeEntity.getName()) && strValue2.equals(xGroupTypeEntity.getName())) {

                            for (PageField pageField : tempPage.getFieldList()) {

                                Object fieldValue = SystemValueUtil.fetchFieldValue(object, methodCache, pageField.getName().split("\\."));
                                StringBuilder sb = new StringBuilder(100);
                                if (fieldValue == null) {
                                } else {
                                    if (pageField.getDataType().equals("status")) {
                                        sb.append(moduleManager.convertStatusTypeLabel(pageField.getKey(), fieldValue.toString()));
                                    } else if (pageField.getDataType().equals("datetime")) {
                                        sb.append(DateUtil.formatDateMinute((Date) fieldValue));
                                    } else if (pageField.getDataType().equals("date")) {
                                        sb.append(DateUtil.formatDate((Date) fieldValue));
                                    } else {
                                        sb.append(fieldValue.toString());
                                    }
                                }


                                str += sb.toString() + "&nbsp;";
                            }
                            str += "<br/>";
                        }
                    }

                }
                stringLinkedList.add(str);
            }

            tempMap.put(yGroupTypeEntity.getValue(), stringLinkedList);
        }


        return tempMap;  //To change body of implemented methods use File | Settings | File Templates.
    }
*/
/*


    */
/*二维数据报表*//*

    @Override
    public LinkedHashMap<GroupTypeEntity, Map<GroupTypeEntity, String>> generateDataReportData(Do tempDo, DoQuery tempDoQuery, Page tempPage, String tempConditions) throws Exception {

        MethodCache methodCache = new MethodCache();
        methodCache.init(tempDo, tempPage);

        List<Groupby> groupByList = tempDoQuery.getGroupByList();

        XQuery xQuery = generateQueryString(tempDo.getXentity().getModel(), tempDoQuery, tempConditions);
        List<Object> objectList = (List<Object>) xdoDao.getObjectList(xQuery.getStringBuilder().toString(), xQuery.getQueryParamMap());

        List<GroupType> groupTypeList = generateGroupTypeList(tempDoQuery.getGroupByList(), tempDoQuery.getConditionList(), tempConditions);

        String pageTotal = "";
        String pageTotalLabel = "";

        String tempPageTotal = tempPage.getTotal();
        if (!tempPageTotal.equals("")) {
            pageTotal = tempPage.getTotal().split("_")[1];
            pageTotalLabel = tempPage.getTotal().split("_")[0];
        }


        LinkedHashMap<GroupTypeEntity, Map<GroupTypeEntity, String>> tempMap = new LinkedHashMap<>();
        for (GroupTypeEntity yGroupTypeEntity : groupTypeList.get(0).getGroupTypeEntityList()) {
            Groupby groupBy1 = groupByList.get(0);
            GroupTypeEntity groupTypeEntity1 = new GroupTypeEntity();
            groupTypeEntity1.setName(yGroupTypeEntity.getValue());
            int objectSize1 = 0;
            Map<GroupTypeEntity, String> tempMap2 = new HashMap<>();
            for (GroupTypeEntity xGroupTypeEntity : groupTypeList.get(1).getGroupTypeEntityList()) {
                if (isGorun(xGroupTypeEntity, yGroupTypeEntity)) {
                    Groupby groupBy2 = groupByList.get(1);
                    GroupTypeEntity groupTypeEntity2 = new GroupTypeEntity();
                    groupTypeEntity2.setName(xGroupTypeEntity.getValue());

                    float total = 0;
//                    String pageTotal = tempPage.getTotal();

                    int objectSize2 = 0;
                    StringBuilder stringBuilder = new StringBuilder();
                    stringBuilder.append("[");
                    for (Object object : objectList) {
                        String strValue1 = generateDataReportGroupValue(object, groupBy1.getName());

                        if (strValue1.equals(yGroupTypeEntity.getName())) {
                            String strValue2 = generateDataReportGroupValue(object, groupBy2.getName());

                            if (strValue2.equals(xGroupTypeEntity.getName())) {
                                objectSize1++;
                                objectSize2++;

                                stringBuilder.append("{");
                                for (PageField pageField : tempPage.getFieldList()) {

                                    Object fieldValue = SystemValueUtil.fetchFieldValue(object, methodCache, pageField.getName().split("\\."));
                                    StringBuilder sb = new StringBuilder(100);
                                    if (fieldValue == null) {
                                    } else {
                                        if (pageField.getDataType().equals("status")) {
                                            sb.append(moduleManager.convertStatusTypeLabel(pageField.getKey(), fieldValue.toString()));
                                        } else if (pageField.getDataType().equals("datetime")) {
                                            sb.append(DateUtil.formatDateMinute((Date) fieldValue));
                                        } else if (pageField.getDataType().equals("date")) {
                                            sb.append(DateUtil.formatDate((Date) fieldValue));
                                        } else {
//                                            String str = fieldValue.toString().replace("\r\n", "").replace("\r", "").replace("\n", "");           //回车键
//                                            str = str.replace("\"", "\\\"");          //双引号
                                            sb.append(fieldValue.toString());
                                        }

                                        if (!pageTotal.equals("") && pageTotal.equals(pageField.getName())) {
                                            if (pageField.getDataType().equals("int")) {
                                                total += Integer.parseInt(fieldValue.toString());
                                            } else if (pageField.getDataType().equals("float")) {
                                                total += Float.parseFloat(fieldValue.toString());
                                            }
                                        }

                                    }

                                    stringBuilder.append("\"").append(pageField.getName()).append("\":\"").append(sb.toString()).append("\"");
                                    stringBuilder.append(",");
                                }
                                if (stringBuilder.toString().endsWith(",")) {
                                    stringBuilder.deleteCharAt(stringBuilder.length() - 1);
                                }
                                stringBuilder.append("},");
                            }
                        }
                    }
                    if (stringBuilder.toString().endsWith(",")) {
                        stringBuilder.deleteCharAt(stringBuilder.length() - 1);
                    }
                    stringBuilder.append("]");

                    groupTypeEntity2.setValue(xGroupTypeEntity.getName());
                    groupTypeEntity2.setCounts(objectSize2);
                    if (!pageTotalLabel.equals("")) {
                        groupTypeEntity2.setTotal(pageTotalLabel + ":" + total);
                    }


                    tempMap2.put(groupTypeEntity2, stringBuilder.toString());
                }
            }
            groupTypeEntity1.setValue(yGroupTypeEntity.getName());
            groupTypeEntity1.setCounts(objectSize1);
            tempMap.put(groupTypeEntity1, tempMap2);
        }


        return tempMap;  //To change body of implemented methods use File | Settings | File Templates.
    }
*/
/*
*/

/*一维数据报表*//*

    @Override
    public LinkedHashMap<GroupTypeEntity, String> generateDataReportData2(Do tempDo, DoQuery tempDoQuery, Page tempPage, String tempConditions) throws Exception {

        MethodCache methodCache = new MethodCache();
        methodCache.init(tempDo, tempPage);

        List<Groupby> groupByList = tempDoQuery.getGroupByList();

        XQuery xQuery = generateQueryString(tempDo.getXentity().getModel(), tempDoQuery, tempConditions);
        List<Object> objectList = (List<Object>) xdoDao.getObjectList(xQuery.getStringBuilder().toString(), xQuery.getQueryParamMap());

        List<GroupType> groupTypeList = generateGroupTypeList(tempDoQuery.getGroupByList(), tempDoQuery.getConditionList(), tempConditions);

        String pageTotal = "";
        String pageTotalLabel = "";

        String tempPageTotal = tempPage.getTotal();
        if (!tempPageTotal.equals("")) {
            pageTotal = tempPage.getTotal().split("_")[1];
            pageTotalLabel = tempPage.getTotal().split("_")[0];
        }

        LinkedHashMap<GroupTypeEntity, String> tempMap = new LinkedHashMap<>();
        for (GroupTypeEntity yGroupTypeEntity : groupTypeList.get(0).getGroupTypeEntityList()) {
            Groupby groupBy1 = groupByList.get(0);
            GroupTypeEntity groupTypeEntity1 = new GroupTypeEntity();
            groupTypeEntity1.setName(yGroupTypeEntity.getValue());

            float total = 0;
            int objectSize1 = 0;

            StringBuilder stringBuilder = new StringBuilder();
            stringBuilder.append("[");
            for (Object object : objectList) {
                String strValue1 = generateDataReportGroupValue(object, groupBy1.getName());
                if (strValue1.equals(yGroupTypeEntity.getName())) {
                    objectSize1++;
                    stringBuilder.append("{");
                    for (PageField pageField : tempPage.getFieldList()) {
                        Object fieldValue = SystemValueUtil.fetchFieldValue(object, methodCache, pageField.getName().split("\\."));
                        StringBuilder sb = new StringBuilder(100);
                        if (fieldValue == null) {
//                                    tempObjectValue = "";
                        } else {
                            if (pageField.getDataType().equals("status")) {
                                sb.append(moduleManager.convertStatusTypeLabel(pageField.getKey(), fieldValue.toString()));
                            } else if (pageField.getDataType().equals("datetime")) {
                                sb.append(DateUtil.formatDateMinute((Date) fieldValue));
                            } else if (pageField.getDataType().equals("date")) {
                                sb.append(DateUtil.formatDate((Date) fieldValue));
                            } else {
//                                String str = fieldValue.toString().replace("\r\n", "").replace("\r", "").replace("\n", "");           //回车键
//                                str = str.replace("\"", "\\\"");          //双引号
                                sb.append(fieldValue.toString());
                            }

                            if (!pageTotal.equals("") && pageTotal.equals(pageField.getName())) {
                                if (pageField.getDataType().equals("int")) {
                                    total += Integer.parseInt(fieldValue.toString());
                                } else if (pageField.getDataType().equals("float")) {
                                    total += Float.parseFloat(fieldValue.toString());
                                }
                            }
                        }

                        stringBuilder.append("\"").append(pageField.getName()).append("\":\"").append(sb.toString()).append("\"");
                        stringBuilder.append(",");
                    }
                    if (stringBuilder.toString().endsWith(",")) {
                        stringBuilder.deleteCharAt(stringBuilder.length() - 1);
                    }
                    stringBuilder.append("},");
                }
            }
            if (stringBuilder.toString().endsWith(",")) {
                stringBuilder.deleteCharAt(stringBuilder.length() - 1);
            }
            stringBuilder.append("]");

            groupTypeEntity1.setValue(yGroupTypeEntity.getName());
            if (!pageTotalLabel.equals("")) {
                groupTypeEntity1.setTotal(pageTotalLabel + ":" + total);
            }
            groupTypeEntity1.setCounts(objectSize1);

            tempMap.put(groupTypeEntity1, stringBuilder.toString());
        }

        return tempMap;  //To change body of implemented methods use File | Settings | File Templates.
    }
*/

/*
    */
/*生成   查询语句（包含group by的查询语句） 和查询参数    *//*

    private XQuery generateGroupByQueryString(Do tempDo, DoQuery doQuery, String tempConditions) {

        String queryHql = doQuery.getQueryHql();
        List<Groupby> groupByList = doQuery.getGroupByList();

        StringBuilder queryStringBuilder = new StringBuilder(300);

        StringBuilder sb = new StringBuilder(100);

        */
/*拼写 配置文件中的conditon*//*

        XQuery tempXQuery = fetchXQueryByConditions(doQuery.getConditionList(), doQuery, tempConditions);
        sb.append(tempXQuery.getStringBuilder());

        sb.append(" group by");

        queryStringBuilder.append("select");

        for (Groupby groupBy : groupByList) {
            String tempQueryHql = "";
            String propertyName = groupBy.getName();
            if (!propertyName.startsWith("t.")) {
                propertyName = "s." + propertyName;
            }
            if (groupBy.getGtype().equals("date_month") || groupBy.getGtype().equals("date_day")) {
                tempQueryHql = "date_format(" + propertyName + ",";
                if (groupBy.getGtype().equals("date_month")) {
                    tempQueryHql += "'%Y-%m')";
                } else if (groupBy.getGtype().equals("date_day")) {
                    tempQueryHql += "'%Y-%m-%d')";
                }
            } else {
                tempQueryHql = propertyName;
            }
            sb.append(" ").append(tempQueryHql).append(",");
            queryStringBuilder.append(" ").append(tempQueryHql).append(",");
        }

        if (sb.toString().endsWith(",")) {
            sb.deleteCharAt(sb.length() - 1);
        }
        if (tempDo.getData() != null && !tempDo.getData().equals("")) {
            queryStringBuilder.append(" ").append(tempDo.getData());
        } else {
            queryStringBuilder.append(" count(s)");
        }
        queryStringBuilder.append(" from ");
        queryStringBuilder.append(tempDo.getXentity().getModel());
        queryStringBuilder.append(" s ");
        if (queryHql != null && !queryHql.equals("")) {
            queryStringBuilder.append(queryHql).append(" ");
        }
        queryStringBuilder.append(sb.toString().replaceFirst("and", "where"));


        XQuery xQuery = new XQuery();
        xQuery.setStringBuilder(queryStringBuilder);
        xQuery.setQueryParamMap(tempXQuery.getQueryParamMap());

        return xQuery;
    }


    */
/*生成报表的时候    从查询出的list中  获取x轴， y轴 ，对应的 值*//*

    public String getTotal(GroupTypeEntity yGroupTypeEntity, GroupTypeEntity xGroupTypeEntity, List<Object[]> taskList) {

        String totalNum = "0";

        for (Object[] objects : taskList) {
            if (objects[0] == null) {
                objects[0] = "";
            }
            if (xGroupTypeEntity == null) {
                if (objects[0] != null && objects[0].toString().equals(yGroupTypeEntity.getName())) {
                    if (objects[1] != null) {
                        */
/*if (objects[1].getClass().getName().equals("java.lang.Double")) {
                            totalNum = ((Double) objects[1]).intValue();
                        } else {*//*

                        totalNum = objects[1].toString();
//                        }
                    }
                    break;
                }
            } else {
                if (objects[1] == null) {
                    objects[1] = "";
                }
                if (objects[0].toString().equals(xGroupTypeEntity.getName()) && objects[1].toString().equals(yGroupTypeEntity.getName())) {
                    if (objects[2] != null) {
                        */
/*if (objects[2].getClass().getName().equals("java.lang.Double")) {
                            totalNum = ((Double) objects[2]).intValue();
                        } else {*//*

                        totalNum = objects[2].toString();
//                        }
                    }
                    break;
                }
            }

        }

        return totalNum;
    }
*/

/*
    */
/*饼状图*//*

    public StringBuilder generatePieChartJsonData(Do tempDo, DoQuery doQuery, List<GroupType> groupTypeList, List<Object[]> taskList) {
        StringBuilder stringBuilder = new StringBuilder();

        stringBuilder.append("{");
        stringBuilder.append("\"title\":\"").append(tempDo.getLabel()).append("\"");
        stringBuilder.append(",");
        stringBuilder.append("\"data\":");
        stringBuilder.append("[");

        stringBuilder.append("{");
        stringBuilder.append("\"type\":\"").append(tempDo.getResult()).append("\"");
        stringBuilder.append(",");
        stringBuilder.append("\"name\":\"").append(doQuery.getLabel()).append("\"");
        stringBuilder.append(",");
        stringBuilder.append("\"data\":[");
        for (Object[] objects : taskList) {
            String tempValue = "";
            if (objects[0] != null) {
                for (GroupTypeEntity xGroupTypeEntity : groupTypeList.get(0).getGroupTypeEntityList()) {
                    if (xGroupTypeEntity.getName().equals(objects[0].toString())) {
                        tempValue = xGroupTypeEntity.getValue();
                        break;
                    }
                }
            } else {
                tempValue = "未定义";
            }

            stringBuilder.append("[");
            stringBuilder.append("\"").append(tempValue).append("(").append(objects[1]).append(")").append("\",");
            stringBuilder.append("").append(objects[1]).append("");
            stringBuilder.append("],");
        }

        stringBuilder.deleteCharAt(stringBuilder.length() - 1);
        stringBuilder.append("]");
        stringBuilder.append("}");
        stringBuilder.append("]");
        stringBuilder.append("}");

        return stringBuilder;
    }

    */
/*其他图表（非饼状图）*//*

    public StringBuilder generateChartJsonData(Do tempDo, DoQuery doQuery, List<GroupType> groupTypeList, List<Object[]> taskList) {
        StringBuilder stringBuilder = new StringBuilder();

        stringBuilder.append("{");
        stringBuilder.append("\"type\":\"").append(tempDo.getResult().split("_")[1]).append("\"");
        stringBuilder.append(",");
        stringBuilder.append("\"title\":\"").append(tempDo.getLabel()).append("\"");
        stringBuilder.append(",");
        stringBuilder.append("\"xData\":");
        stringBuilder.append("[");
        for (GroupTypeEntity groupTypeEntity : groupTypeList.get(0).getGroupTypeEntityList()) {
            stringBuilder.append("\"").append(groupTypeEntity.getValue()).append("\"").append(",");
        }
        stringBuilder.deleteCharAt(stringBuilder.length() - 1);
        stringBuilder.append("]");
        stringBuilder.append(",");
        stringBuilder.append("\"yData\":\"\",");
        stringBuilder.append("\"data\":");
        stringBuilder.append("[");
        for (GroupTypeEntity yGroupTypeEntity : groupTypeList.get(1).getGroupTypeEntityList()) {
            stringBuilder.append("{");
            stringBuilder.append("\"name\":\"").append(yGroupTypeEntity.getValue()).append("\",");
            stringBuilder.append("\"data\":[");
            for (GroupTypeEntity xGroupTypeEntity : groupTypeList.get(0).getGroupTypeEntityList()) {
                String total = getTotal(yGroupTypeEntity, xGroupTypeEntity, taskList);
                stringBuilder.append(total).append(",");
            }
            stringBuilder.deleteCharAt(stringBuilder.length() - 1);
            stringBuilder.append("]");
            stringBuilder.append("},");
        }
        stringBuilder.deleteCharAt(stringBuilder.length() - 1);
        stringBuilder.append("]");
        stringBuilder.append("}");

        return stringBuilder;
    }
*/



/*

    */
/*report   获取X轴和Y轴的值*//*

    public List<GroupType> generateGroupTypeList(List<Groupby> groupbyList, List<QueryCondition> queryConditionList, String tempConditions) throws Exception {
        List<GroupType> groupTypeList = new ArrayList<>();

        for (Groupby groupBy : groupbyList) {
            GroupType groupType = new GroupType();
            groupType.setName(groupBy.getName());

            List<GroupTypeEntity> groupTypeEntityList = new ArrayList<>();
            */
/*GroupTypeEntity tempGroupTypeEntity = new GroupTypeEntity();
            tempGroupTypeEntity.setName("未定义");
            tempGroupTypeEntity.setValue("未定义");
            groupTypeEntityList.add(tempGroupTypeEntity);*//*


            if (groupBy.getGtype().equals("teach_area")) {
*/
/*                List<CityShotType> cityShotTypeList = new ArrayList<>();
//                teachAreaList.add(myTeachArea);
                // cityList.addAll(myCity.getAllChildrenCityList());
                for (CityShotType cityShotType : cityShotTypeList) {
                    GroupTypeEntity groupTypeEntity = new GroupTypeEntity();
                    groupTypeEntity.setName(cityShotType.getId());
                    groupTypeEntity.setValue(cityShotType.getName());
                    groupTypeEntityList.add(groupTypeEntity);*//*

                }
            } else if (groupBy.getGtype().equals("dictionary")) {
                List<DictionaryData> dictionaryDataList = dictionaryDataManager.getDictionaryDataList(groupBy.getKey());
                for (DictionaryData dictionaryData : dictionaryDataList) {
                    GroupTypeEntity groupTypeEntity = new GroupTypeEntity();
                    groupTypeEntity.setName(dictionaryData.getId());
                    groupTypeEntity.setValue(dictionaryData.getData());
                    groupTypeEntityList.add(groupTypeEntity);
                }
            } else if (groupBy.getGtype().equals("sub")) {
                for (Object object : (List<Object>) list(groupBy.getKey(), null)) {
                    GroupTypeEntity groupTypeEntity = new GroupTypeEntity();
                    groupTypeEntity.setName(ReflectUtil.invokeMethod(object, "getId", null, null).toString());
                    groupTypeEntity.setValue(ReflectUtil.invokeMethod(object, "getName", null, null).toString());
                    if (groupBy.getExtendName() != null && !groupBy.getExtendName().equals("")) {
                        groupTypeEntity.setExtendName(SystemValueUtil.generateTempObjectValue(object, groupBy.getExtendName().split("\\.")).toString());
                    }
                    groupTypeEntityList.add(groupTypeEntity);
                }
            }*/
/* else if (groupBy.getType().equals("USER")) {
                for (Object object : (List<Object>) list(groupBy.getValue(), null)) {
                    GroupTypeEntity groupTypeEntity = new GroupTypeEntity();
                    groupTypeEntity.setName(ReflectUtil.invokeMethod(object, "getId", null, null).toString());
                    groupTypeEntity.setValue(ReflectUtil.invokeMethod(object, "getName", null, null).toString());
                    groupTypeEntityList.add(groupTypeEntity);
                }
            }*//*
 else if (groupBy.getGtype().startsWith("date_")) {
                List<Date> strList = new ArrayList<>();
                for (QueryCondition queryCondition : queryConditionList) {
                    if (queryCondition.getInputType().equals("date")) {
                        strList.add((Date) convertPropertyValue(queryCondition, tempConditions, queryCondition.getOperation()));
                    }
                }
                if (strList.size() == 0) {
                    try {
                        throw new Exception("查询条件中需定义按时间查找");
                    } catch (Exception e) {
                        e.printStackTrace();  //To change body of catch statement use File | Settings | File Templates.
                    }
                }


                List<String> stringList = DateUtil.getDateList(strList.get(0), strList.get(1), groupBy.getGtype());

                */
/*2014.02.25新增    处理报表统计时候   按天统计跨度31天 ，  按月统计跨度12个月*//*

                if (groupBy.getGtype().equals("date_day")) {
                    if (stringList.size() > 31) throw new Exception("按天统计数据， 天数不要超过31天");
                } else {
                    if (stringList.size() > 12) throw new Exception("按月统计数据， 月数不要超过12个月");
                }
                for (String str : stringList) {
                    GroupTypeEntity groupTypeEntity = new GroupTypeEntity();
                    groupTypeEntity.setName(str);
                    if (groupBy.getGtype().equals("date_day")) {
                        str = str.substring(5, str.length());
                    }
                    groupTypeEntity.setValue(str);
                    groupTypeEntityList.add(groupTypeEntity);
                }
            } else {

                List<StatusTypeItem> statusTypeItemList = moduleManager.listStatusTypeItem(groupBy.getKey());
                for (StatusTypeItem statusTypeItem : statusTypeItemList) {
                    GroupTypeEntity groupTypeEntity = new GroupTypeEntity();
                    groupTypeEntity.setName(statusTypeItem.getValue());
                    groupTypeEntity.setValue(statusTypeItem.getLabel());
                    groupTypeEntityList.add(groupTypeEntity);
                }

                */
/*String[] propertyValues = groupBy.getValue().split(";");
                for (String propertyValue:propertyValues) {
                    String[] tempValue = propertyValue.split(",");
                    GroupTypeEntity groupTypeEntity = new GroupTypeEntity();
                    groupTypeEntity.setName(tempValue[0]);
                    groupTypeEntity.setValue(tempValue[1]);
                    groupTypeEntityList.add(groupTypeEntity);
                }*//*

            }

//            List<GroupTypeEntity> tempGroupTypeEntityList = new ArrayList<>();

            if (!groupBy.getGtype().startsWith("date_")) {
                GroupTypeEntity tempGroupTypeEntity = new GroupTypeEntity();
                tempGroupTypeEntity.setName("未定义");
                tempGroupTypeEntity.setValue("未定义");
                groupTypeEntityList.add(tempGroupTypeEntity);
            }

            groupType.setGroupTypeEntityList(groupTypeEntityList);
            groupTypeList.add(groupType);
        }

        return groupTypeList;
    }
*/

/*

    */
/*判断x轴，和y轴之间是否有从属关系 。 比如说 x轴course是y轴clazz的一个子表*//*

    public boolean isGorun(GroupTypeEntity xGroupTypeEntity, GroupTypeEntity yGroupTypeEntity) {

        boolean flag = false;
        if (xGroupTypeEntity.getExtendName() != null && !xGroupTypeEntity.getExtendName().equals("")) {
            if (xGroupTypeEntity.getExtendName().equals(yGroupTypeEntity.getName())) {
                flag = true;
            }
        } else {
            flag = true;
        }

        return flag;
    }
*/



/*
    private String generateDataReportGroupValue(Object object, String name) throws Exception {
        String strValue = "";

        Object tempStrValue = SystemValueUtil.generateTempObjectValue(object, name.split("\\."));
        if (tempStrValue == null) {
            strValue = "未定义";
        } else {
            strValue = tempStrValue.toString();
        }

        return strValue;
    }
*/


/*
    *//*矩阵报表   生成x轴和y轴对应的value*//*
    private LinkedList<String> generateTotalCount(Integer group, Integer length, LinkedHashMap<String, LinkedList<String>> tempMap) {
        LinkedList<String> stringList = new LinkedList<>();

        Set<Map.Entry<String, LinkedList<String>>> set = tempMap.entrySet();
        for (int i = 0; i < length; i++) {
            BigDecimal totalCount = new BigDecimal(0);
            Integer tempGroup = 0;
            for (Iterator<Map.Entry<String, LinkedList<String>>> it = set.iterator(); it.hasNext(); ) {

                Map.Entry<String, LinkedList<String>> entry = (Map.Entry<String, LinkedList<String>>) it.next();
                tempGroup++;
                if (group == 2 && tempGroup == 1) {
                    continue;
                }
                totalCount = totalCount.add(new BigDecimal(entry.getValue().get(i)));

            }
            stringList.add(totalCount.toString());
        }

        return stringList;
    }*/


}
