package com.efeiyi.ec.system.couponBatch.service;

import com.efeiyi.ec.purchase.model.CouponBatch;

/**
 * Created by Administrator on 2016/1/4.
 */
public interface CouponBatchManager {
    void createCouponByBatch(CouponBatch couponBatch,int amount) throws Exception;
}
