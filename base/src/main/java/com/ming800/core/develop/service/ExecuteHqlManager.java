package com.ming800.core.develop.service;

/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 13-10-12
 * Time: 上午10:12
 * To change this template use File | Settings | File Templates.
 */
public interface ExecuteHqlManager {

    public String execute(String queryHql, String[] names) throws Exception;
}
