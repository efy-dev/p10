package com.efeiyi.ec.system.couponBatch.controller;

import com.efeiyi.ec.purchase.model.Coupon;
import com.efeiyi.ec.purchase.model.CouponBatch;
import com.ming800.core.base.controller.BaseController;
import com.ming800.core.base.service.BaseManager;
import org.apache.commons.lang3.RandomStringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * Created by Administrator on 2015/8/13.
 */
@Controller
@RequestMapping("/couponBatch")
public class CouponBatchController extends BaseController {

    @Autowired
    private BaseManager baseManager;

    @RequestMapping("/createCoupon.do")
    @ResponseBody
    public String createCoupon(String id,int amount){
        Coupon coupon = null;
        CouponBatch couponBatch = (CouponBatch) super.baseManager.getObject("com.efeiyi.ec.purchase.model.CouponBatch",id);
        for (int i = 0;i < amount;i++){
            coupon = new Coupon();
            coupon.setStatus("0");
            coupon.setCouponBatch(couponBatch);
            String serial = RandomStringUtils.randomNumeric(10);
            coupon.setSerial(serial);
            baseManager.saveOrUpdate(Coupon.class.getName(),coupon);
        }

        couponBatch.setIsCreatedCoupon(2);
        baseManager.saveOrUpdate(CouponBatch.class.getName(),couponBatch);
        return  id;
    }
}
