package com.efeiyi.ec.system.zero.virtual.handler;

import com.efeiyi.ec.system.zero.virtual.service.VirtualPlanManagerService;
import com.efeiyi.ec.system.zero.virtual.util.VirtualPlanConstant;
import com.efeiyi.ec.zero.virtual.model.VirtualOrderPlan;
import com.efeiyi.ec.zero.virtual.model.VirtualPlan;
import com.efeiyi.ec.zero.virtual.model.VirtualPlanElement;
import com.efeiyi.ec.zero.virtual.model.VirtualUserPlan;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.PageInfo;
import com.ming800.core.does.service.DoHandler;
import com.ming800.core.util.ApplicationContextUtil;
import org.springframework.ui.ModelMap;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by Administrator on 2015/12/9.
 * 获取虚拟计划  关联数量及完成数量
 */
public class VirtualPlanListHandler implements DoHandler {

    private BaseManager baseManager = (BaseManager) ApplicationContextUtil.getApplicationContext().getBean("baseManagerImpl");
    private VirtualPlanManagerService vpService = (VirtualPlanManagerService) ApplicationContextUtil.getApplicationContext().getBean("virtualPlanManagerImpl");

    @Override
    public ModelMap handle(ModelMap modelMap, HttpServletRequest httpServletRequest) throws Exception {
        modelMap.put("VPEList", getRelationAndComplete(modelMap));
        return modelMap;
    }

    private List<VirtualPlanElement> getRelationAndComplete(ModelMap modelMap) throws Exception {
        List<VirtualPlanElement> vpeList = new ArrayList<>();
        List<VirtualPlan> virtualPlanList = ((PageInfo)modelMap.get("pageInfo")).getList();

        if (virtualPlanList != null && !virtualPlanList.isEmpty()){
            for (VirtualPlan vp:virtualPlanList){
                VirtualPlanElement vpe = new VirtualPlanElement();
                vpe.setVirtualPlan(vp);

                //计划对象是--用户
                if (vp.getPlanType().equals(VirtualPlanConstant.PLAN_TYPE_USER)){
                    VirtualUserPlan virtualUserPlan = (VirtualUserPlan) baseManager.getObject(VirtualUserPlan.class.getName(), vp.getId());
                    if (virtualUserPlan != null){
                        vpe.setRelation(virtualUserPlan.getCount());//关联数量
                        vpe.setComplete(virtualUserPlan.getVirtualUserList().size());//完成数量
                    }
                    vpe.setType(VirtualPlanConstant.PLAN_TYPE_USER);
                }

                //计划对象是--订单
                if (vp.getPlanType().equals(VirtualPlanConstant.PLAN_TYPE_ORDER)){
                    VirtualOrderPlan virtualOrderPlan = (VirtualOrderPlan) baseManager.getObject(VirtualOrderPlan.class.getName(), vp.getId());
                    if (virtualOrderPlan != null){
                        vpe = getOrderPlanRelation(vpe, virtualOrderPlan);
                    }
                    vpe.setType(VirtualPlanConstant.PLAN_TYPE_ORDER);
                }

                //计划对象是--点赞
                if (vp.getPlanType().equals(VirtualPlanConstant.PLAN_TYPE_PRAISE)){
                    vpe.setType(VirtualPlanConstant.PLAN_TYPE_PRAISE);
                }

                //计划对象是--商品
                if (vp.getPlanType().equals(VirtualPlanConstant.PLAN_TYPE_PRODUCT)){
                    vpe.setType(VirtualPlanConstant.PLAN_TYPE_PRODUCT);
                }

                //计划对象是--收藏
                if (vp.getPlanType().equals(VirtualPlanConstant.PLAN_TYPE_COLLECT)){
                    vpe.setType(VirtualPlanConstant.PLAN_TYPE_COLLECT);
                }

                //计划对象是--人气
                if (vp.getPlanType().equals(VirtualPlanConstant.PLAN_TYPE_POPULARITY)){
                    vpe.setType(VirtualPlanConstant.PLAN_TYPE_POPULARITY);
                }

                vpeList.add(vpe);
            }
        }

        return vpeList;
    }

    private VirtualPlanElement getOrderPlanRelation(VirtualPlanElement virtualPlanElement, VirtualOrderPlan virtualOrderPlan) throws Exception {

        virtualPlanElement.setRelation(vpService.getOrderRelation(virtualOrderPlan));//关联数量
        virtualPlanElement.setComplete(virtualOrderPlan.getVirtualPurchaseOrderList().size());//完成数量

        return virtualPlanElement;
    }

}
