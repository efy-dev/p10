package com.efeiyi.ec.gift.base.util;


import com.efeiyi.ec.organization.model.MyUser;
import com.efeiyi.ec.organization.model.Role;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;


/**
 * @author WuYingbo
 */
public class AuthorizationUtil {


    public static MyUser getMyUser() {
        SecurityContext securityContext = SecurityContextHolder.getContext();
        Authentication authentication = securityContext.getAuthentication();
        try {
            return (MyUser) authentication.getPrincipal();
        } catch (Exception e) {
            MyUser myUser = new MyUser();
            Role role = new Role();
            role.setBasicType("all");
            myUser.setRole(role);
            return myUser;
        }
    }

    public static String getCurrentSampleUsername() {
        String username = getMyUser().getUsername();
        return username.substring(0, 3) + "****" + username.substring(7, 11);
    }

    public static boolean isAuthenticated() {
        try {
            return getMyUser().getId() != null;
        } catch (Exception e) {
            return false;
        }
    }

}
