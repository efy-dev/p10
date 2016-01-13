package com.efeiyi.ec.system.zero.promotion.handler;

import com.efeiyi.ec.organization.model.BigUser;
import com.efeiyi.ec.purchase.model.PurchaseOrder;
import com.efeiyi.ec.zero.promotion.model.PromotionPlanElement;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.service.DoHandler;
import com.ming800.core.util.ApplicationContextUtil;
import org.springframework.ui.ModelMap;

import javax.servlet.http.HttpServletRequest;
import java.math.BigDecimal;
import java.math.BigInteger;
import java.util.*;

/**
 * Created by Administrator on 2015/12/24.
 */
public class InternalPromotionHandler implements DoHandler {
    //    private PromotionPlanManagerService promotionPlanManagerService = (PromotionPlanManagerService) ApplicationContextUtil.getApplicationContext().getBean("promotionPlanManagerImpl");
    private BaseManager baseManager = (BaseManager) ApplicationContextUtil.getApplicationContext().getBean("baseManagerImpl");

    @Override
    public ModelMap handle(ModelMap modelMap, HttpServletRequest request) throws Exception {
        modelMap.put("statisticsList", getPromotionPlanElementList(modelMap));
        return modelMap;
    }

    private List<PromotionPlanElement> getPromotionPlanElementList(ModelMap modelMap) throws Exception {
        List<PromotionPlanElement> statisticsList = new ArrayList<>();
        List<BigUser> bigUserList = (List<BigUser>) modelMap.get("objectList");

        if (bigUserList != null && !bigUserList.isEmpty()) {
            Map<String, BigUser> bigUserMap = new LinkedHashMap<String, BigUser>();
            for (BigUser bigUser : bigUserList) {
                bigUserMap.put(bigUser.getId(), bigUser);
            }
            LinkedHashMap<String, Object> queryParamMap = new LinkedHashMap<>();

            //注册
            List<Object[]> registerCounts = (List<Object[]>) baseManager.executeSql("list", "select substring(x.source,6,16),count(x.source) from organization_user x where x.source like 'user%' group by x.source", queryParamMap);
            Map<String, Integer> registerCountsMap = new HashMap<>();
            for (Object[] objects : registerCounts) {
                registerCountsMap.put((String) objects[0], ((BigInteger) objects[1]).intValue());
            }


            List<PurchaseOrder> purchaseOrderList = baseManager.listObject("from PurchaseOrder x where x.source like 'user%'", queryParamMap);
            Map<String,List<BigDecimal>> orderMap = new HashMap<>();
            for (PurchaseOrder purchaseOrder : purchaseOrderList) {
                String sourceId = purchaseOrder.getSource().substring(5);
                List<BigDecimal> valueList;
                if(purchaseOrder.getSource().equals("user_if3r1tjdacyzjklu")){
                    System.out.println();
                }
                if((valueList = orderMap.get(sourceId)) == null){
                    valueList = new ArrayList();
                    valueList.add(new BigDecimal(1));//下单数
                    valueList.add(purchaseOrder.getTotal());//订单总额
                    valueList.add(purchaseOrder.getRealPayMoney());//支付总额
                    orderMap.put(sourceId,valueList);
                }else{
                    valueList.set(0,new BigDecimal(valueList.get(0).doubleValue() + 1));//下单数
                    valueList.set(1,valueList.get(1).add(purchaseOrder.getTotal()));//订单总额
                    valueList.set(2,valueList.get(2).add(purchaseOrder.getRealPayMoney()));//支付总额
                }
            }

            for (Map.Entry<String,BigUser> entry : bigUserMap.entrySet()) {
                PromotionPlanElement promotionPlanElement = new PromotionPlanElement();
                Integer registerCount = registerCountsMap.get(entry.getKey());
                promotionPlanElement.setRegisterCount(registerCount == null ? "0" : registerCount.toString());//设置注册量
                List<BigDecimal> orderElementList = orderMap.get(entry.getKey());
                Long orderCount = orderElementList == null ? 0 : orderElementList.get(0).longValue();
                promotionPlanElement.setOrderCount(orderCount.toString());//设置订单数
                BigDecimal orderAmount = orderElementList == null ? null : orderElementList.get(1);
                promotionPlanElement.setOrderAmount(orderAmount == null ? "0.00" : orderAmount.toString());//设置订单总额
                BigDecimal paidAmount = orderElementList == null ? null : orderElementList.get(2);
                promotionPlanElement.setOrderPaidAmount(paidAmount == null ? "0.00" : paidAmount.toString());//设置实付金额

                statisticsList.add(promotionPlanElement);
            }
//            //下单数
//            List<Object[]> orderCounts = (List<Object[]>)baseManager.executeSql("list", "select substring(x.source,6,16),count(*) from purchase_order x where x.source like 'user%' group by x.source", queryParamMap);
//            Map<String,Integer> orderCountsMap = new HashMap<>();
//            for(Object[] objects : orderCounts){
//                orderCountsMap.put((String)objects[0],((BigInteger)objects[1]).intValue());
//            }
//
//            //订单总额
//            List<Object[]> orderAmounts = (List<Object[]>)baseManager.executeSql("list", "select substring(x.source,6,16),sum(total) from purchase_order x where x.source like 'user%' group by x.source", queryParamMap);
//            Map<String,BigDecimal > orderAmountsMap = new HashMap<>();
//            for(Object[] objects : orderAmounts){
//                orderAmountsMap.put((String)objects[0],(BigDecimal)objects[1]);
//            }
//
//            //支付总额
//            queryParamMap.put("order_status", PurchaseOrder.ORDER_STATUS_WRECEIVE);
//            List<Object[]> paidAmounts = (List<Object[]>)baseManager.executeSql("list", "select substring(x.source,6,16),sum(total) from purchase_order x where x.source like 'user%' and order_status=:order_status group by x.source", queryParamMap);
//            Map<String,BigDecimal> paidAmountsMap = new HashMap<>();
//            for(Object[] objects : paidAmounts){
//                paidAmountsMap.put((String)objects[0],(BigDecimal)objects[1]);
//            }
//
//            for (Map.Entry<String,BigUser> entry : bigUserMap.entrySet()) {
//                PromotionPlanElement promotionPlanElement = new PromotionPlanElement();
//                Integer registerCount = registerCountsMap.get(entry.getKey());
//                if(registerCount != null){
//                    System.out.println(entry.getKey());
//                }
//                promotionPlanElement.setRegisterCount(registerCount == null ? "0" : registerCount.toString());//设置注册量
//                Integer orderCount = orderCountsMap.get(entry.getKey());
//                promotionPlanElement.setOrderCount(orderCount == null ? "0" : orderCount.toString());//设置订单数
//                BigDecimal orderAmount = orderAmountsMap.get(entry.getKey());
//                promotionPlanElement.setOrderAmount(orderAmount == null ? "0.00" : orderAmount.toString());//设置订单总额
//                BigDecimal paidAmount = paidAmountsMap.get(entry.getKey());
//                promotionPlanElement.setOrderPaidAmount(paidAmount == null ? "0.00" : paidAmount.toString());//设置实付金额
//
//                statisticsList.add(promotionPlanElement);
//            }
        }

        return statisticsList;
    }
}
