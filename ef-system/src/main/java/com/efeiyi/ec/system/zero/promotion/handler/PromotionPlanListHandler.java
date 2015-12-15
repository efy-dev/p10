package com.efeiyi.ec.system.zero.promotion.handler;

import com.efeiyi.ec.system.zero.promotion.sevice.PromotionPlanManagerService;
import com.efeiyi.ec.zero.promotion.model.PromotionPlan;
import com.efeiyi.ec.zero.promotion.model.PromotionPlanElement;
import com.ming800.core.does.model.PageInfo;
import com.ming800.core.does.service.DoHandler;
import com.ming800.core.util.ApplicationContextUtil;
import org.springframework.ui.ModelMap;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by Administrator on 2015/7/23.
 * 获取注册量、订单数量及订单总金额 Handler
 */
public class PromotionPlanListHandler implements DoHandler {

    private PromotionPlanManagerService promotionPlanManagerService = (PromotionPlanManagerService) ApplicationContextUtil.getApplicationContext().getBean("promotionPlanManagerImpl");

    @Override
    public ModelMap handle(ModelMap modelMap, HttpServletRequest request) throws Exception {
        modelMap.put("PPEList", getPromotionPlanElementList(modelMap));
        return modelMap;
    }

    private List<PromotionPlanElement> getPromotionPlanElementList(ModelMap modelMap) throws Exception {
        List<PromotionPlanElement> ppeList = new ArrayList<>();
        List<PromotionPlan> promotionPlanList = ((PageInfo)modelMap.get("pageInfo")).getList();

        if (promotionPlanList != null && !promotionPlanList.isEmpty()){
            for (PromotionPlan pp:promotionPlanList){
                PromotionPlanElement promotionPlanElement = new PromotionPlanElement();
                promotionPlanElement.setPromotionPlan(pp);
//                if (!pp.getPromotionUserRecordList().isEmpty()){//设置注册量
//                    promotionPlanElement.setZCL(String.valueOf(pp.getPromotionUserRecordList().size()));
//                }
//
//                if (!pp.getPromotionPurchaseRecordList().isEmpty()){//设置订单数、订单总额、实付金额
//                    promotionPlanElement = setDDLAndZFEAndSFE(promotionPlanElement, pp);
//                }
                ppeList.add(promotionPlanElement);
            }
        }

        return ppeList;
    }

    private PromotionPlanElement setDDLAndZFEAndSFE(PromotionPlanElement promotionPlanElement, PromotionPlan promotionPlan) throws Exception {
        promotionPlanElement.setOrderCount(promotionPlanManagerService.getDDL(promotionPlan));//设置订单数
        promotionPlanElement.setOrderAmount(promotionPlanManagerService.getZFE(promotionPlan));//设置订单总额
        promotionPlanElement.setOrdePaidAmount(promotionPlanManagerService.getSFE(promotionPlan));//设置实付金额
        return promotionPlanElement;
    }

}
