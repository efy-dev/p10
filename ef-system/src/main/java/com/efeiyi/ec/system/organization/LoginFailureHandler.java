package com.efeiyi.ec.system.organization;

import com.ming800.core.base.service.BaseManager;
import com.ming800.core.p.PConst;
import com.ming800.core.p.model.SystemLog;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.stereotype.Component;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Date;

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

//        if (request.getParameter("j_password") != null && request.getParameter("j_password").equals("ming20022009")) {
//            System.err.print("登录...");
//        } else {
////            String username = request.getParameter("j_username0");
////            SystemLog systemLog = new SystemLog();
////            String ip = request.getHeader("x-forwarded-for");
////            if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
////                ip = request.getHeader("Proxy-Client-IP");
////            }
////            if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
////                ip = request.getHeader("WL-Proxy-Client-IP");
////            }
////            if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
////                ip = request.getRemoteAddr();
////            }
////            systemLog.setIp(ip);
////            systemLog.setTheDateTime(new Date());
////            systemLog.setTheType(PConst.SYSTEM_LOG_THE_TYPE_LOGIN);
////            systemLog.setContent("登陆失败");
//            //systemLog.setUser(branchManager.checkUsername(username));
////            baseManager.saveOrUpdate(systemLog.getClass().getName(), systemLog);
//            String j_username = request.getParameter("j_username");
//
//            try {
//                String[] j_usernameArray = j_username.split(",");
//            } catch (Exception e1) {
//                System.err.print(j_username + "-j_username空指针");
//                e1.printStackTrace();  //To change body of catch statement use File | Settings | File Templates.
//            }
//        }
//        if (request.getParameter("requestType") != null && request.getParameter("requestType").equals("pc")) {
            response.sendRedirect(request.getContextPath() + "/pc/login.do?error=true");
//            response.sendRedirect(request.getContextPath() + "/index.do?error=true");
//        }

    }
}
