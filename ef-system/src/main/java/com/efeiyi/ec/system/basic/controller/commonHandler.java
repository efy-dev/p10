package com.efeiyi.ec.system.basic.controller;

import com.efeiyi.ec.purchase.model.Coupon;
import com.efeiyi.ec.purchase.model.CouponBatch;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.service.DoHandler;
import com.ming800.core.util.ApplicationContextUtil;
import org.springframework.ui.ModelMap;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * Created by Administrator on 2015/7/22.
 */
public class commonHandler implements DoHandler {

    private BaseManager baseManager = (BaseManager) ApplicationContextUtil.getApplicationContext().getBean("baseManagerImpl");

    @Override
    public ModelMap handle(ModelMap modelMap, HttpServletRequest request) throws Exception {

        modelMap.put("groupName" , request.getParameter("groupName"));
        modelMap.put("view" , request.getParameter("view"));

        String couponBatchId = request.getParameter("id");
        if(!("".equals(couponBatchId) || null == couponBatchId)){
            CouponBatch couponBatch = (CouponBatch) baseManager.getObject(CouponBatch.class.getName(),couponBatchId);
            List<Coupon> list = couponBatch.getCouponList();

            int lastCoupon = 0;
            for(int i = 0;i<list.size();i++){
                if("1".equals(list.get(i).getWhetherBind())){
                    lastCoupon++;
                }
            }

            modelMap.put("lastCoupon",lastCoupon);
        }

        return modelMap;
    }
}
