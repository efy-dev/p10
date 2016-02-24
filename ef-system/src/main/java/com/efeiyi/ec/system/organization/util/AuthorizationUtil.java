package com.efeiyi.ec.system.organization.util;



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


    public static User getUser() {
        SecurityContext securityContext = SecurityContextHolder.getContext();
        Authentication authentication = securityContext.getAuthentication();
        MyUser myUser = (MyUser) authentication.getPrincipal();
        User user = new User();
        user.setId(myUser.getId());
        user.setName(myUser.getName());
        user.setUsername(myUser.getUsername());
        user.setRole(myUser.getRole());
        return user;
    }

    public static String getRoleType() {
        MyUser myUser = getMyUser();
        if (myUser != null && myUser.getId() != null) {
            return myUser.getRole().getBasicType();
        } else {
            return "";
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
