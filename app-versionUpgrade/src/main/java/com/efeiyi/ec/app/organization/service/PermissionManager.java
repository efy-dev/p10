package com.efeiyi.ec.app.organization.service;

/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 13-12-5
 * Time: 下午6:24
 * To change this template use File | Settings | File Templates.
 */
public interface PermissionManager {

    /**
     * 根据 access  判断当前用户是否用户该权限
     *
     * @param accesses 格式 entityName:operation,operation2   例如 ：student:va,vm;lead:va,vm
     * @param userId   该记录负责人的id  用于与当前用户的id做比较
     * @return
     */
    public Boolean processAccess(String accesses, String userId);

    /**
     * 根据 access  判断当前用户是否用户该权限
     *
     * @param roleType 权限 system, admin, user
     * @param roleType 权限 system, admin, user
     * @return
     */
    public Boolean processNewAccess(String accesses, String roleType);

    /**
     * 根据地址做权限解析获取entityName
     *
     * @param url 路径
     * @return
     */
    public String convertUrlToEntityName(String url) throws Exception;

    /**
     * 根据地址做权限解析获取operation
     *
     * @param url
     * @return
     */
    public String convertUrlToOperation(String url);
}
