package com.ming800.core.base.util;

import com.ming800.core.base.dao.XdoDao;
import com.ming800.core.does.model.*;
import com.ming800.core.does.model.Field;
import com.ming800.core.taglib.PageEntity;
import com.ming800.core.util.DateUtil;

import javax.servlet.http.HttpServletRequest;
import java.lang.reflect.*;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;

/**
 * Created by pgwt on 2015/7/7.
 * 提供XDo框架相关的工具类
 */
public class XDoUtil {

    public static XQuery generateQueryString(String queryModel, DoQuery doQuery, String tempConditions) {
        StringBuilder sb = new StringBuilder(100);

        /*拼写 配置文件中的conditon*/
        XQuery tempXQuery = fetchXQueryByConditions(doQuery.getConditionList(), doQuery, tempConditions);
        sb.append(tempXQuery.getHql());

//        /*生成排序  order by 串*/
//        sb.append(fetchOrderStr(doQuery, tempConditions));

        StringBuilder queryStringBuilder = new StringBuilder(150);
        /*查询对象 select from */
        queryStringBuilder.append(fetchQueryHead(queryModel, doQuery));
        /*转换  第一个and  为 where*/
        queryStringBuilder.append(sb.toString().replaceFirst("and", "where"));

        XQuery xQuery = new XQuery();
        xQuery.setHql(queryStringBuilder.toString());
        xQuery.setQueryParamMap(tempXQuery.getQueryParamMap());
        return xQuery;
    }


    /*拼写  配置文件中的 condition*/
    public static XQuery fetchXQueryByConditions(List<QueryCondition> queryConditionList, DoQuery doQuery, String tempConditions) {

        /*andor 在这里获取，以防后面用到*/
        String queryExpress = "";
        String tempQueryExpress = doQuery.getQueryExpress();
        if (tempQueryExpress != null && !tempQueryExpress.equals("")) {
            queryExpress = doQuery.getQueryExpress();
        }

        StringBuilder queryStr = new StringBuilder(150);
        LinkedHashMap<String, Object> queryParamMap = new LinkedHashMap<>();

        String bigBranch = "";  //大数据


        for (QueryCondition queryCondition : queryConditionList) {
            String propertyName = queryCondition.getName();
            String tempOperator = queryCondition.getOperation();
            String operator = "";
            if ((queryCondition.getKey().equals("teachArea") || queryCondition.getKey().equals("singleTeachArea")) && bigBranch != null && bigBranch.equals("true")) {
                tempOperator = "likes";
                operator = "like";
            } else {
                operator = convertOperator(tempOperator);
            }
            //获得指定的参数的值
            Object value = convertPropertyValue(queryCondition, tempConditions, operator);

            StringBuilder tempQueryStr = new StringBuilder(20);
            if (tempQueryExpress == null || tempQueryExpress.equals("")) {
                tempQueryStr.append(" and ");
            }
            if (value != null && !value.equals("") && !value.toString().trim().equals("") && !value.toString().trim().equals("headquarters")) {

                if (tempOperator.equals("likes")) {
                    value = value.toString() + "%";
                } else if (tempOperator.equals("like")) {
                    value = "%" + value.toString() + "%";
                }

                if (value.equals("null")) {
                    value = null;
                }
                String tempPropertyName = propertyName;
                if (propertyName.contains(".")) {
                    tempPropertyName = propertyName.replace(".", "_");
                }

                if (!propertyName.startsWith("t.")) {
                    tempQueryStr.append("s.");
                }

                tempQueryStr.append(getPropertyName(propertyName));
                if (operator.equals("in")) {
                    tempQueryStr.append(" in (:")
                            .append(tempPropertyName)
                            .append(")");
                } else {
                    tempQueryStr.append(" ")
                            .append(operator)
                            .append(" :")
                            .append(tempPropertyName)
                            .append("");

                }
                queryParamMap.put(tempPropertyName, value);



            } else {
                tempQueryStr.append("1=1");
            }

            if (tempQueryExpress != null && !tempQueryExpress.equals("")) {
                queryExpress = queryExpress.replaceFirst(propertyName, tempQueryStr.toString());
            } else {
                queryStr.append(tempQueryStr.toString());
            }
        }

        StringBuilder sb = new StringBuilder();
        if (tempQueryExpress != null && !tempQueryExpress.equals("")) {
            sb.append(queryExpress);
        } else {
            sb.append(queryStr.toString());
        }

        XQuery xQuery = new XQuery();
        xQuery.setHql(sb.toString());
        xQuery.setQueryParamMap(queryParamMap);

        return xQuery;
    }


