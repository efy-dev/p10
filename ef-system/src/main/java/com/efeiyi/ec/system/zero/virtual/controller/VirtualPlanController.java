package com.efeiyi.ec.system.zero.virtual.controller;

import com.efeiyi.ec.product.model.ProductModel;
import com.efeiyi.ec.purchase.model.PurchaseOrderProduct;
import com.efeiyi.ec.system.zero.virtual.model.task.CoreTaskScheduler;
import com.efeiyi.ec.system.zero.virtual.model.timer.SubTimer;
import com.efeiyi.ec.system.zero.virtual.model.timer.SuperTimer;
import com.efeiyi.ec.system.zero.virtual.service.VirtualPlanManagerService;
import com.efeiyi.ec.system.zero.virtual.util.VirtualPlanConstant;
import com.efeiyi.ec.zero.virtual.model.*;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import com.ming800.core.taglib.PageEntity;
import org.apache.commons.beanutils.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.sql.Time;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Random;

/**
 * Created by Administrator on 2015/12/9.
 * 虚拟计划 Controller
 */

@Controller
@RequestMapping("/virtualPlan")
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

    @RequestMapping("/getTypeObjectList.do")
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

    @RequestMapping("/getTypeObjectView.do")
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
            return virtualOrderView(modelMap, request);
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

    @RequestMapping("/saveVirtualUserPlan.do")
    public ModelAndView saveVirtualUserPlan(VirtualUserPlan virtualUserPlan) throws Exception{
        VirtualUserPlan userPlan = (VirtualUserPlan)baseManager.getObject(VirtualUserPlan.class.getName(), virtualUserPlan.getId());
        if (userPlan == null){
            baseManager.delete(VirtualPlan.class.getName(), virtualUserPlan.getId());
            virtualUserPlan.setImplementClass("com.efeiyi.ec.system.zero.virtual.model.task.VirtualUserGenerator");
            virtualUserPlan.setId(null);
            baseManager.saveOrUpdate(VirtualUserPlan.class.getName(), virtualUserPlan);
        }else {
            userPlan.setCount(virtualUserPlan.getCount());
            baseManager.saveOrUpdate(VirtualUserPlan.class.getName(), userPlan);
        }
        return new ModelAndView("redirect:/basic/xm.do?qm=plistVirtualPlan_default");
    }

    @RequestMapping("/saveVirtualOrderPlan.do")
    public ModelAndView saveVirtualOrderPlan(HttpServletRequest request)throws Exception{
        String id = request.getParameter("id");
        VirtualOrderPlan virtualOrderPlan = (VirtualOrderPlan) baseManager.getObject(VirtualOrderPlan.class.getName(), id);
        if (virtualOrderPlan == null){
            //获取父类virtualPlan基本属性值
            VirtualPlan virtualPlan = (VirtualPlan) baseManager.getObject(VirtualPlan.class.getName(), id);
            virtualOrderPlan = new VirtualOrderPlan();
            BeanUtils.copyProperties(virtualOrderPlan, virtualPlan);
            //删除父类virtualPlan 并制空ID
            baseManager.delete(VirtualPlan.class.getName(), id);
            virtualOrderPlan.setId(null);
        }
        //获取除父类外的基本属性值
        virtualOrderPlan = getBaseProperty(virtualOrderPlan, request);
        //获取关联对象
        virtualOrderPlan = getRelationObject(virtualOrderPlan, request);
        //保存订单计划
        baseManager.saveOrUpdate(VirtualOrderPlan.class.getName(), virtualOrderPlan);
        //保存订单计划关联商品
        saveVirtualProductModelList(virtualOrderPlan, request);

        return new ModelAndView("redirect:/basic/xm.do?qm=plistVirtualPlan_default");
    }

    private ModelAndView virtualOrderList(ModelMap modelMap) throws Exception {
        String planId = (String) modelMap.get("planId");
        VirtualOrderPlan virtualOrderPlan = (VirtualOrderPlan)baseManager.getObject(VirtualOrderPlan.class.getName(), planId);
        PageEntity pageEntity = (PageEntity) modelMap.get("pageEntity");
        List<PurchaseOrderProduct> popList = vpmService.getOrderProductList(virtualOrderPlan, pageEntity);
        pageEntity.setCount(virtualOrderPlan.getVirtualPurchaseOrderList().size());
        modelMap.put("popList", popList);

        return new ModelAndView("/zero/virtual/virtualPurchaseOrderPList");
    }

    private ModelAndView virtualUserList(ModelMap modelMap) throws Exception{
        String planId = (String) modelMap.get("planId");
        VirtualUserPlan virtualUserPlan = (VirtualUserPlan)baseManager.getObject(VirtualUserPlan.class.getName(), planId);
        PageEntity pageEntity = (PageEntity) modelMap.get("pageEntity");
        List<VirtualUser> vUserList = vpmService.getVirtualUserList(virtualUserPlan, pageEntity);
        pageEntity.setCount(virtualUserPlan.getVirtualUserList().size());
        modelMap.put("vUserList", vUserList);

        return new ModelAndView("/zero/virtual/virtualUserPList");
    }

    private ModelAndView virtualUserView(ModelMap modelMap) throws Exception{
        String planId = (String) modelMap.get("planId");
        VirtualUserPlan virtualUserPlan = (VirtualUserPlan)baseManager.getObject(VirtualUserPlan.class.getName(), planId);
        if (virtualUserPlan == null){
            VirtualPlan virtualPlan = (VirtualPlan)baseManager.getObject(VirtualPlan.class.getName(), planId);
            virtualUserPlan = new VirtualUserPlan();
            BeanUtils.copyProperties(virtualUserPlan, virtualPlan);
        }else{
            long time = virtualUserPlan.getCreateDatetime().getTime();
            virtualUserPlan.setCreateDatetime(new Date(time));
        }
        modelMap.put("object", virtualUserPlan);

        return new ModelAndView("/zero/virtual/user/virtualPlanUserView");
    }

    private ModelAndView virtualOrderView(ModelMap modelMap, HttpServletRequest request) throws Exception{
        String planId = (String) modelMap.get("planId");
        VirtualOrderPlan virtualOrderPlan = (VirtualOrderPlan) baseManager.getObject(VirtualOrderPlan.class.getName(), planId);
        if (virtualOrderPlan == null){
            VirtualPlan virtualPlan = (VirtualPlan)baseManager.getObject(VirtualPlan.class.getName(), planId);
            virtualOrderPlan = new VirtualOrderPlan();
            BeanUtils.copyProperties(virtualOrderPlan, virtualPlan);
        }else {
            long time = virtualOrderPlan.getCreateDatetime().getTime();
            virtualOrderPlan.setCreateDatetime(new Date(time));
        }
        modelMap.put("object", virtualOrderPlan);
        //获取订单计划已经建立关系的商品ID列表和name列表
        modelMap = getVirtualProductModelIdAndNameList(modelMap, virtualOrderPlan);

        //获取虚拟用户计划列表
        XQuery xQuery = new XQuery("listVirtualUserPlan_default",request);
        List<VirtualUserPlan> userPlanList = baseManager.listObject(xQuery);
        modelMap.put("userPlanList", userPlanList);

        //获取商品列表
        xQuery = new XQuery("listProductModel_virtualOrder",request);
        List<ProductModel> productModelList = baseManager.listObject(xQuery);
        modelMap.put("productModelList", productModelList);

        return new ModelAndView("/zero/virtual/order/virtualPlanOrderView");
    }

    private ModelMap getVirtualProductModelIdAndNameList(ModelMap modelMap, VirtualOrderPlan virtualOrderPlan)throws Exception{
        String pmIdList = "";
        String pmNameList = "";
        if (virtualOrderPlan.getVirtualProductModelList() != null){
            for (VirtualProductModel vpm:virtualOrderPlan.getVirtualProductModelList()){
                if (pmIdList.equals("")){
                    pmIdList = vpm.getProductModel().getId();
                }else {
                    pmIdList += "," + vpm.getProductModel().getId();
                }
                if (pmNameList.equals("")){
                    pmNameList = vpm.getProductModel().getProduct().getName() + "[" + vpm.getProductModel().getName() + "]";
                }else {
                    pmNameList += "," + vpm.getProductModel().getProduct().getName() + "[" + vpm.getProductModel().getName() + "]";
                }
            }
        }
        modelMap.put("pmIdList", pmIdList);
        modelMap.put("pmNameList", pmNameList);
        return modelMap;
    }

    private VirtualOrderPlan getBaseProperty(VirtualOrderPlan virtualOrderPlan, HttpServletRequest request)throws Exception{
        String peakTime = request.getParameter("peakTime");
        String orderAmountCeil = request.getParameter("orderAmountCeil");
        String orderAmountFloor = request.getParameter("orderAmountFloor");
        String standardDeviation = request.getParameter("standardDeviation");

        virtualOrderPlan.setPeakTime(Time.valueOf(peakTime));
        virtualOrderPlan.setOrderAmountCeil(Integer.parseInt(orderAmountCeil));
        virtualOrderPlan.setOrderAmountFloor(Integer.parseInt(orderAmountFloor));
        virtualOrderPlan.setStandardDeviation(Integer.parseInt(standardDeviation));
        virtualOrderPlan.setImplementClass("com.efeiyi.ec.system.zero.virtual.model.task.VirtualPurchaseOrderGenerator");
        return virtualOrderPlan;
    }

    private VirtualOrderPlan getRelationObject(VirtualOrderPlan virtualOrderPlan, HttpServletRequest request)throws Exception{
        String userPlanId = request.getParameter("virtualUserPlan.id");
        VirtualUserPlan virtualUserPlan = (VirtualUserPlan) baseManager.getObject(VirtualUserPlan.class.getName(), userPlanId);
        virtualOrderPlan.setVirtualUserPlan(virtualUserPlan);
        return virtualOrderPlan;
    }

    private void saveVirtualProductModelList(VirtualOrderPlan virtualOrderPlan, HttpServletRequest request)throws Exception{
        //获取随机订单数的区间
        Random random = new Random();
        Integer start = virtualOrderPlan.getOrderAmountFloor();
        Integer end = virtualOrderPlan.getOrderAmountCeil();
        //获取选择的商品id字符串，以","分隔
        String productModelIdList = request.getParameter("productModelIdList");
        String[] productModelIds = productModelIdList.split(",");
        //解除订单计划修改之前关联的商品
        if (virtualOrderPlan.getVirtualProductModelList() != null && !virtualOrderPlan.getVirtualProductModelList().isEmpty()){
            for (VirtualProductModel vpm: virtualOrderPlan.getVirtualProductModelList()){
                baseManager.delete(VirtualProductModel.class.getName(), vpm.getId());
            }
        }
        //建立订单与选择的商品之间的关联关系
        for (String id: productModelIds){
            VirtualProductModel virtualProductModel = new VirtualProductModel();
            //获取productModel
            ProductModel productModel = (ProductModel) baseManager.getObject(ProductModel.class.getName(), id);
            virtualProductModel.setProductModel(productModel);
            //获取随机数量
            Integer randomAmount = random.nextInt(end - start + 1) + start;
            virtualProductModel.setRandomAmount(randomAmount);

            virtualProductModel.setVirtualOrderPlan(virtualOrderPlan);
            baseManager.saveOrUpdate(VirtualProductModel.class.getName(), virtualProductModel);
        }
    }

}
