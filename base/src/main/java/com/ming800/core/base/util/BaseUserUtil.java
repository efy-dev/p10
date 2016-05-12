package com.ming800.core.base.util;

import com.ming800.core.base.model.BaseMaster;
import com.ming800.core.base.model.BaseMasterUser;
import com.ming800.core.base.model.BaseUser;
import com.ming800.core.base.model.BaseTenant;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.util.ApplicationContextUtil;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;

import java.util.LinkedHashMap;
import java.util.List;

/**
 * Created by Administrator on 2015/7/16.
 */
public class BaseUserUtil {



    public static BaseUser getMyUser() {
        SecurityContext securityContext = SecurityContextHolder.getContext();
        Authentication authentication = securityContext.getAuthentication();
        try {
//            Object object = com.efeiyi.ec.website.base.authentication.getPrincipal();
            return (BaseUser) authentication.getPrincipal();
        } catch (Exception e) {
            BaseUser myUser = new BaseUser(){
                @Override
                public String getId() {
                    return null;
                }
                public BaseTenant getBigTenant(){
                    return null;
                }
            };
            return myUser;
        }
    }


    private static BaseManager baseManager = (BaseManager) ApplicationContextUtil.getApplicationContext().getBean("baseManagerImpl");


    public static BaseMaster findMaster() {
        BaseMasterUser master = null;
        String hql = "from MasterUser m where m.user.id =:userId and m.status = '1'";
        LinkedHashMap<String, Object> map = new LinkedHashMap<>();
        map.put("userId", getMyUser().getId());
        List<BaseMasterUser> list = baseManager.listObject(hql, map);
        if(list!=null && list.size()>0) {

            return ((BaseMasterUser) list.get(0)).getMaster();
        }
       return  new BaseMaster() {
           @Override
           public String getId() {
               return null;
           }
       };
    }

//    public static BaseTenant getMyTenant(){
//        return getMyUser().getBaseTenant();
//    }


}
