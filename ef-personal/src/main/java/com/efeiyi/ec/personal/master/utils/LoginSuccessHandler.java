package com.efeiyi.ec.personal.master.utils;


import com.efeiyi.ec.master.model.Master;
import com.efeiyi.ec.master.model.MasterUser;
import com.efeiyi.ec.organization.model.MyUser;
import com.ming800.core.base.service.BaseManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.stereotype.Component;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;

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
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication) throws IOException, ServletException{
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
        System.out.println("登录成功");
        MyUser user = (MyUser)authentication.getPrincipal();
        try {
            user.setLastLoginDatetime(sdf.parse(sdf.format(new Date())));
            baseManager.saveOrUpdate(MyUser.class.getName(),user);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        String hql = "from MasterUser m where m.user.id =:userId and m.status = '1'";
        LinkedHashMap<String , Object> map = new LinkedHashMap<>();
        map.put("userId",user.getId());
        List<MasterUser> list = baseManager.listObject(hql,map);
        if (!list.isEmpty()){
            Master master = list.get(0).getMaster();
            if(master == null){
                response.sendRedirect(request.getContextPath() + "/login.do");
            }else {
                response.sendRedirect(request.getContextPath() + "/main.do" );
            }
        }
    }
}
