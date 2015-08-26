package com.efeiyi.ec.system.organization.service;

import com.efeiyi.ec.tenant.model.Tenant;

/**
 * Created by IntelliJ IDEA.
 * User: ming
 * Date: 12-10-15
 * Time: 下午5:01
 * To change this template use File | Settings | File Templates.
 */
public interface SignManager {

    void  tenantRegister(Tenant tenant,String tenantType);
    boolean checkUsername(String username);

    
}
