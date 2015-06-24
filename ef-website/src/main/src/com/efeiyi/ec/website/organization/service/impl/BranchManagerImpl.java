package com.efeiyi.ec.website.organization.service.impl;

import com.efeiyi.ec.website.organization.OrganizationConst;
import com.efeiyi.ec.tenant.model.Tenant;
import com.efeiyi.ec.organization.model.User;
import com.efeiyi.ec.website.organization.service.BranchManager;
import com.ming800.core.base.dao.XdoDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 12-11-16
 * Time: 下午4:58
 * To change this template use File | Settings | File Templates.
 */
@Transactional
@Service
public class BranchManagerImpl implements BranchManager {

    @Autowired
    private XdoDao xdoDao;

    @Override
    public void saveOrUpdate(Tenant tenant) {
        xdoDao.saveOrUpdateObject(Tenant.class.getName(), tenant);
    }

    @Override
    public Tenant getBranch(String branchId) {
        return (Tenant) xdoDao.getObject(Tenant.class.getName(), branchId);
    }

    @Override
    public Tenant getBranchByName(String name) throws Exception {
        Tenant tenant = null;
        String queryStr = "from Tenant b where b.name = ? and b.theStatus =" + OrganizationConst.BRANCH_THE_STATUS_NORMAL;
        List<Tenant> tenantList = (List<Tenant>) xdoDao.getObjectList(queryStr, name);
        if (tenantList != null && tenantList.size() > 0) {
            if (tenantList.size() == 1) {
                tenant = tenantList.get(0);
            } else {
                throw new Exception("机构名冲突异常");
            }
        } else {
            //这里先暂时注释掉
            // throw new Exception("机构不存在");
        }
        return tenant;  //To change body of implemented methods use File | Settings | File Templates.
    }

    @Override
    public List<Tenant> listBranch() {
        String queryStr = "select b from Tenant b where b.theStatus = 6";
        return (List<Tenant>) xdoDao.getObjectList(queryStr);  //To change body of implemented methods use File | Settings | File Templates.
    }


    @Override
    public User checkUsername(String username) {
        String queryStr = "from User b where b.username = ? and b.theStatus!=0";          // and b.theStatus in (1,2,3)
        List<User> userList = (List<User>) xdoDao.getObjectList(queryStr, username);
        if (userList != null && userList.size() > 0) {
            return userList.get(0);
        } else {
            return null;
        }
    }
}
