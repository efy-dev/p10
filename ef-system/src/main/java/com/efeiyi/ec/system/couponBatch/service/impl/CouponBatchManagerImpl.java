package com.efeiyi.ec.system.couponBatch.service.impl;

import com.efeiyi.ec.purchase.model.CouponBatch;
import com.efeiyi.ec.system.couponBatch.dao.CouponBatchDao;
import com.efeiyi.ec.system.couponBatch.service.CouponBatchManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Created by Administrator on 2016/1/4.
 */
@Service
public class CouponBatchManagerImpl implements CouponBatchManager{

    @Autowired
    private CouponBatchDao couponBatchDao;

    @Override
    public void createCouponByBatch(CouponBatch couponBatch, int amount) throws Exception {
        couponBatchDao.createCouponByBatch(couponBatch,amount);
    }
}
