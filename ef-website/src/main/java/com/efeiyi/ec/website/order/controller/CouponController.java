package com.efeiyi.ec.website.order.controller;

import com.efeiyi.ec.organization.model.MyUser;
import com.efeiyi.ec.purchase.model.Coupon;
import com.efeiyi.ec.purchase.model.PurchaseOrder;
import com.efeiyi.ec.website.organization.util.AuthorizationUtil;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.ws.rs.Path;
import java.util.List;

/**
 * Created by Administrator on 2015/9/14 0014.
 */
@Controller
public class CouponController {

    @Autowired
    private BaseManager baseManager;

    /**
     * 我的卡卷
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


    /**
     * 可用优惠券
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping({"/coupon/list/{orderId}"})
    @ResponseBody
    public List<Object> listCouponByOrder(HttpServletRequest request , Model model,@PathVariable String orderId) throws Exception{
        PurchaseOrder purchaseOrder = (PurchaseOrder)baseManager.getObject(PurchaseOrder.class.getName(),orderId);
        XQuery couponQuery = new XQuery("listCoupon_byorder", request);
        couponQuery.put("couponBatch_priceLimit",purchaseOrder.getTotal().floatValue());
        List<Object> couponList = baseManager.listObject(couponQuery);

        model.addAttribute("couponList",couponList);

        return couponList;

    }

    @RequestMapping({"/coupon/use.do"})
    @ResponseBody
    public boolean useCouponByOrder(HttpServletRequest request){
        String orderId = request.getParameter("orderId");
        String couponId = request.getParameter("couponId");
        PurchaseOrder purchaseOrder = (PurchaseOrder)baseManager.getObject(PurchaseOrder.class.getName(),orderId);
        Coupon coupon = (Coupon)baseManager.getObject(Coupon.class.getName(),couponId);

        purchaseOrder.setCoupon(coupon);

        baseManager.saveOrUpdate(PurchaseOrder.class.getName(),purchaseOrder);

        return true;

    }

}
