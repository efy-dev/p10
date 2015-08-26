package com.efeiyi.ec.system.organization.service.impl;

import com.efeiyi.ec.organization.model.BigUser;
import com.efeiyi.ec.organization.model.MyUser;
import com.efeiyi.ec.system.organization.OrganizationConst;
import com.efeiyi.ec.system.organization.dao.UserDao;
import com.efeiyi.ec.system.organization.service.SignManager;
import com.efeiyi.ec.system.organization.service.UserManager;
import com.efeiyi.ec.tenant.model.EnterpriseTenant;
import com.efeiyi.ec.tenant.model.PersonalTenant;
import com.efeiyi.ec.tenant.model.PrivateTenant;
import com.efeiyi.ec.tenant.model.Tenant;
import com.ming800.core.base.dao.XdoDao;
import com.ming800.core.does.model.PageInfo;
import com.ming800.core.taglib.PageEntity;
import com.ming800.core.util.StringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
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
    public  void  tenantRegister(Tenant tenant,String tenantType){

        tenant.setPassword(StringUtil.encodePassword(tenant.getPassword(), "SHA"));
        baseDao.saveOrUpdateObject(Tenant.class.getName(), tenant);
        if(tenantType.equals("11")){
            EnterpriseTenant enterpriseTenant = new EnterpriseTenant();
            enterpriseTenant.setPassword(tenant.getPassword());
            enterpriseTenant.setUsername(tenant.getUsername());
            enterpriseTenant.setStatus("1");
            enterpriseTenant.setEnabled(true);
            enterpriseTenant.setAccountExpired(false);
            enterpriseTenant.setAccountLocked(false);
            enterpriseTenant.setCredentialsExpired(false);
            enterpriseTenant.setTenantType("11");
            baseDao.saveOrUpdateObject(EnterpriseTenant.class.getName(), enterpriseTenant);
        }
        if(tenantType.equals("12")){
            PrivateTenant privateTenant = new PrivateTenant();
            privateTenant.setPassword(tenant.getPassword());
            privateTenant.setUsername(tenant.getUsername());
            privateTenant.setStatus("1");
            privateTenant.setEnabled(true);
            privateTenant.setAccountExpired(false);
            privateTenant.setAccountLocked(false);
            privateTenant.setCredentialsExpired(false);
            privateTenant.setTenantType("12");
            baseDao.saveOrUpdateObject(PrivateTenant.class.getName(), privateTenant);
        }
        if(tenantType.equals("13")){
            PersonalTenant personalTenant = new  PersonalTenant();
            personalTenant.setPassword(tenant.getPassword());
            personalTenant.setUsername(tenant.getUsername());
            personalTenant.setStatus("1");
            personalTenant.setEnabled(true);
            personalTenant.setAccountExpired(false);
            personalTenant.setAccountLocked(false);
            personalTenant.setCredentialsExpired(false);
            personalTenant.setTenantType("13");
            baseDao.saveOrUpdateObject(PersonalTenant.class.getName(), personalTenant);
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
