package com.efeiyi.ec.art.organization.service.imp;

import com.efeiyi.ec.master.model.Master;
import com.efeiyi.ec.organization.model.User;

import com.efeiyi.ec.art.organization.OrganizationConst;
import com.efeiyi.ec.art.organization.service.BranchManager;
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
    public void saveOrUpdate(Master master) {
        xdoDao.saveOrUpdateObject(Master.class.getName(), master);
    }

    @Override
    public Master getBranch(String branchId) {
        return (Master) xdoDao.getObject(Master.class.getName(), branchId);
    }

    @Override
    public Master getBranchByName(String name) throws Exception {
        Master master = null;
        String queryStr = "from Master b where b.name = ? and b.theStatus =" + OrganizationConst.BRANCH_THE_STATUS_NORMAL;
        List<Master> masterList = (List<Master>) xdoDao.getObjectList(queryStr, name);
        if (masterList != null && masterList.size() > 0) {
            if (masterList.size() == 1) {
                master = masterList.get(0);
            } else {
                throw new Exception("机构名冲突异常");
            }
        } else {
            //这里先暂时注释掉
            // throw new Exception("机构不存在");
        }
        return master;  //To change body of implemented methods use File | Settings | File Templates.
    }

    @Override
    public List<Master> listBranch() {
        String queryStr = "select b from Master b where b.theStatus = 6";
        return (List<Master>) xdoDao.getObjectList(queryStr);  //To change body of implemented methods use File | Settings | File Templates.
    }


    @Override
    public User checkUsername(String username) {
        String queryStr = "from User b where b.username = ? and b.status!=0";          // and b.theStatus in (1,2,3)
        List<User> userList = (List<User>) xdoDao.getObjectList(queryStr, username);
        if (userList != null && userList.size() > 0) {
            return userList.get(0);
        } else {
            return null;
        }
    }
}
