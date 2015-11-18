package com.efeiyi.ec.system.listener.controller;

import com.efeiyi.ec.group.model.Group;
import com.efeiyi.ec.group.model.Member;
import com.efeiyi.ec.organization.model.BigUser;
import com.efeiyi.ec.purchase.model.PurchaseOrder;
import com.efeiyi.ec.purchase.model.PurchaseOrderGroup;
import com.efeiyi.ec.system.organization.util.AuthorizationUtil;
import com.efeiyi.ec.system.purchaseOrder.service.SmsCheckManager;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.Do;
import com.ming800.core.does.model.XQuery;
import com.ming800.core.does.service.DoManager;
import com.ming800.core.p.PConst;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.math.BigDecimal;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

/**
 * Created by AC丶man on 2015/8/31.
 */

public class RoleListener implements HandlerInterceptor{
    @Autowired
    private DoManager doManager;
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        boolean  f = false;
        String qm = request.getParameter("qm");
        if(qm!=null&&!"".equals(qm)) {
            Do tempDo = doManager.getDoByQueryModel(qm.split("_")[0]);
            System.out.println(AuthorizationUtil.getUser().getRole().getName());
            if (tempDo.getAccess().indexOf(AuthorizationUtil.getUser().getRole().getName()) == -1) {
                response.sendRedirect("/role.jsp");
            } else {
                f =  true;
            }
        }
       return  f;
    }

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {

    }

    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {

    }
}
