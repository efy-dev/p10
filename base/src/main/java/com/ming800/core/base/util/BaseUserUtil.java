package com.ming800.core.base.util;

import com.ming800.core.base.model.BaseUser;
import com.ming800.core.base.model.BaseTenant;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;

/**
 * Created by Administrator on 2015/7/16.
 */
public class BaseUserUtil {



    public static BaseUser getMyUser() {
        SecurityContext securityContext = SecurityContextHolder.getContext();
        Authentication authentication = securityContext.getAuthentication();
        try {
            return (BaseUser) authentication.getPrincipal();
        } catch (Exception e) {
            BaseUser myUser = new BaseUser();
            return myUser;
        }
    }

    public static BaseTenant getMyTenant(){
        return getMyUser().getBaseTenant();
    }


}
