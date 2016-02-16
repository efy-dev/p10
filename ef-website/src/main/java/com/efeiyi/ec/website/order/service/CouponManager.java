package com.efeiyi.ec.website.order.service;

import com.efeiyi.ec.purchase.model.Coupon;

/**
 * Created by Administrator on 2015/10/23 0023.
 */
public interface CouponManager {

    Coupon fetchCoupon(String id);

    Coupon confirmCoupon(String id);

    Coupon restoreCoupon(String id);

}
