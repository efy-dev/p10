package com.efeiyi.ec.consumer.coupon.controller;


import com.efeiyi.ec.consumer.organization.util.AuthorizationUtil;
import com.efeiyi.ec.organization.model.Consumer;
import com.efeiyi.ec.purchase.model.Coupon;
import com.efeiyi.ec.purchase.model.CouponBatch;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import com.ming800.core.p.service.AutoSerialManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * Created by Administrator on 2015/10/12.
 */
@Controller
public class CouponController {
    @Autowired
    BaseManager baseManager;

    @Autowired
    AutoSerialManager autoSerialManager;

    /**
     * 个人中心我的卡券列表
     *
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping({"/coupon/list"})
    public String listCoupon(HttpServletRequest request, Model model) throws Exception {
        String cf = request.getParameter("cf");
        if (AuthorizationUtil.getMyUser().getId() != null) {
            if ("1".equals(cf) || cf == null) {
                XQuery couponQuery = new XQuery("listCoupon_default", request);
                List<Object> couponList = baseManager.listObject(couponQuery);
                model.addAttribute("couponList", couponList);
                model.addAttribute("employ", "use");
            } else if ("2".equals(cf)) {
                XQuery couponQuery = new XQuery("listCoupon_default", request);
                List<Object> couponList = baseManager.listObject(couponQuery);
                model.addAttribute("couponList", couponList);
                model.addAttribute("employ", "unUse");

            } else if ("3".equals(cf)) {
                XQuery couponQuery = new XQuery("listCoupon_useful", request);
                List<Object> couponList = baseManager.listObject(couponQuery);
                model.addAttribute("couponList", couponList);
                model.addAttribute("employ", "ue");

            } else if ("4".equals(cf)) {
                XQuery couponQuery = new XQuery("listCoupon_allList", request);
                List<Object> couponList = baseManager.listObject(couponQuery);
                model.addAttribute("allCouponList", couponList);

            }
            return "/personalCoupon/couponList";
        } else {
            return "redirect:/sso.do";
        }


    }

    @RequestMapping("/remove/coupon.do")
    public String removeCoupon(HttpServletRequest request) {
        String cf = request.getParameter("cf");
        String couponId = request.getParameter("couponId");
        baseManager.remove(Coupon.class.getName(), couponId);
        return "redirect:/coupon/list?cf=" + cf;
    }

    @RequestMapping({"/coupon/exchangeCoupon.do"})
    @ResponseBody
    public Object exchangeCoupon(HttpServletRequest request) throws Exception {

        synchronized (this) {
            Coupon coupon = null;
            String cdkey = request.getParameter("cdkey");
            XQuery xQuery = new XQuery("listCouponBatch_bycdkey", request);
            xQuery.put("uniqueKey", cdkey);
            Date date = new Date();
            xQuery.put("startDate", date);
            xQuery.put("endDate", date);
            List<Object> couponBatchList = baseManager.listObject(xQuery);
            if (couponBatchList != null && couponBatchList.size() > 0) {
                CouponBatch currentCouponBatch = (CouponBatch) couponBatchList.get(0);
//            生成一张该批次的优惠券  这里使用的是通码
                coupon = new Coupon();
                coupon.setStatus("1");
                coupon.setSerial(autoSerialManager.nextSerial("orderSerial"));
                coupon.setCouponBatch(currentCouponBatch);
                Date currentDate = new Date();
                SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyyMMdd");
                String currentDateStr = simpleDateFormat.format(currentDate);
                coupon.setUniqueKey(currentDateStr + coupon.getSerial());
                Consumer consumer = (Consumer) baseManager.getObject(Consumer.class.getName(), AuthorizationUtil.getMyUser().getId());
                coupon.setConsumer(consumer);
                baseManager.saveOrUpdate(Coupon.class.getName(), coupon);
                SimpleDateFormat simpleDateFormat2 = new SimpleDateFormat("yyyy-MM-dd");
                coupon.setStartTimeL(simpleDateFormat2.format(coupon.getCouponBatch().getStartDate()));
                coupon.setEndTimeL(simpleDateFormat2.format(coupon.getCouponBatch().getEndDate()));
            } else {
                XQuery xQuery2 = new XQuery("listCoupon_bycdkey", request);
                xQuery2.setQueryHql(xQuery2.getQueryHql() + " and s.consumer.id is null ");
                xQuery2.updateHql();
                xQuery2.put("uniqueKey", cdkey);
                List result = baseManager.listObject(xQuery2);
                if (result != null && result.size() > 0) {
                    coupon = (Coupon) result.get(0);
                    if (coupon.getStatus().equals("2")) {
                        return "null";
                    }
                    Consumer consumer = (Consumer) baseManager.getObject(Consumer.class.getName(), AuthorizationUtil.getMyUser().getId());
                    coupon.setConsumer(consumer);
                    coupon.setBindTime(date);
                    baseManager.saveOrUpdate(Coupon.class.getName(), coupon);
                    SimpleDateFormat simpleDateFormat2 = new SimpleDateFormat("yyyy-MM-dd");
                    coupon.setStartTimeL(simpleDateFormat2.format(coupon.getCouponBatch().getStartDate()));
                    coupon.setEndTimeL(simpleDateFormat2.format(coupon.getCouponBatch().getEndDate()));
                }
            }


            if (coupon == null) {
                return "null";
            } else {
                return coupon;
            }
        }
    }

    @RequestMapping("/appExchange.do")
    public String exchange() {
        return "/personalCoupon/couponExchange";
    }

    @RequestMapping("/getAppCoupon.do")
    public String getAppCoupon(HttpServletRequest request, Model model) {
        String couponId = request.getParameter("couponId");
        Coupon coupon = (Coupon) baseManager.getObject(Coupon.class.getName(), couponId);
        model.addAttribute("coupon", coupon);
        return "/personalCoupon/getCoupon";

    }


}
