package com.efeiyi.ec.system.couponBatch.dao.hibernate;

import com.efeiyi.ec.purchase.model.Coupon;
import com.efeiyi.ec.purchase.model.CouponBatch;
import com.efeiyi.ec.system.couponBatch.dao.CouponBatchDao;
import com.ming800.core.base.dao.hibernate.XdoDaoSupport;
import com.ming800.core.p.service.AutoSerialManager;
import org.apache.log4j.Logger;
import org.hibernate.CacheMode;
import org.hibernate.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Random;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;

/**
 * Created by Administrator on 2016/1/4.
 *
 */
@Repository
public class CouponBatchDaoHibernate implements CouponBatchDao{
    private static Logger logger = Logger.getLogger(CouponBatchDaoHibernate.class);
    @Autowired
    private XdoDaoSupport xdoDaoSupport;
    @Autowired
    private AutoSerialManager autoSerialManager;

    private Lock lock = new ReentrantLock();
    /*
    * 通过优惠券批次批量生成二维码
    * */
    @Override
    public void createCouponByBatch(CouponBatch couponBatch,int amount) throws Exception {
        lock.lock();
        try{
            Session session = xdoDaoSupport.getSession();//使用同一个session
            session.setCacheMode(CacheMode.IGNORE);//关闭二级缓存
            Coupon coupon = null;
            int count = 0;
            List<Coupon> couponList = couponBatch.getCouponList();
            int createdCouponAmount = 0;
            if(null != couponList && couponList.size()>0){
                createdCouponAmount = couponList.size();
            }

            System.out.println("amount-createdCouponAmount: "+(amount-createdCouponAmount));
            logger.info("amount-createdCouponAmount: " + (amount - createdCouponAmount));
            logger.error("amount-createdCouponAmount: "+(amount-createdCouponAmount));
            for (int i = 0; i < amount-createdCouponAmount; i++) {
                coupon = new Coupon();
                coupon.setStatus("1");
                coupon.setCouponBatch(couponBatch);
                String serial = autoSerialManager.nextSerial("systemAutoSerial");
                coupon.setSerial(serial);
                coupon.setWhetherBind("1");


                StringBuffer randomValidateCode = new StringBuffer();
                for(int j = 0;j <3;j++){
                    Random random = new Random();
                    randomValidateCode.append(random.nextInt(10));
                }

                coupon.setUniqueKey(randomValidateCode+serial);
                session.saveOrUpdate(Coupon.class.getName(), coupon);

                count++;
                if(count == 500){
                    session.flush();
                    session.clear();
                    count = 0;
                }
                System.out.println("i--->"+i);
                logger.info("i--->"+i);
            }

            couponBatch.setIsCreatedCoupon(2);
            session.saveOrUpdate(CouponBatch.class.getName(), couponBatch);
            session.flush();
        }finally {
            lock.unlock();
        }

    }
}
