package com.efeiyi.ec.consumer.order.controller;


import com.efeiyi.ec.consumer.organization.util.AuthorizationUtil;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * Created by Administrator on 2015/10/12.
 */
@Controller
public class CouponController {
    @Autowired
    BaseManager baseManager;

    /**
     * 个人中心我的卡券列表
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping({"/coupon/list"})
    public String listCoupon(HttpServletRequest request , Model model) throws Exception{
        if(AuthorizationUtil.getMyUser().getId() != null){
            XQuery couponQuery = new XQuery("listCoupon_default", request);
            List<Object> couponList = baseManager.listObject(couponQuery);

            model.addAttribute("couponList",couponList);

            return "/purchaseOrder/couponList";
        }else {
            return "redirect:/sso.do";
        }


    }
}
