package com.efeiyi.ec.system.couponBatch.dao;

import com.efeiyi.ec.purchase.model.CouponBatch;

/**
 * Created by Administrator on 2016/1/4.
 */
public interface CouponBatchDao {
    void createCouponByBatch(CouponBatch couponBatch,int amount) throws Exception;
}
