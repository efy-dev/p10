package com.efeiyi.ec.system.organization.service.impl;

import com.efeiyi.ec.organization.model.MyUser;
import com.efeiyi.ec.organization.model.Professional;
import com.efeiyi.ec.system.organization.dao.UserDao;
import com.efeiyi.ec.system.organization.service.SignManager;
import com.efeiyi.ec.tenant.model.*;
import com.ming800.core.base.dao.XdoDao;
import com.ming800.core.util.StringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.LinkedHashMap;
import java.util.List;

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
    public  void  tenantRegister(Professional professional,String tenantType){
        BigTenant tenant = null;
        professional.setPassword(StringUtil.encodePassword(professional.getPassword(), "SHA"));
        professional.setStatus("1");
        professional.setEnabled(true);
        professional.setAccountExpired(false);
        professional.setAccountLocked(false);
        professional.setCredentialsExpired(false);
        //  baseDao.saveOrUpdateObject(Tenant.class.getName(), tenant);
        try {

            if(tenantType.equals("11")){
                tenant = new EnterpriseTenant();
//            tenant.setPassword(tenant.getPassword());
//            tenant.setUsername(tenant.getUsername());
//            enterpriseTenant.setStatus("1");
//            enterpriseTenant.setEnabled(true);
//            enterpriseTenant.setAccountExpired(false);
//            enterpriseTenant.setAccountLocked(false);
//            enterpriseTenant.setCredentialsExpired(false);
                tenant.setTenantType("11");
                tenant.setReview("1");
                baseDao.saveOrUpdateObject(EnterpriseTenant.class.getName(), tenant);
            }
            if(tenantType.equals("12")){
                tenant = new PrivateTenant();
//            privateTenant.setPassword(tenant.getPassword());
//            privateTenant.setUsername(tenant.getUsername());
//            privateTenant.setStatus("1");
//            privateTenant.setEnabled(true);
//            privateTenant.setAccountExpired(false);
//            privateTenant.setAccountLocked(false);
//            privateTenant.setCredentialsExpired(false);
                tenant.setTenantType("12");
                tenant.setReview("1");
                baseDao.saveOrUpdateObject(PrivateTenant.class.getName(), tenant);
            }
            if(tenantType.equals("13")){
                tenant = new  PersonalTenant();
//            personalTenant.setPassword(tenant.getPassword());
//            personalTenant.setUsername(tenant.getUsername());
//            personalTenant.setStatus("1");
//            personalTenant.setEnabled(true);
//            personalTenant.setAccountExpired(false);
//            personalTenant.setAccountLocked(false);
//            personalTenant.setCredentialsExpired(false);
                tenant.setTenantType("13");
                tenant.setReview("1");
                baseDao.saveOrUpdateObject(PersonalTenant.class.getName(), tenant);
            }

            professional.setBigTenant(tenant);

            baseDao.saveOrUpdateObject(Professional.class.getName(),professional);

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
