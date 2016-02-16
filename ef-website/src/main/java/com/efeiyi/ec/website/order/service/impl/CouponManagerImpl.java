package com.efeiyi.ec.website.order.service.impl;

import com.efeiyi.ec.purchase.model.Coupon;
import com.efeiyi.ec.website.order.service.CouponManager;
import com.ming800.core.base.service.BaseManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Created by Administrator on 2015/10/23 0023.
 */
@Service
public class CouponManagerImpl implements CouponManager {

    @Autowired
    private BaseManager baseManager;

    @Override
    public Coupon fetchCoupon(String id) {
        Coupon coupon = (Coupon) baseManager.getObject(Coupon.class.getName(), id);
        return coupon;
    }

    @Override
    public Coupon confirmCoupon(String id) {
        Coupon coupon = fetchCoupon(id);
        coupon.setStatus(Coupon.COUPON_STATUS_USED);
        baseManager.saveOrUpdate(Coupon.class.getName(), coupon);
        return coupon;
    }

    @Override
    public Coupon restoreCoupon(String id) {
        Coupon coupon = fetchCoupon(id);
        coupon.setStatus(Coupon.COUPON_STATUS_UNUSE);
        baseManager.saveOrUpdate(Coupon.class.getName(), coupon);
        return coupon;
    }

}
