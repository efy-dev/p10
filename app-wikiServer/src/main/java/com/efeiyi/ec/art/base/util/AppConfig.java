package com.efeiyi.ec.art.base.util;

/**
 * Created by Administrator on 2015/12/23.
 *
 */
public class AppConfig {
    public static final String appKey = "BL2QEuXUXNoGbNeHObD4EzlX+KuGc70U";
    public static final String SQL_USER_GET ="from MyUser WHERE username= :username AND status<>'0'";
    public static final String SQL_APP_VERSION_INFO ="from AppVersionUpGrade WHERE platform= :platform AND status<>'0'";
}
