package com.efeiyi.ec.website.organization.util;


import com.efeiyi.ec.organization.model.MyUser;
import com.efeiyi.ec.organization.model.Role;
import com.efeiyi.ec.organization.model.User;
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

    public static boolean isAuthenticated() {
        try {
            return getMyUser().getId()!=null;
        }catch (Exception e){
            return false;
        }
    }

}
