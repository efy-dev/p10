package com.efeiyi.ec.website.organization;

import org.springframework.security.web.authentication.AuthenticationFailureHandler;

import com.ming800.core.base.service.BaseManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.AuthenticationException;
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
        String loginErrorMessage = e.getMessage();
        if (loginErrorMessage.equals("Bad credentials")) {
            loginErrorMessage = "用户名或密码错误";
        }
        String result = "{\"login\":\"false\",\"message\":\"" + loginErrorMessage + "\"}";
        System.out.println("登录用户名 " + request.getParameter("username"));
        System.out.println("登录密码 " + request.getParameter("password"));
        System.out.println("====================================登录失败=============================================");
//        response.sendRedirect(request.getContextPath() + "/index.do?error=true");
        response.getWriter().println(result);
    }
}
