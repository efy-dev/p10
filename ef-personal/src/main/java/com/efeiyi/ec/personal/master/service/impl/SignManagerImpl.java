package com.efeiyi.ec.personal.master.service.impl;

import com.efeiyi.ec.master.model.Master;
import com.efeiyi.ec.master.model.MasterUser;
import com.efeiyi.ec.organization.model.MyUser;
import com.efeiyi.ec.organization.model.Professional;
import com.efeiyi.ec.personal.master.dao.UserDao;
import com.efeiyi.ec.personal.master.service.SignManager;
import com.efeiyi.ec.tenant.model.BigTenant;
import com.efeiyi.ec.tenant.model.EnterpriseTenant;
import com.efeiyi.ec.tenant.model.PersonalTenant;
import com.efeiyi.ec.tenant.model.PrivateTenant;
import com.ming800.core.base.dao.XdoDao;
import com.ming800.core.util.StringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.LinkedHashMap;

/**
 * Created by IntelliJ IDEA.
 * User: ming
 * Date: 12-10-15
 * Time: 下午5:02
 * To change this template use File | Settings | File Templates.
 */

@Service
@Transactional
public class SignManagerImpl implements SignManager {
    @Autowired
    private XdoDao baseDao;

    @Autowired
    private UserDao userDao;
    ///**zhu商家注册
    @Override
    public  void  tenantRegister(Professional professional){
        MyUser user = new MyUser();
        Master master = new Master();
        master.setReview("1");
        MasterUser masterUser = new MasterUser();
        user.setPassword(StringUtil.encodePassword(professional.getPassword(), "SHA"));
        user.setStatus(1);
        user.setEnabled(true);
        user.setAccountExpired(false);
        user.setAccountLocked(false);
        user.setCredentialsExpired(false);
        user.setUsername(professional.getUsername());
        try {
            masterUser.setUser(user);
            masterUser.setMaster(master);
            masterUser.setStatus("1");
            baseDao.saveOrUpdateObject(Master.class.getName(),master);
            baseDao.saveOrUpdateObject(MyUser.class.getName(),user);
            baseDao.saveOrUpdateObject(MasterUser.class.getName(),masterUser);

        }catch (Exception e){
              e.printStackTrace();
        }


    }

    //验证用户唯一
    @Override
    public boolean checkUsername(String username){
        boolean flag = true;
            MyUser myUser = null;
            String queryStr = "SELECT u FROM MyUser u WHERE u.username=:username AND u.status != 0";
            LinkedHashMap<String, Object> queryParamMap = new LinkedHashMap<>();
            queryParamMap.put("username", username);
            myUser =  userDao.getUniqueMyUserByConditions(username, queryStr, queryParamMap);
            if(myUser == null){
                flag = false;
            }
       return  flag;
    }
}
