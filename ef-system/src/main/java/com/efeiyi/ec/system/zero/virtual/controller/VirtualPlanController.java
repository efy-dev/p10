package com.efeiyi.ec.system.zero.virtual.controller;

import com.efeiyi.ec.purchase.model.PurchaseOrderProduct;
import com.efeiyi.ec.system.zero.virtual.model.task.CoreTaskScheduler;
import com.efeiyi.ec.system.zero.virtual.model.timer.SubTimer;
import com.efeiyi.ec.system.zero.virtual.model.timer.SuperTimer;
import com.efeiyi.ec.system.zero.virtual.service.VirtualPlanManagerService;
import com.efeiyi.ec.system.zero.virtual.util.VirtualPlanConstant;
import com.efeiyi.ec.zero.virtual.model.VirtualOrderPlan;
import com.efeiyi.ec.zero.virtual.model.VirtualPlan;
import com.efeiyi.ec.zero.virtual.model.VirtualUser;
import com.efeiyi.ec.zero.virtual.model.VirtualUserPlan;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.taglib.PageEntity;
import org.apache.commons.beanutils.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by Administrator on 2015/12/9.
 * 虚拟计划 Controller
 */

@Controller
public class VirtualPlanController {

    @Autowired
    private BaseManager baseManager;

    @Autowired
    @Qualifier("virtualPlanManagerImpl")
    private VirtualPlanManagerService vpmService;


    @RequestMapping("/startPlan.do")
    public ModelAndView startPlan(VirtualPlan virtualPlan, ModelMap modelMap,HttpServletRequest request) {

        List<VirtualPlan> virtualPlanList = new ArrayList<>();
        virtualPlan = (VirtualPlan)baseManager.getObject(VirtualPlan.class.getName(), virtualPlan.getId());
        if(!VirtualPlanConstant.planStatusStarted.equals(virtualPlan.getStatus())) {
            virtualPlanList.add(virtualPlan);
            CoreTaskScheduler.getInstance().execute(virtualPlanList);
        }
        modelMap.addAttribute(virtualPlan);
        return new ModelAndView("redirect:" + request.getParameter("resultPage"), modelMap);
    }

    @RequestMapping("/pausePlan.do")
    public ModelAndView pausePlan(VirtualPlan virtualPlan, ModelMap modelMap,HttpServletRequest request) {

        virtualPlan = (VirtualPlan)baseManager.getObject(VirtualPlan.class.getName(), virtualPlan.getId());
        SubTimer subTimer = SuperTimer.getInstance().getSubTimerMap().get(virtualPlan);
        if(subTimer != null){
            subTimer.cancel();
        }
        modelMap.addAttribute(virtualPlan);
        return new ModelAndView("redirect:" + request.getParameter("resultPage"),modelMap);
    }
    @RequestMapping("/virtualPlan/getTypeObjectList.do")
    public ModelAndView getTypeObjectList(ModelMap modelMap, HttpServletRequest request) throws Exception {

        //虚拟计划Id
        String planId = request.getParameter("id");
        if (planId.isEmpty() || planId.trim().equals("")){
            throw new Exception("获取计划完成列表失败:VirtualPlanId为空!");
        }
        modelMap.put("planId", planId);
        //虚拟计划对象类型
        String type = request.getParameter("type");
        modelMap.put("objectType", type);
        //虚拟计划完成列表分页信息
        PageEntity pageEntity = new PageEntity();
        String pageIndex = request.getParameter("pageEntity.index");
        String pageSize = request.getParameter("pageEntity.size");
        if (pageIndex != null) {
            pageEntity.setIndex(Integer.parseInt(pageIndex));
            pageEntity.setSize(Integer.parseInt(pageSize));
        }
        modelMap.put("pageEntity", pageEntity);
        //虚拟计划对象--用户user
        if (!type.isEmpty() && type.trim().equals(VirtualPlanConstant.PLAN_TYPE_USER)){
            return virtualUserList(modelMap);
        }
        //虚拟计划对象--订单order
        if (!type.isEmpty() && type.trim().equals(VirtualPlanConstant.PLAN_TYPE_ORDER)){
            return virtualOrderList(modelMap);
        }
        //虚拟计划对象--点赞praise
        if (!type.isEmpty() && type.trim().equals(VirtualPlanConstant.PLAN_TYPE_PRAISE)){}
        //虚拟计划对象--商品product
        if (!type.isEmpty() && type.trim().equals(VirtualPlanConstant.PLAN_TYPE_PRODUCT)){}
        //虚拟计划对象--收藏
        if (!type.isEmpty() && type.trim().equals(VirtualPlanConstant.PLAN_TYPE_COLLECT)){}
        //虚拟计划对象--人气popularity
        if (!type.isEmpty() && type.trim().equals(VirtualPlanConstant.PLAN_TYPE_POPULARITY)){}

        return new ModelAndView("redirect:/basic/xm.do?qm=plistVirtualPlan_default");
    }

