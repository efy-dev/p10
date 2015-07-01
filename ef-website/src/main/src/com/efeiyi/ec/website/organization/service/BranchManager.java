package com.efeiyi.ec.website.organization.service;

import com.efeiyi.ec.tenant.model.Tenant;
import com.efeiyi.ec.organization.model.User;

import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 12-11-16
 * Time: 下午5:03
 * To change this template use File | Settings | File Templates.
 */
public interface BranchManager {
    void saveOrUpdate(Tenant branch);

    Tenant getBranch(String branchId);

    Tenant getBranchByName(String name) throws Exception;

    List<Tenant> listBranch();


    User checkUsername(String username);

}
