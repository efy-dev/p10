package com.efeiyi.pal.system.organization.util;

import com.efeiyi.pal.organization.model.User;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;

public class AuthorizationUtil {

    public static User getUser() {
        SecurityContext securityContext = SecurityContextHolder.getContext();
        Authentication authentication = securityContext.getAuthentication();
        try {
            return (User) authentication.getPrincipal();
        } catch (Exception e) {
            User user = new User();
            return user;
        }
    }

}
