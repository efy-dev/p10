package com.efeiyi.ec.personal.master.service;

import com.efeiyi.ec.organization.model.Professional;

/**
 * Created by IntelliJ IDEA.
 * User: ming
 * Date: 12-10-15
 * Time: 下午5:01
 * To change this template use File | Settings | File Templates.
 */
public interface SignManager {

    void  tenantRegister(Professional professional);
    boolean checkUsername(String username);

    
}
