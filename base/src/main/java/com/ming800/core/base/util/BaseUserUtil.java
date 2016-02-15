package com.ming800.core.base.util;

import com.ming800.core.base.model.BaseUser;
import com.ming800.core.base.model.BaseTenant;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;

import java.util.Objects;

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

//    public static BaseTenant getMyTenant(){
//        return getMyUser().getBaseTenant();
//    }


}
