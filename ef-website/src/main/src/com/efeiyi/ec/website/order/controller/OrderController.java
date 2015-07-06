package com.efeiyi.ec.website.order.controller;
import com.efeiyi.ec.purchase.model.PurchaseOrder;
import com.ming800.core.base.controller.BaseController;
import com.ming800.core.base.service.BaseManager;
import org.springframework.beans.factory.annotation.Autowired;
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
public class OrderController extends BaseController {
    @Autowired
    private BaseManager baseManager;
    @RequestMapping(value = "/listOrder.do")
    public ModelAndView queryOrderList(ModelMap modelMap ,HttpServletRequest request ){
        String userId = request.getParameter("userId");
        if(null==userId||"".equals(userId)){
            modelMap.put("code", "userId为空");
        }else{
            //业务处理
            String queryHql = "from PurchaseOrder s where s.id = ?";
            List<Object> obj = new ArrayList<Object>();
            obj.add(userId);
            List<PurchaseOrder> list = baseManager.listObject(queryHql,String.valueOf(obj));
           /* List<PurchaseOrder> list = baseManager.listObject(queryHql,queryParamMap);*/
            modelMap.put("listOrder", list);
        }
        return new ModelAndView("/ordertest",modelMap);
    }
}
