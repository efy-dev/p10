package com.efeiyi.ec.system.zero.company.dao.hibernate;

import com.efeiyi.ec.purchase.model.PurchaseOrderGift;
import com.efeiyi.ec.purchase.model.PurchaseOrderProduct;
import com.efeiyi.ec.system.zero.company.dao.CompanyOrderBatchDao;
import com.efeiyi.ec.zero.company.model.CompanyOrderBatch;
import com.ming800.core.p.service.AutoSerialManager;
import org.apache.commons.lang.RandomStringUtils;
import org.hibernate.CacheMode;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Created by Administrator on 2015/12/15.
 * 企业礼品卡批次 Dao实现类
 */

@Repository
public class CompanyOrderBatchDaoHibernate implements CompanyOrderBatchDao {

    @Autowired
    @Qualifier("sessionFactory")
    private SessionFactory sessionFactory;

    @Autowired
    @Qualifier("autoSerialManagerImpl")
    private AutoSerialManager autoSerialManager;

    public Session getSession() {
        return sessionFactory.getCurrentSession();
    }

    @Override
    public void buildOrderGiftSetByCompanyOrderBatch(CompanyOrderBatch companyOrderBatch) throws Exception {
//        Session session = getSession();//使用同一个session
//        session.setCacheMode(CacheMode.IGNORE);//关闭与二级缓存的交互
//        Integer num = companyOrderBatch.getAmount();
//        int count = 0;
////        long begin = System.currentTimeMillis();
//        for (int i = 1; i <= num;) {
//            String code = RandomStringUtils.randomNumeric(17);
//            code = Long.toString(Long.parseLong(code), 36);
//            if (code.length() != 11) {
//                continue;
//            }
//            i++;
//            String serial = autoSerialManager.nextSerial("orderGift");
//            PurchaseOrderGift orderGift = new PurchaseOrderGift();
//            PurchaseOrderProduct purchaseOrderProduct = new PurchaseOrderProduct();
//            List<PurchaseOrderProduct> purchaseOrderProductList = new ArrayList<>();
//            orderGift.setSerial(serial);
//            orderGift.setShowGiftNameStatus("1");
//            orderGift.setShowGiftPriceStatus("1");
//            orderGift.setGiftMessage(companyOrderBatch.getMessage());
//            orderGift.setGiftGaverName(companyOrderBatch.getCompanyName());
//            orderGift.setCreateDatetime(new Date());
//            session.saveOrUpdate(orderGift);
//            count++;
//            if (count == 500) {
//                session.flush();
//                session.clear();
//                count = 0;
//            }
//        }
//        session.flush();
//        System.out.print(System.currentTimeMillis()-begin);
        System.out.print("***************已执行***********");
    }

}
