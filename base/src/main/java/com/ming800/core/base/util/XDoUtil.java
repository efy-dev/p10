package com.ming800.core.base.util;

import com.ming800.core.base.dao.XdoDao;
import com.ming800.core.does.model.*;
import com.ming800.core.does.model.Field;
import com.ming800.core.does.service.QueryHandler;
import com.ming800.core.taglib.PageEntity;
import com.ming800.core.util.ApplicationContextUtil;
import com.ming800.core.util.DateUtil;

import javax.servlet.http.HttpServletRequest;
import java.lang.reflect.*;
import java.math.BigDecimal;
import java.util.*;

/**
 * Created by pgwt on 2015/7/7.
 * 提供XDo框架相关的工具类
 */
public class XDoUtil {


    /**
     * 解析请求参数中的分页信息，返回PageEntity对象
     *
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

    public static PageEntity getPageEntity(HttpServletRequest request, Integer psize) {
        String index = request.getParameter(PageEntity.PARAM_NAME_PAGEINDEX);
        String size = request.getParameter(PageEntity.PARAM_NAME_PAGERECORDS);
        PageEntity pageEntity = new PageEntity();
        //默认页数索引
        pageEntity.setIndex(1);
        //默认每页显示数量
        pageEntity.setSize(psize);
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
     *
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

        object = processSaveOrUpdateObject(tempDo, object, objectClass, request, type, xdoDao);

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


    public static Object processSaveOrUpdateTempObject(Do tempDo, Object object, Class objectClass, HashMap paramMap, String type, XdoDao xdoDao) throws Exception {

        object = processSaveOrUpdateObject(tempDo, object, objectClass, paramMap, type, xdoDao);

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

            //如果当前字段是id就跳过
            if (field.getName().equals("id")) {
                continue;
            }

            Object objectValue = null;
            //判断该属性不是简单类行
            if (field.getType().getName().startsWith("com.ming800") || field.getType().getName().startsWith("com.efeiyi.ec")) { //处理实体属性
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
                            content += field.getName() + ".id:" + tempObjectNameValue + " => " + objectNameValue == null ? "" : objectNameValue + "<br/>";
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
            object = processSaveOrUpdateObject(tempDo, object, objectClass.getSuperclass(), request, type, xdoDao);
        }

      /*  if (!content.equals("")) {
            saveOrUpdateOperationLog(tempDo, content.substring(0, content.length() - 1), "修改");
        }
*/
        return object;
    }


    public static Object processSaveOrUpdateObject(Do tempDo, Object object, Class objectClass, HashMap paramMap, String type, XdoDao xdoDao) throws Exception {
        java.lang.reflect.Field[] fields = objectClass.getDeclaredFields();
        String content = "";
        for (java.lang.reflect.Field field : fields) {
            if (!Modifier.isStatic(field.getModifiers())) {

                field.setAccessible(true);

                //如果当前字段是id就跳过
                if (field.getName().equals("id")) {
                    continue;
                }

                Object objectValue = null;
                //判断该属性不是简单类行
                if (field.getType().getName().startsWith("com.ming800") || field.getType().getName().startsWith("com.efeiyi.ec")) { //处理实体属性
                    Object fieldValue = paramMap.get(field.getName() + ".id");
                    if (fieldValue == null) {//异步请求时，使用property_id来发送关联实体的id
                        fieldValue = paramMap.get(field.getName() + "_id");
                    }
                    Class simpleName = Class.forName(field.getType().getName());
//                Object objectIdValue = null;
                    Object objectNameValue = null;
                    if (fieldValue != null && !fieldValue.equals("")) {
                        objectValue = xdoDao.getObject(Class.forName(field.getType().getName()).getName(), fieldValue.toString());
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
                                content += field.getName() + ".id:" + tempObjectNameValue + " => " + objectNameValue == null ? "" : objectNameValue + "<br/>";
                            }
                        } else {
                            continue;
                        }
                    }
                } else {                //
                    Object fieldValue = paramMap.get(field.getName());
                    if (fieldValue != null) {

                        if (field.getType().equals(String.class)) {
                            objectValue = SystemValueUtil.transformSpecialSymbol(fieldValue.toString());
                        } else if (field.getType().equals(Integer.class) && !fieldValue.equals("")) {
                            objectValue = Integer.parseInt(fieldValue.toString());
                        } else if (field.getType().equals(Date.class) && !fieldValue.equals("")) {
                            objectValue = DateUtil.parseAllDate(fieldValue.toString());
                        } else if (field.getType().equals(Float.class) && !fieldValue.equals("")) {
                            objectValue = Float.parseFloat(fieldValue.toString());
                        } else if (field.getType().equals(BigDecimal.class) && !fieldValue.equals("")) {
                            objectValue = new BigDecimal(fieldValue.toString());
                        } else if (field.getType().equals(Byte.class) && !fieldValue.equals("")) {
                            objectValue = Byte.parseByte(fieldValue.toString());
                        } else if (field.getType().equals(Boolean.class) && !fieldValue.equals("")) {
                            objectValue = Boolean.parseBoolean(fieldValue.toString());
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
        }

        /*如果tempObject1有父类，读取*/
        if (!objectClass.getSuperclass().getName().equals("java.lang.Object")) {
            object = processSaveOrUpdateObject(tempDo, object, objectClass.getSuperclass(), paramMap, type, xdoDao);
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


    public static Object fetchObjectByConditions(Object object, String conditions, XdoDao xdoDao) {

        if (conditions != null && !conditions.equals("")) {
            String[] tempConditions = conditions.split(";");
            for (String str : tempConditions) {
                String[] tempStr = str.split(":");
                if (tempStr[0].contains(".")) {
                    tempStr[0] = tempStr[0].split("\\.")[0];
                }
                java.lang.reflect.Field field = ReflectUtil.getDeclaredField(object, tempStr[0]);
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


    /*FORM 或者 VIEW的时候set指定的值*/
    public static void generateFetchObjectSetValue(Object object, Class objectClass, String fieldName, Object value) {

        try {
            java.lang.reflect.Field field = objectClass.getDeclaredField(fieldName);
            field.setAccessible(true);
            field.set(object, value);
        } catch (Exception e) {
            generateFetchObjectSetValue(object, objectClass.getSuperclass(), fieldName, value);
        }

    }


    public static XQuery executeXQueryHandler(XQuery xQuery, DoQuery doQuery) throws Exception {
        QueryHandler queryHandler = (QueryHandler) Class.forName(doQuery.getQueryExecute()).newInstance();

        return queryHandler.handle(xQuery);
    }
/*

    */
/*list页面    生成operation   操作链接*//*

    public static StringBuilder generateOperation(Object object, Page tempPage) throws Exception {
        StringBuilder stringBuilder = new StringBuilder();
        stringBuilder.append("\"操作\":\"");
        for (Command command : tempPage.getOperationList()) {
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
        stringBuilder.append("\",");
        return stringBuilder;
    }
*/

    /*转化url中${}中包含的对象属性*/
    public static String convertPageUrl(String pageUrl, Object object) throws Exception {

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


}
