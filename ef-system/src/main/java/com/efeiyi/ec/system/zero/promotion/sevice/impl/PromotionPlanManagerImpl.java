package com.efeiyi.ec.system.zero.promotion.sevice.impl;

import com.efeiyi.ec.organization.model.User;
import com.efeiyi.ec.purchase.model.PurchaseOrder;
import com.efeiyi.ec.system.zero.promotion.dao.PromotionPlanDao;
import com.efeiyi.ec.system.zero.promotion.sevice.PromotionPlanManagerService;
import com.efeiyi.ec.zero.promotion.model.PromotionPlan;
import com.ming800.core.taglib.PageEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by Administrator on 2015/12/7.
 * PromotionPlanManagerService 实现类
 */

@Service
public class PromotionPlanManagerImpl implements PromotionPlanManagerService {

    @Autowired
    @Qualifier("promotionPlanDao")
    private PromotionPlanDao promotionPlanDao;

    @Override
    public String getDDL(PromotionPlan promotionPlan) throws Exception {
        return promotionPlanDao.getDDL(promotionPlan);
    }

    @Override
    public String getZFE(PromotionPlan promotionPlan) throws Exception {
        return promotionPlanDao.getZFE(promotionPlan);
    }

    @Override
    public String getSFE(PromotionPlan promotionPlan) throws Exception {
        return promotionPlanDao.getSFE(promotionPlan);
    }

    @Override
    public List<User> getZCLInformation(PromotionPlan promotionPlan, PageEntity pageEntity) throws Exception {
        return promotionPlanDao.getZCLInformation(promotionPlan, pageEntity);
    }

    @Override
    public List<PurchaseOrder> getDDLInformation(PromotionPlan promotionPlan, PageEntity pageEntity) throws Exception {
        return promotionPlanDao.getDDLInformation(promotionPlan, pageEntity);
    }

}
