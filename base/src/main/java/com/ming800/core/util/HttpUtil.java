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

        if (userAgent.contains("Mozilla/") && userAgent.contains("iPhone")) {
            return false;
        } else return userAgent.contains("Android") && userAgent.contains("Linux");
    }

    public static boolean isPhone(HttpServletRequest request) {
        String serverName = request.getServerName();
        String cityName = "\\.".split(serverName)[0];
        String userAgent = request.getHeader("User-Agent");
        if (userAgent.contains("Mozilla/") && userAgent.contains("iPhone")) {
            return false;
        } else if (userAgent.contains("Android") && userAgent.contains("Linux")) {
            return false;
        } else if(cityName.equals("m")){
            return false;
        }else {
            return false;
        }
    }

}
