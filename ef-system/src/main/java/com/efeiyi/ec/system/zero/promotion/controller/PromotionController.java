package com.efeiyi.ec.system.zero.promotion.controller;

import com.efeiyi.ec.organization.model.MyUser;
import com.efeiyi.ec.purchase.model.PurchaseOrder;
import com.efeiyi.ec.system.zero.promotion.sevice.PromotionPlanManagerService;
import com.efeiyi.ec.zero.promotion.model.PromotionPlan;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.taglib.PageEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.LinkedHashMap;
import java.util.List;

/**
 * Created by Administrator on 2015/12/7.
 * 返利链接获取  链接注册人数详情及订单数量详情
 */

@Controller
@RequestMapping("/promotionPlan")
public class PromotionController {
    @Autowired
    private BaseManager baseManager;

    @Autowired
    @Qualifier("promotionPlanManagerImpl")
    private PromotionPlanManagerService promotionPlanManagerService;

    @RequestMapping("/getZCLInfo.do")
    public ModelAndView getZCLInformation(ModelMap modelMap, HttpServletRequest request) throws Exception {
        String promotionPlanId = request.getParameter("id");
        if (promotionPlanId.isEmpty() || promotionPlanId.trim().equals("")){
            throw new Exception("获取注册详情失败:promotionPlanId为空!");
        }
        modelMap.put("promotionPlanId", promotionPlanId);

        PromotionPlan promotionPlan = (PromotionPlan)baseManager.getObject(PromotionPlan.class.getName(), promotionPlanId);

        PageEntity pageEntity = new PageEntity();
        String pageIndex = request.getParameter("pageEntity.index");
        String pageSize = request.getParameter("pageEntity.size");
        if (pageIndex != null) {
            pageEntity.setIndex(Integer.parseInt(pageIndex));
            pageEntity.setSize(Integer.parseInt(pageSize));
        }

        List<MyUser> userList = promotionPlanManagerService.getZCLInformation(promotionPlan, pageEntity);

        LinkedHashMap<String, Object> queryParamMap = new LinkedHashMap<>();
        queryParamMap.put("source", promotionPlan.getIdentifier());
        long size = (long) baseManager.getUniqueObjectByConditions("select count(*) from MyUser x where x.source=:source", queryParamMap);
        pageEntity.setCount((int)size);

        modelMap.put("userList", userList);
        modelMap.put("pageEntity", pageEntity);

        return new ModelAndView("/zero/promotion/promotionPlanUsersPList");
    }

    @RequestMapping("/getDDLInfo.do")
    public ModelAndView getDDLInformation(ModelMap modelMap, HttpServletRequest request) throws Exception {
        String promotionPlanId = request.getParameter("id");
        if (promotionPlanId.isEmpty() || promotionPlanId.trim().equals("")){
            throw new Exception("获取注册详情失败:promotionPlanId为空!");
        }
        modelMap.put("promotionPlanId", promotionPlanId);

        PromotionPlan promotionPlan = (PromotionPlan)baseManager.getObject(PromotionPlan.class.getName(), promotionPlanId);

        PageEntity pageEntity = new PageEntity();
        String pageIndex = request.getParameter("pageEntity.index");
        String pageSize = request.getParameter("pageEntity.size");
        if (pageIndex != null) {
            pageEntity.setIndex(Integer.parseInt(pageIndex));
            pageEntity.setSize(Integer.parseInt(pageSize));
        }

        List<PurchaseOrder> orderList = promotionPlanManagerService.getDDLInformation(promotionPlan, pageEntity);
        pageEntity.setCount((int)Long.parseLong(promotionPlanManagerService.getDDL(promotionPlan)));
        modelMap.put("orderList", orderList);
        modelMap.put("pageEntity", pageEntity);

        return new ModelAndView("/zero/promotion/promotionPlanOrdersPList");
    }
}
