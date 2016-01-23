package com.efeiyi.ec.art.organization.service;

import com.efeiyi.ec.master.model.Master;
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
    void saveOrUpdate(Master branch);

    Master getBranch(String branchId);

    Master getBranchByName(String name) throws Exception;

    List<Master> listBranch();


    User checkUsername(String username);

}
