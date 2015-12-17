package com.efeiyi.ec.system.zero.promotion.handler;

import com.efeiyi.ec.purchase.model.PurchaseOrder;
import com.efeiyi.ec.system.zero.promotion.sevice.PromotionPlanManagerService;
import com.efeiyi.ec.zero.promotion.model.PromotionPlan;
import com.efeiyi.ec.zero.promotion.model.PromotionPlanElement;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.PageInfo;
import com.ming800.core.does.service.DoHandler;
import com.ming800.core.util.ApplicationContextUtil;
import org.springframework.ui.ModelMap;

import javax.servlet.http.HttpServletRequest;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;

/**
 * Created by Administrator on 2015/7/23.
 * 获取注册量、订单数量及订单总金额 Handler
 */
public class PromotionPlanListHandler implements DoHandler {

    private PromotionPlanManagerService promotionPlanManagerService = (PromotionPlanManagerService) ApplicationContextUtil.getApplicationContext().getBean("promotionPlanManagerImpl");
    private BaseManager baseManager = (BaseManager) ApplicationContextUtil.getApplicationContext().getBean("baseManagerImpl");

    @Override
    public ModelMap handle(ModelMap modelMap, HttpServletRequest request) throws Exception {
        modelMap.put("PPEList", getPromotionPlanElementList(modelMap));
        return modelMap;
    }

    private List<PromotionPlanElement> getPromotionPlanElementList(ModelMap modelMap) throws Exception {
        List<PromotionPlanElement> ppeList = new ArrayList<>();
        List<PromotionPlan> promotionPlanList = ((PageInfo) modelMap.get("pageInfo")).getList();

        if (promotionPlanList != null && !promotionPlanList.isEmpty()) {
            for (PromotionPlan pp : promotionPlanList) {
                PromotionPlanElement promotionPlanElement = new PromotionPlanElement();
                promotionPlanElement.setPromotionPlan(pp);

                LinkedHashMap<String, Object> queryParamMap = new LinkedHashMap<>();
                queryParamMap.put("source", pp.getIdentifier());
                long registerCount = (long) baseManager.getUniqueObjectByConditions("select count(*) from MyUser x where x.source=:source", queryParamMap);
                promotionPlanElement.setRegisterCount(Long.toString(registerCount));//设置注册量

                long orderCount = (long) baseManager.getUniqueObjectByConditions("select count(*) from PurchaseOrder x where x.source=:source", queryParamMap);
                promotionPlanElement.setOrderCount(Long.toString(orderCount));//设置订单数

                BigDecimal orderAmount = (BigDecimal) baseManager.getUniqueObjectByConditions("select sum(total) from PurchaseOrder x where x.source=:source", queryParamMap);
                promotionPlanElement.setOrderAmount(orderAmount == null ? "0.00" : orderAmount.toString());//设置订单总额

                queryParamMap.put("orderStatus", PurchaseOrder.ORDER_STATUS_WRECEIVE);
                BigDecimal orderPaidAmount = (BigDecimal) baseManager.getUniqueObjectByConditions("select sum(total) from PurchaseOrder x where x.source=:source and orderStatus=:orderStatus", queryParamMap);
                promotionPlanElement.setOrdePaidAmount(orderPaidAmount == null ? "0.00" : orderPaidAmount.toString());//设置实付金额
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
