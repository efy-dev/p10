package com.efeiyi.ec.personal.master.utils;

import com.ming800.core.base.service.BaseManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.stereotype.Component;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 13-1-9
 * Time: 下午3:00
 * 处理spring security 登录失败
 */
@Component
public class LoginFailureHandler implements AuthenticationFailureHandler {
    @Autowired
    BaseManager baseManager;


    @Override
    public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response, AuthenticationException e) throws IOException, ServletException {
             response.sendRedirect(request.getContextPath() + "/login.do?error=true");
    }
}
