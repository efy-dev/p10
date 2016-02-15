package com.efeiyi.ec.system.organization;


import com.efeiyi.ec.system.organization.util.AuthorizationUtil;
import com.efeiyi.ec.organization.model.MyUser;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.p.PConst;
import com.ming800.core.p.model.SystemLog;
import com.ming800.core.util.HttpUtil;
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
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

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
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
//        MyUser bigUser = AuthorizationUtil.getMyUser();
//        if (request.getParameter("j_password") != null && !request.getParameter("j_password").equals("ming20022009")) {
//            SystemLog systemLog = new SystemLog();
//            WebAuthenticationDetails webAuthenticationDetails = (WebAuthenticationDetails) com.efeiyi.ec.website.base.authentication.getDetails();
//            String ip = webAuthenticationDetails.getRemoteAddress();
//            systemLog.setIp(ip);
//            systemLog.setContent("登录成功");
//            systemLog.setTheDateTime(new Date());
////                systemLog.setTeachArea(bigUser.getTeachArea());
//
//            systemLog.setTheType(PConst.SYSTEM_LOG_THE_TYPE_LOGIN);
//            baseManager.saveOrUpdate(systemLog.getClass().getName(), systemLog);
//        }
//        bigUser.setLastLoginDatetime(new Date());
//        baseManager.saveOrUpdate(bigUser.getClass().getName(), bigUser);
        System.out.println("登录成功");
        MyUser user = (MyUser)authentication.getPrincipal();
        try {
            user.setLastLoginDatetime(sdf.parse(sdf.format(new Date())));
            baseManager.saveOrUpdate(MyUser.class.getName(),user);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        SavedRequest savedRequest = new HttpSessionRequestCache().getRequest(request, response);
        if (savedRequest != null) {
            response.sendRedirect(savedRequest.getRedirectUrl());
        } else {

            if (request.getParameter("redirect") == null) {
                response.sendRedirect(request.getContextPath() + "/main.do");
            } else {
                response.sendRedirect(request.getContextPath() + request.getParameter("redirect"));
            }
        }
    }
}
