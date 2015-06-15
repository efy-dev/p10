package com.ming800.core.util;

import javax.servlet.http.HttpServletRequest;

/**
 * Created by Administrator on 2015/1/28.
 */
public class HttpUtil {

    /**
     * 通过UserAgent信息来判断当前访问的设备是否是手机
     * @param userAgent
     * @return
     */
    public static boolean isPhone(String userAgent) {

        if (userAgent.indexOf("Mozilla/") != -1 && userAgent.indexOf("iPhone") != -1) {
            return true;
        } else if (userAgent.indexOf("Android") != -1 && userAgent.indexOf("Linux") != -1) {
            return true;
        } else {
            return false;
        }
    }

    public static boolean isPhone(HttpServletRequest request) {
        String serverName = request.getServerName();
        String cityName = serverName.split("\\.")[0];
        String userAgent = request.getHeader("User-Agent");
        if (userAgent.indexOf("Mozilla/") != -1 && userAgent.indexOf("iPhone") != -1) {
            return true;
        } else if (userAgent.indexOf("Android") != -1 && userAgent.indexOf("Linux") != -1) {
            return true;
        } else if(cityName.equals("m")){
            return true;
        }else {
            return false;
        }
    }

}