    /*拼写  orderby 语句*/
    public static String fetchOrderStr(DoQuery doQuery, String tempConditions) {

        /*页面 传递排序 参数*/
        XQuery orderXQuery = fetchQueryOrder(tempConditions);

        /*拼写  order by*/
        String orders = doQuery.getOrderBy();
        StringBuilder orderConditions = new StringBuilder();
        if (orderXQuery != null && orderXQuery.getFlag()) {
            orderConditions.append(" order by ").append(orderXQuery.getHql());
        } else if (orders != null && !orders.equals("")) {
            orderConditions.append(" order by ");
            for (String str : orders.split(";")) {
                String[] strTemp = str.split(":");
                orderConditions.append(" s.").append(strTemp[0]).append(" ").append(strTemp[1]).append(",");
            }
            orderConditions.deleteCharAt(orderConditions.length() - 1);
        }

        return orderConditions.toString();
    }


    /*页面  点击排序   效果*/
    //支持排序可控制
    public static XQuery fetchQueryOrder(String conditions) {
        Boolean flag = false;
        StringBuilder sb = new StringBuilder();

        if (conditions != null && !conditions.equals("")) {
            for (String condition : conditions.split(";")) {
                String[] conditionArray = condition.split(":");
                if (conditionArray[0].equals("asc") || conditionArray[0].equals("desc")) {
                    flag = true;
                    sb.append("s.").append(conditionArray[1]).append(" ").append(conditionArray[0]).append(",");
                }
            }
            if (sb.length() > 1) {
                sb.deleteCharAt(sb.length() - 1);
            }
        }

        XQuery xQuery = new XQuery();
        xQuery.setHql(sb.toString());
        xQuery.setFlag(flag);

        return xQuery;

    }


    /*查询 对象 select from*/
    public static String fetchQueryHead(String queryModel, DoQuery doQuery) {

        String tempQueryHql = doQuery.getQueryHql();

        StringBuilder sb = new StringBuilder();
        if (tempQueryHql != null && !tempQueryHql.equals("")) {
            sb.append("select distinct s from ");
        } else {
            sb.append("select s from ");
        }

        sb.append(queryModel);
        sb.append(" s ");
        if (tempQueryHql != null && !tempQueryHql.equals("")) {
            sb.append(doQuery.getQueryHql()).append(" ");
        }

        return sb.toString();

    }


    /**
     * 处理配置文件中   操作符号的问题   大于，小雨。。。
     */
    public static String convertOperator(String tempOperator) {
        String operator = tempOperator;

        if (tempOperator.equals("eq")) {
            operator = "=";
        } else if (tempOperator.equals("ne")) {
            operator = "!=";
        } else if (tempOperator.equals("ge")) {
            operator = ">=";
        } else if (tempOperator.equals("le")) {
            operator = "<=";
        } else if (tempOperator.equals("gt")) {
            operator = ">";
        } else if (tempOperator.equals("lt")) {
            operator = "<";
        } else if (tempOperator.equals("likes")) {
            operator = "like";
        }

        return operator;
    }


    /**
     * 处理配置文件中   同一个属性对应  开始时间，结束时间的问题
     */
    public static String getPropertyName(String tempPropertyName) {
        String propertyName = tempPropertyName;

        if (propertyName.endsWith("2")) {
            propertyName = propertyName.substring(0, propertyName.length() - 1);
        }

        return propertyName;
    }


