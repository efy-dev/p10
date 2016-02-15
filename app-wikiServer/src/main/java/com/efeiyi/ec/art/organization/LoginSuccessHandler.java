package com.efeiyi.ec.art.organization;

import com.efeiyi.ec.organization.model.MyUser;
import com.efeiyi.ec.art.organization.util.AuthorizationUtil;
import com.ming800.core.base.service.BaseManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
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
        MyUser bigUser = AuthorizationUtil.getMyUser();
//        if (request.getParameter("j_password") != null && !request.getParameter("j_password").equals("123456")) {
//            SystemLog systemLog = new SystemLog();
//            WebAuthenticationDetails webAuthenticationDetails = (WebAuthenticationDetails) com.efeiyi.ec.website.base.authentication.getDetails();
//            String ip = webAuthenticationDetails.getRemoteAddress();
//            systemLog.setIp(ip);
//            systemLog.setContent("登录成功");
//            systemLog.setTheDateTime(new Date());
//            systemLog.setTheType(PConst.SYSTEM_LOG_THE_TYPE_LOGIN);
//            baseManager.saveOrUpdate(systemLog.getClass().getName(), systemLog);
//        }
//        bigUser.setLastLoginDatetime(new Date());
//        baseManager.saveOrUpdate(bigUser.getClass().getName(), bigUser);

        SavedRequest savedRequest = new HttpSessionRequestCache().getRequest(request, response);
        if (savedRequest != null) {
            response.sendRedirect(savedRequest.getRedirectUrl());
        } else {
            response.sendRedirect(request.getContextPath() + "/");
        }
    }
}
