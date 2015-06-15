package com.ming800.core.util;


/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 12-12-22
 * Time: 上午10:44
 * To change this template use File | Settings | File Templates.
 */
public class SystemIdUtil {


    public static String generateIdName() {
        StringBuilder realFileName = new StringBuilder();

        /*8*/
        realFileName.append(Long.toString(System.currentTimeMillis(), 36));

        /*4*/
        Double numIds = Math.random();
        String numIds3 = numIds.toString().substring(2, 8);
        realFileName.append(Integer.toString(Integer.parseInt(numIds3), 36));

        return realFileName.toString();
    }


}
