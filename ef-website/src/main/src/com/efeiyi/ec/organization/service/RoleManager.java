package com.ming800.organization.service;

import com.ming800.organization.model.Role;

/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 13-8-6
 * Time: 上午11:18
 * To change this template use File | Settings | File Templates.
 */
public interface RoleManager {
    boolean processSetting(String name);

    public Role getRole(String basicType);
}