    @RequestMapping("/virtualPlan/getTypeObjectView.do")
    public ModelAndView getTypeObjectView(ModelMap modelMap, HttpServletRequest request) throws Exception {

        //虚拟计划Id
        String planId = request.getParameter("id");
        if (planId.isEmpty() || planId.trim().equals("")){
            throw new Exception("获取计划完成列表失败:VirtualPlanId为空!");
        }
        modelMap.put("planId", planId);
        //虚拟计划对象类型
        String type = request.getParameter("type");
        modelMap.put("objectType", type);

        //虚拟计划对象--用户user
        if (!type.isEmpty() && type.trim().equals(VirtualPlanConstant.PLAN_TYPE_USER)){
            return virtualUserView(modelMap);
        }
        //虚拟计划对象--订单order
        if (!type.isEmpty() && type.trim().equals(VirtualPlanConstant.PLAN_TYPE_ORDER)){
            return virtualOrderView(modelMap);
        }
        //虚拟计划对象--点赞praise
        if (!type.isEmpty() && type.trim().equals(VirtualPlanConstant.PLAN_TYPE_PRAISE)){}
        //虚拟计划对象--商品product
        if (!type.isEmpty() && type.trim().equals(VirtualPlanConstant.PLAN_TYPE_PRODUCT)){}
        //虚拟计划对象--收藏
        if (!type.isEmpty() && type.trim().equals(VirtualPlanConstant.PLAN_TYPE_COLLECT)){}
        //虚拟计划对象--人气popularity
        if (!type.isEmpty() && type.trim().equals(VirtualPlanConstant.PLAN_TYPE_POPULARITY)){}

        return new ModelAndView("redirect:/basic/xm.do?qm=plistVirtualPlan_default");
    }

    @RequestMapping("/virtualPlan/saveVirtualUser.do")
    public ModelAndView saveVirtualUser(VirtualUserPlan virtualUserPlan) throws Exception{
        baseManager.delete(VirtualPlan.class.getName(), virtualUserPlan.getId());
        virtualUserPlan.setImplementClass("com.efeiyi.jh.model.task.VirtualUserGenerator");
        virtualUserPlan.setId(null);
        baseManager.saveOrUpdate(VirtualUserPlan.class.getName(), virtualUserPlan);
        return new ModelAndView("redirect:/basic/xm.do?qm=plistVirtualPlan_default");
    }

    private ModelAndView virtualOrderList(ModelMap modelMap) throws Exception {
        String planId = (String) modelMap.get("planId");
        VirtualOrderPlan virtualOrderPlan = (VirtualOrderPlan)baseManager.getObject(VirtualOrderPlan.class.getName(), planId);
        PageEntity pageEntity = (PageEntity) modelMap.get("pageEntity");
        List<PurchaseOrderProduct> popList = vpmService.getOrderProductList(virtualOrderPlan, pageEntity);
        pageEntity.setCount(virtualOrderPlan.getVirtualPurchaseOrderList().size());
        modelMap.put("popList", popList);

        return new ModelAndView("/virtualPlan/virtualPurchaseOrderPList");
    }

    private ModelAndView virtualUserList(ModelMap modelMap) throws Exception{
        String planId = (String) modelMap.get("planId");
        VirtualUserPlan virtualUserPlan = (VirtualUserPlan)baseManager.getObject(VirtualUserPlan.class.getName(), planId);
        PageEntity pageEntity = (PageEntity) modelMap.get("pageEntity");
        List<VirtualUser> vUserList = vpmService.getVirtualUserList(virtualUserPlan, pageEntity);
        pageEntity.setCount(virtualUserPlan.getVirtualUserList().size());
        modelMap.put("vUserList", vUserList);

        return new ModelAndView("/virtualPlan/virtualUserPList");
    }

    private ModelAndView virtualUserView(ModelMap modelMap) throws Exception{
        String planId = (String) modelMap.get("planId");
        VirtualPlan virtualPlan = (VirtualPlan)baseManager.getObject(VirtualPlan.class.getName(), planId);
        VirtualUserPlan virtualUserPlan = new VirtualUserPlan();
        BeanUtils.copyProperties(virtualUserPlan, virtualPlan);
        modelMap.put("object", virtualUserPlan);

        return new ModelAndView("/virtualPlan/user/virtualPlanUserView");
    }

    private ModelAndView virtualOrderView(ModelMap modelMap) throws Exception{
        String planId = (String) modelMap.get("planId");
        VirtualPlan virtualPlan = (VirtualPlan)baseManager.getObject(VirtualPlan.class.getName(), planId);
        VirtualOrderPlan virtualOrderPlan = new VirtualOrderPlan();
        BeanUtils.copyProperties(virtualOrderPlan, virtualPlan);
        modelMap.put("object", virtualOrderPlan);
        return new ModelAndView("/virtualPlan/order/virtualPlanOrderView");
    }

}
