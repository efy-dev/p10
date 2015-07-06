package com.efeiyi.ec.website.orderaction.controller;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.util.ApplicationContextUtil;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.*;

/**
 * Created by Administrator on 2015/6/25.
 */
@RestController
@RequestMapping("/order")
public class OrderManageController {
    private BaseManager baseManager = (BaseManager) ApplicationContextUtil.getApplicationContext().getBean("baseManagerImpl");
    @RequestMapping(value = "/listOrder.do")
    public ModelAndView queryOrderList(ModelMap modelMap ,HttpServletRequest request ){
        String userId = request.getParameter("userId");
        List<Object> obj = new ArrayList<Object>();
        if(null==userId||"".equals(userId)){
            modelMap.put("code", "登录错误");
        }else{
            //业务处理
            String hql = "from com.efeiyi.ec.purchase.model.purchaseOrder where purchaseOrder.id = :userId";
            obj.add(userId);
            List purchaseorderlist= baseManager.listObject(hql, obj);
            modelMap.put("listOrder", purchaseorderlist);
        }
        return new ModelAndView("",modelMap);
    }
}
