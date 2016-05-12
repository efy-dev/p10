package com.ming800.core.base.util;

import com.ming800.core.base.model.BaseMaster;
import com.ming800.core.base.model.BaseMasterUser;
import com.ming800.core.base.model.MethodCache;
import com.ming800.core.base.model.MethodSetting;
import com.ming800.core.util.DateUtil;

import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 12-12-22
 * Time: 上午10:44
 * To change this template use File | Settings | File Templates.
 */
public class SystemValueUtil {


    /**
     * type
     * <p/>
     * id
     * 获取对象id的值
     * name
     * 获取对象id的值和name的值
     * <p/>
     * 否则获取对象
     */
    public static Object getValue(String defaultValue, String type) {

        Object resultValue = null;

        if (defaultValue.startsWith("${")) {
            defaultValue = defaultValue.substring(defaultValue.indexOf("${") + 2, defaultValue.indexOf("}"));
            switch (defaultValue) {
                //@TODO 这里注释掉那么以后在配置文件中将不能使用MyUser的默认值了
                case "MY_USER":
                    if (type.equals("id")) {
                        resultValue = BaseUserUtil.getMyUser().getId();
                    }  else {
                        resultValue = BaseUserUtil.getMyUser();
                    }
                    break;

                case "MY_TENANT":
                    if (type.equals("id")) {
                        resultValue = BaseUserUtil.getMyUser().getBigTenant().getId();
                    } else {
                        resultValue = BaseUserUtil.getMyUser().getBigTenant();
                    }
                    break;
                case  "MASTER":
                    if (type.equals("id")) {
                        BaseMaster master = BaseUserUtil.findMaster();
                        resultValue = master.getId();
                    } else {
                        resultValue = BaseUserUtil.findMaster();
                    }
                    break;

             /*   case "MY_ROLE":
                    if (type.equals("id")) {
                        resultValue = AuthorizationUtil.getMyBranch().getId();
                    } else if (type.equals("name")) {
                        resultValue = AuthorizationUtil.getMyBranch().getId() + "_" + AuthorizationUtil.getMyBranch().getName();
                    } else {
                        resultValue = AuthorizationUtil.getMyBranch();
                    }
                    break;*/


                case "CURRENT_DATE":
                    if (type.equals("name")) {
                        resultValue = DateUtil.formatDate(new Date());
                    } else {
                        resultValue = new Date();
                    }
                    break;
                case "CURRENT_DATETIME":
                    if (type.equals("name")) {
                        resultValue = DateUtil.formatDateTime(new Date());
                    } else {
                        resultValue = new Date();
                    }
                    break;
                case "FIRST_DAY_OF_MONTH":
                    if (type.equals("name")) {
                        resultValue = DateUtil.getFirstDayOfCurrentMonth();
                    } else {
                        resultValue = DateUtil.parseDate(DateUtil.getFirstDayOfCurrentMonth());
                    }
                    break;
                default:
                    if (defaultValue.startsWith("NUM")) {
                        resultValue = Integer.parseInt(defaultValue.split("_")[1]);
                    } else if (defaultValue.startsWith("BOOLEAN")) {
                        resultValue = Boolean.valueOf(defaultValue.split("_")[1]);
                    } else if (defaultValue.startsWith("CURRENT_DATE")) {         //处理  CURRENT_DATE(7)
                        String days = defaultValue.substring(defaultValue.indexOf("(") + 1, defaultValue.indexOf(")"));
                        Integer dayType = 1;
                        if (days.startsWith("-")) {
                            dayType = 0;
                        }

                        Date tempDate = DateUtil.addOrSubDays(new Date(), Math.abs(Integer.parseInt(days)), dayType);
                        if (type.equals("name")) {
                            resultValue = DateUtil.formatDate(tempDate);
                        } else {
                            resultValue = tempDate;
                        }
                    } else {
                        resultValue = defaultValue;
                    }
                    break;

            }
        } else {
            resultValue = defaultValue;
        }

        return resultValue;
    }


    public static boolean isEqual(String fieldName, Object tempFieldValue, Object tempObject2) throws Exception {
        boolean flag = false;

        Field field = ReflectUtil.getDeclaredField(tempObject2, fieldName);
        field.setAccessible(true);

        Object tempFieldValue2 = field.get(tempObject2);
        if (tempFieldValue == null || tempFieldValue.equals(tempFieldValue2)) {
            flag = true;
        }

        return flag;
    }

