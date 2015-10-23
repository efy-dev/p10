package com.efeiyi.ec.website.order.controller;

import com.efeiyi.ec.organization.model.Consumer;
import com.efeiyi.ec.purchase.model.Cart;
import com.efeiyi.ec.purchase.model.Coupon;
import com.efeiyi.ec.purchase.model.CouponBatch;
import com.efeiyi.ec.purchase.model.PurchaseOrder;
import com.efeiyi.ec.website.organization.util.AuthorizationUtil;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import com.ming800.core.util.DateUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;

/**
 * Created by Administrator on 2015/9/14 0014.
 * 优惠券的部分包括领取优惠券和使用优惠券
 * 领取优惠卷则是列出所有可用优惠券，这里包括 1.全场通用的优惠券 2.店铺优惠券 3.单品优惠券 每个订单只能使用一张优惠券
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
    public List<Coupon> listCouponByOrder(HttpServletRequest request , Model model,@PathVariable String orderId) throws Exception{
        SimpleDateFormat df = new SimpleDateFormat("yyyy/MM/dd HH时mm分");
        PurchaseOrder purchaseOrder = (PurchaseOrder)baseManager.getObject(PurchaseOrder.class.getName(),orderId);
        XQuery couponQuery = new XQuery("listCoupon_byorder", request);
        couponQuery.put("couponBatch_priceLimit",purchaseOrder.getTotal().floatValue());
        List<Coupon> couponList = baseManager.listObject(couponQuery);
        for(Coupon coupon:couponList){
            coupon.getCouponBatch().setStartDateString(df.format(coupon.getCouponBatch().getStartDate()));
            coupon.getCouponBatch().setEndDateString(df.format(coupon.getCouponBatch().getEndDate()));
        }

        model.addAttribute("couponList",couponList);

        return couponList;

    }

    @RequestMapping({"/coupon/listCoupon"})
    @ResponseBody
    public List<Object> listCouponBypriceLimit(HttpServletRequest request , Model model) throws Exception{
            XQuery xQuery = new XQuery("listCart_default", request);
            List<Object> list = baseManager.listObject(xQuery);
            Cart cart = (Cart) list.get(0);
            XQuery couponQuery = new XQuery("listCoupon_byorder", request);
            couponQuery.put("couponBatch_priceLimit",cart.getTotalPrice().floatValue());
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

    @RequestMapping({"/coupon/sentEverybodyACoupon"})
    public String sentCoupon(HttpServletRequest request , Model model) throws Exception{
        String time = request.getParameter("time");
        String month = time.substring(0,2);
        String day = time.substring(2,4);
        String hour = time.substring(4,6);
        String min = time.substring(6,8);
        String limitTime1 = "2015-" + month + "-" + day + " " + hour + ":" + min + ":" + "00";
        Date limitTime = DateUtil.parseAllDate(limitTime1);
        Date date = new Date();

        String queryHql = "from "+Consumer.class.getName()+" t where t.createDatetime >= :limitTime and t.createDatetime <= :timeNow order by t.id desc";
        LinkedHashMap<String , Object> queryParamMap = new LinkedHashMap<>();
        queryParamMap.put("limitTime",limitTime);
        queryParamMap.put("timeNow",date);
        List<Consumer> list1 = baseManager.listObject(queryHql,queryParamMap);

        XQuery xQuery2 = new XQuery("listCouponBatch_default",request);
        List<CouponBatch> list2 = baseManager.listObject(xQuery2);
        List list = new ArrayList();
        for (Consumer consumer:list1){
            for(CouponBatch couponBatch:list2){
                Coupon coupon  = new Coupon();
                coupon.setConsumer(consumer);
                coupon.setCouponBatch(couponBatch);
                coupon.setStatus("1");

                baseManager.saveOrUpdate(Coupon.class.getName(), coupon);
                list.add(coupon);
            }
        }

        model.addAttribute("list",list);
        return "/purchaseOrder/couponMessage";

    }

}
