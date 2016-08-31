package com.efeiyi.ec.website.organization;

import com.efeiyi.ec.organization.model.MyUser;
import com.efeiyi.ec.website.base.util.AuthorizationUtil;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.p.PConst;
import com.ming800.core.p.model.SystemLog;
import com.ming800.core.util.CookieTool;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.authentication.WebAuthenticationDetails;
import org.springframework.security.web.savedrequest.HttpSessionRequestCache;
import org.springframework.security.web.savedrequest.SavedRequest;
import org.springframework.stereotype.Component;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 13-1-9
 * Time: 上午11:13
 * 处理 spring security 登录成功
 */
@Component
public class LoginSuccessHandler implements AuthenticationSuccessHandler {
    @Autowired
    BaseManager baseManager;

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication) throws IOException, ServletException {
        String result = "";
//        CookieTool.addCookie(response, "JSESSIONID", request.getRequestedSessionId(), 100000, "i.efeiyi.com");
//        CookieTool.addCookie(response, "JSESSIONID", request.getRequestedSessionId(), 100000, "mall.efeiyi.com");
//        CookieTool.addCookie(response, "JSESSIONID", request.getRequestedSessionId(), 100000, "www.efeiyi.com");
//        CookieTool.addCookie(response, "JSESSIONID", request.getRequestedSessionId(), 100000, "minglu.efeiyi.com");
        SavedRequest savedRequest = new HttpSessionRequestCache().getRequest(request, response);
        if (savedRequest != null) {
//            response.sendRedirect(savedRequest.getRedirectUrl());
            result = "{\"login\":\"true\",\"redirect\":\"" + savedRequest.getRedirectUrl() + "\"}";
            response.getWriter().println(result);
        } else {
//            response.sendRedirect(request.getContextPath() + "/main.do");
            result = "{\"login\":\"true\",\"redirect\":\"/\"}";
            response.getWriter().println(result);
        }

    }
}