    public static Object fetchFieldValue(Object object, MethodCache methodCache, String[] tags) throws Exception {

        String methodName = "";
        String[] subTags = null;
        if (tags.length > 0) {
            methodName = tags[0];
            if (tags.length > 1) {
                subTags = Arrays.copyOfRange(tags, 1, tags.length);
            }
        }

        MethodSetting methodSetting = methodCache.getMethodSetting(object.getClass(), methodName);

        Method method = methodSetting.getMethod();
//        method.setAccessible(true);
        Object objectValue = method.invoke(object);

        if (objectValue != null) {

            if (methodName.endsWith("List")) {
                StringBuilder sb = new StringBuilder();
                for (Object tempObject : (List<Object>) objectValue) {
                    Object tempObjectValue = fetchFieldValue(tempObject, methodCache, subTags);
                    if (tempObjectValue != null) {
                        sb.append(tempObjectValue.toString()).append(",");
                    }
                }

                objectValue = generateStr(sb.toString());
            } else if (tags.length > 1) {
                objectValue = fetchFieldValue(objectValue, methodCache, subTags);
            }

        }

        return objectValue;
    }


    public static Object generateTempObjectValue(Object object, String[] tags) throws Exception {

        if(object == null){
            return null;
        }
        StringBuilder methodName = new StringBuilder(32);
        String[] subTags = null;
        if (tags.length > 0) {
            methodName.append(tags[0]);
            if (tags.length > 1) {
                subTags = Arrays.copyOfRange(tags, 1, tags.length);
            }
        }

//        long currentDate1 = System.currentTimeMillis();
//        for (int i = 0; i < 1000000; i++) {
//            StringBuilder sb = new StringBuilder(32);
//            sb.setCharAt(0, Character.toUpperCase(sb.charAt(0)));   sb.insert(0, "get");
//            sb.append("get").append(methodName.substring(0, 1).toUpperCase()).append(methodName.substring(1, methodName.length()));
//        }
//        long currentDate2 = System.currentTimeMillis();

//        System.out.println(currentDate2 + "-----" + currentDate1 + "=====" + (currentDate2 - currentDate1));

        methodName.setCharAt(0, Character.toUpperCase(methodName.charAt(0)));
        methodName.insert(0, "get");

        String methodNameStr = methodName.toString();
        Object objectValue = ReflectUtil.invokeMethod(object, methodNameStr, null, null);
        if (objectValue != null) {
            if (methodNameStr.endsWith("List")) {
                StringBuilder sb = new StringBuilder();

                for (Object tempObject : (List<Object>) objectValue) {
                    Object tempObjectValue = generateTempObjectValue(tempObject, subTags);
                    if (tempObjectValue != null) {
                        sb.append(tempObjectValue.toString()).append(",");
                    }
                }

                objectValue = generateStr(sb.toString());
            } else if (tags.length > 1) {
                objectValue = generateTempObjectValue(objectValue, subTags);
            }

            if (methodNameStr.endsWith("Datetime")) {
                objectValue = DateUtil.formatDateMinute((Date) objectValue);
            } else if (methodNameStr.endsWith("Date")) {
                objectValue = DateUtil.formatDate((Date) objectValue);
            }
        }

        return objectValue;
    }

    public static String generateStr(String str) {
        if (str.length() > 0) {
            str = str.substring(0, str.length() - 1);
        }
        return str;
    }


    public static String generateSimpleName(Object object) {
        String tempSimpleName = object.getClass().getSimpleName();

        return tempSimpleName.substring(0, 1).toLowerCase() + tempSimpleName.substring(1, tempSimpleName.length());
    }

    public static String transformSpecialSymbol(String str) {
        if (str == null) return null;

        char[] strArray = str.toCharArray();

        for (int i = 0; i < strArray.length; i++) {
            if (strArray[i] == '\"') {
                strArray[i] = '\'';
            }
            if (strArray[i] == '\r') {
                strArray[i] = ' ';
            }
            if (strArray[i] == '\n') {
                strArray[i] = ' ';
            }

        }

//        str = String.valueOf(strArray);

//        str = str.replaceAll("\"", "\'").replaceAll("\r\n", "");

        return String.valueOf(strArray);
    }

/*    *//*如果 license中包含limitSystem:true  或者  当前日期大于指定日期  死循环*//*
    public static void stopSystem(String license) {

        Boolean flag = true;

        if (license.contains("limitSystem:true") || DateUtil.compareDate(new Date(), DateUtil.parseDate("2014-09-01")) >= 0) {
            flag = false;
        }

        if (!flag) {
            System.exit(0);
//            System.err.println("stop");
        }
    }*/

}