    /**
     * 取值
     */
    public static Object convertPropertyValue(QueryCondition condition, String tempConditions, String tempOperator) {

        Object value = "";
        String propertyValue = condition.getValue();

        if (tempConditions != null && !tempConditions.equals("")) {
            for (String str : tempConditions.split(";")) {
                String[] tempStr = str.split(":");
                if (condition.getName().equals(tempStr[0].trim())) {
                    if (tempStr.length < 2) {
                        return null;
                    } else {
                        propertyValue = tempStr[1].trim();
                        if (propertyValue.split(",")[0].trim().equals("")) {//弹窗临时处理
                            return null;
                        }
                        break;
                    }
                }
            }
        }

        String tempValue = SystemValueUtil.getValue(propertyValue, "id").toString();

        if (tempValue.equals("")) {
            return null;
        }
        if (tempOperator.equals("in") || tempOperator.equals("not in")) {
            List<Object> list = new ArrayList<>();
            if (tempValue.contains("_")) {
                if (tempValue.equals("_")) {
                    return null;
                }
                tempValue = tempValue.split("_")[0].trim();
            }
            if (!tempValue.equals("")) {
                for (String tempStr : tempValue.split(",")) {
                    if (condition.getDataType() != null && condition.getDataType().equals("int")) {
                        list.add(Integer.parseInt(tempStr));
                    } else {
                        list.add(tempStr);
                    }
                }
                value = list;
            }

        } else if (condition.getInputType().equals("dialog_do") || condition.getInputType().equals("dialog_pop")) {
            if (tempValue.equals("_")) {
                value = null;
            } else {
                value = tempValue.split("_")[0].trim();
            }

        } else if (condition.getDataType() != null && condition.getDataType().equals("float")) {
            value = Float.parseFloat(tempValue);
        } else if (condition.getDataType() != null && condition.getDataType().equals("int")) {
            value = Integer.parseInt(tempValue);
        } else if (condition.getDataType() != null && condition.getDataType().equals("date")) {
            tempValue = SystemValueUtil.getValue(propertyValue, "name").toString();
            value = DateUtil.parseDate(tempValue);
        } else if (condition.getDataType() != null && condition.getDataType().equals("datetime")) {
            tempValue = SystemValueUtil.getValue(propertyValue, "name").toString();
            if (condition.getOperation().equals("ge")) {
                value = DateUtil.parseDateTime(tempValue + " 00:00:00");
            } else {
                value = DateUtil.parseDateTime(tempValue + " 23:59:59");
            }
        } else if (condition.getDataType() != null && condition.getDataType().equals("boolean")) {
            value = Boolean.valueOf(tempValue);
        } else if (condition.getDataType() != null && condition.getDataType().equals("bigDecimal")) {
            value = new BigDecimal(tempValue);
        } else {
            value = tempValue;
        }

        return value;
    }


    /**
     * 解析请求参数中的分页信息，返回PageEntity对象
     * @param request
     * @return
     */
    public static PageEntity getPageEntity(HttpServletRequest request) {
        String index = request.getParameter(PageEntity.PARAM_NAME_PAGEINDEX);
        String size = request.getParameter(PageEntity.PARAM_NAME_PAGERECORDS);
        PageEntity pageEntity = new PageEntity();
        //默认页数索引
        pageEntity.setIndex(1);
        //默认每页显示数量
        pageEntity.setSize(12);
        if (index != null && !"".equals(index)) {
            pageEntity.setIndex(Integer.parseInt(index));
        }
        if (size != null && !"".equals(size)) {
            pageEntity.setSize(Integer.parseInt(size));
        }
        return pageEntity;
    }


    /**
     * 获得设完值的对象
     * @param tempDo
     * @param object
     * @param objectClass
     * @param request
     * @param type
     * @param xdoDao
     * @return
     * @throws Exception
     */
    public static Object processSaveOrUpdateTempObject(Do tempDo, Object object, Class objectClass, HttpServletRequest request, String type, XdoDao xdoDao) throws Exception {

        object = processSaveOrUpdateObject(tempDo, object, objectClass, request, type,xdoDao);

        /*配置文件*/
        if (tempDo.getPageList() != null && tempDo.getPageList().size() > 0) {
            Page tempPage = tempDo.getPageList().get(0);
            for (PageField pageField : tempPage.getFieldList()) {
                String propertyValue = pageField.getValue();
                Object paramObject = SystemValueUtil.getValue(propertyValue, "object");
                if (pageField.getDataType().equals("int")) {
                    paramObject = Integer.parseInt(paramObject.toString());
                } else if (pageField.getDataType().equals("boolean")) {
                    paramObject = Boolean.valueOf(paramObject.toString());
                } else if (pageField.getDataType().equals("float")) {
                    paramObject = Float.valueOf(paramObject.toString());
                }

                if (ReflectUtil.invokeGetterMethod(object, pageField.getName()) == null) {
                    ReflectUtil.invokeSetterMethod(object, pageField.getName(), paramObject);
                }
            }
        }

        return object;  //To change body of implemented methods use File | Settings | File Templates.
    }

    /**
     * 创建或者更新对象
     */
    public static Object processSaveOrUpdateObject(Do tempDo, Object object, Class objectClass, HttpServletRequest request, String type, XdoDao xdoDao) throws Exception {
        java.lang.reflect.Field[] fields = objectClass.getDeclaredFields();
        String content = "";
        for (java.lang.reflect.Field field : fields) {
            field.setAccessible(true);

            if (field.getName().equals("id")) {
                continue;
            }
            Object objectValue = null;

            if (field.getType().getName().startsWith("com.ming800") || field.getType().getName().startsWith("com.yuepaila")) { //处理实体属性
                String fieldValue = request.getParameter(field.getName() + ".id");
                if (fieldValue == null) {//异步请求时，使用property_id来发送关联实体的id
                    fieldValue = request.getParameter(field.getName() + "_id");
                }
                Class simpleName = Class.forName(field.getType().getName());
//                Object objectIdValue = null;
                Object objectNameValue = null;
                if (fieldValue != null && !fieldValue.equals("")) {
                    objectValue = xdoDao.getObject(Class.forName(field.getType().getName()).getName(), fieldValue);
                    objectNameValue = fetchIdValueByClassType(simpleName, objectValue);//获取对象的指定字段值
                }

                if (type.equals("edit")) {

                    Object tempObjectValue = SystemValueUtil.generateTempObjectValue(object, field.getName().split("\\."));
                    Object tempObjectIdValue = SystemValueUtil.generateTempObjectValue(object, (field.getName() + ".id").split("\\."));
                    Object tempObjectNameValue = null;
                    if (tempObjectValue != null) {
                        tempObjectNameValue = fetchIdValueByClassType(simpleName, tempObjectValue);
                    }

                    if (fieldValue != null && (tempObjectIdValue == null || !tempObjectIdValue.toString().equals(fieldValue))) {
                        if (tempDo != null) {
                            content += field.getName() + ".id:" + tempObjectNameValue + " => " + objectNameValue==null?"":objectNameValue + "<br/>";
                        }
                    } else {
                        continue;
                    }
                }
            } else {                //
                String fieldValue = request.getParameter(field.getName());
                if (fieldValue != null) {

                    if (field.getType().equals(String.class)) {
                        objectValue = SystemValueUtil.transformSpecialSymbol(fieldValue);
                    } else if (field.getType().equals(Integer.class) && !fieldValue.equals("")) {
                        objectValue = Integer.parseInt(fieldValue);
                    } else if (field.getType().equals(Date.class) && !fieldValue.equals("")) {
                        objectValue = DateUtil.parseAllDate(fieldValue);
                    } else if (field.getType().equals(Float.class) && !fieldValue.equals("")) {
                        objectValue = Float.parseFloat(fieldValue);
                    } else if (field.getType().equals(BigDecimal.class) && !fieldValue.equals("")) {
                        objectValue = new BigDecimal(fieldValue);
                    } else if (field.getType().equals(Byte.class) && !fieldValue.equals("")) {
                        objectValue = Byte.parseByte(fieldValue);
                    } else if (field.getType().equals(Boolean.class) && !fieldValue.equals("")) {
                        objectValue = Boolean.parseBoolean(fieldValue);
                    }
                  /*   else {
                        objectValue = SystemValueUtil.transformSpecialSymbol(fieldValue);
//                        objectValue = fieldValue;
                    }*/
                }

                /*修改的时候判断属性值是否和上次相等，相等的话，不进行修改，进入下一次循环*/
                /*暂时不考虑   子表的情况*/
                if (type.equals("edit")) {
                    if (!SystemValueUtil.isEqual(field.getName(), objectValue, object)) {
                        /*continue;
                    } else {*/
                        if (tempDo != null) {
                            content += field.getName() + ":" + ReflectUtil.invokeGetterMethod(object, field.getName()) + " => " + fieldValue + "<br/>";
                        }
                    } else {
                        continue;
                    }
                }
            }

//            if (type.equals("new") && objectValue == null) {              //fieldValue注解  赋默认值
//                boolean hasAnnotation = field.isAnnotationPresent(FieldValue.class);
//                if (hasAnnotation) {
//                    FieldValue annotation = field.getAnnotation(FieldValue.class);
//                    String annotationValue = annotation.value();
//
//                    /*只有当新建的时候 转换默认的值   MY_USER...*/
//                    if (!annotationValue.equals("DICTIONARY")) {
//                        objectValue = SystemValueUtil.getValue(annotationValue, "object");
//                    }
//                }
//            }

            field.set(object, objectValue);
        }

        /*如果tempObject1有父类，读取*/
        if (!objectClass.getSuperclass().getName().equals("java.lang.Object")) {
            object = processSaveOrUpdateObject(tempDo, object, objectClass.getSuperclass(), request, type,xdoDao);
        }

      /*  if (!content.equals("")) {
            saveOrUpdateOperationLog(tempDo, content.substring(0, content.length() - 1), "修改");
        }
*/
        return object;
    }


    /**
     * 处理  操作日志   无法识别数据字典类型的数据
     */
    public static Object fetchIdValueByClassType(Class simpleName, Object object) throws Exception {

        Object objectValue = null;

        if (ReflectUtil.getDeclaredField(object, "name") != null) {
            objectValue = SystemValueUtil.generateTempObjectValue(object, ("name").split("\\."));
        } else if (ReflectUtil.getDeclaredField(object, "data") != null) {
            objectValue = SystemValueUtil.generateTempObjectValue(object, ("data").split("\\."));
        } else {
            objectValue = SystemValueUtil.generateTempObjectValue(object, ("id").split("\\."));
        }

        return objectValue;
    }

}
