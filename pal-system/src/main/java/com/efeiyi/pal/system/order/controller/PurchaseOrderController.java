package com.efeiyi.pal.system.order.controller;

import com.efeiyi.pal.label.model.Label;
import com.efeiyi.pal.organization.model.Tenant;
import com.efeiyi.pal.purchase.model.PurchaseOrder;
import com.efeiyi.pal.purchase.model.PurchaseOrderLabel;
import com.efeiyi.pal.system.order.service.LabelServiceManager;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.p.service.AutoSerialManager;
import com.ming800.core.util.ApplicationContextUtil;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * Created by Administrator on 2015/8/17.
 */

@Controller
@RequestMapping("/order")
public class PurchaseOrderController {

    @Autowired
    @Qualifier("labelServiceManagerImpl")
    private LabelServiceManager labelServiceManager;

    @Autowired
    private AutoSerialManager autoSerialManager;

    private BaseManager baseManager = (BaseManager) ApplicationContextUtil.getApplicationContext().getBean("baseManagerImpl");

    @RequestMapping("/savePurchaseOrder.do")
    public ModelAndView savePurchaseOrder(ModelMap modelMap, HttpServletRequest request) throws Exception {
        PurchaseOrder purchaseOrder = new PurchaseOrder();
        String purchaseOrderId = request.getParameter("id");
        String type = "new";
        if (purchaseOrderId != null && !purchaseOrderId.trim().equals("")) {
            type = "edit";
            purchaseOrder = (PurchaseOrder) baseManager.getObject(PurchaseOrder.class.getName(), purchaseOrderId);
        }
        purchaseOrder = getBaseProperty(purchaseOrder, request, type);
        purchaseOrder = getRelationObject(purchaseOrder, request);

        baseManager.saveOrUpdate(PurchaseOrder.class.getName(), purchaseOrder);

        String resultPage = "redirect:/basic/xm.do?qm=viewPurchaseOrder&order=view&id=" + purchaseOrder.getId();
        return new ModelAndView(resultPage);
    }

    /**
     * 订单分配标签
     * @param modelMap
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping("/deliverGoods.do")
    public ModelAndView deliverGoods(ModelMap modelMap, HttpServletRequest request) throws Exception {
//        Long begin = System.currentTimeMillis();
        String purchaseOrderId = request.getParameter("orderId");
        if (purchaseOrderId == null || purchaseOrderId.trim().equals("")) {
            throw new Exception("deliverGoods 订单Id不能为空!");
        }
        PurchaseOrder purchaseOrder = (PurchaseOrder) baseManager.getObject(PurchaseOrder.class.getName(), purchaseOrderId);
        Integer sumProduct = getSumProductAmount(purchaseOrder);

        purchaseOrder = distributeLabelList(purchaseOrder, getLabelListBySumProduct(sumProduct), sumProduct);

        modelMap.put("object", purchaseOrder);
        String resultPage = "redirect:/basic/xm.do?qm=viewPurchaseOrder&order=view&id=" + purchaseOrder.getId();
//        System.out.println(" ************ ");
//        System.out.println(System.currentTimeMillis() - begin);
//        System.out.println(" ************ ");
        return new ModelAndView(resultPage);
    }

    /**
     * 激活或作废标签
     * @param modelMap
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping("/activatedOrCancelLabels.do")
    public ModelAndView activatedOrCancelLabels(ModelMap modelMap, HttpServletRequest request) throws Exception {
//        Long begin = System.currentTimeMillis();
        String type = request.getParameter("type");
        String purchaseOrderId = request.getParameter("orderId");
        if (purchaseOrderId == null || purchaseOrderId.trim().equals("")) {
            throw new Exception("activatedOrCancelLabels 订单Id不能为空!");
        }
        PurchaseOrder purchaseOrder = (PurchaseOrder) baseManager.getObject(PurchaseOrder.class.getName(), purchaseOrderId);
        List<Label> labels = getLabelListByOrder(purchaseOrder);

        purchaseOrder = activateOrCancelLabelList(purchaseOrder, labels, type);

        modelMap.put("object", purchaseOrder);
        String resultPage = "redirect:/basic/xm.do?qm=viewPurchaseOrder&order=view&id=" + purchaseOrder.getId();
//        System.out.println(" ************ ");
//        System.out.println(System.currentTimeMillis() - begin);
//        System.out.println(" ************ ");
        return new ModelAndView(resultPage);
    }

    /**
     * 计算订单中购买的标签数量
     * @param purchaseOrder
     * @return
     */
    private Integer getSumProductAmount(PurchaseOrder purchaseOrder){
        List<PurchaseOrderLabel> list = purchaseOrder.getPurchaseOrderLabelList();
        Integer sum = 0;
        for (PurchaseOrderLabel pol: list){
            sum += pol.getAmount();
        }
        return sum;
    }

    /**
     * 获取购买同等数量的标签
     * @param sumProduct
     * @return
     */
    private List<Label> getLabelListBySumProduct(Integer sumProduct){
        List<Label> list = labelServiceManager.getLabelListByMinSerialAndSumProduct(sumProduct);
        return list;
    }

    /**
     * 分配标签
     * @param purchaseOrder
     * @param labelList
     * @param sumProduct
     */
    private PurchaseOrder distributeLabelList(PurchaseOrder purchaseOrder, List<Label> labelList, Integer sumProduct) throws Exception {
        if (sumProduct> labelList.size()){
            throw new Exception("标签库标签数量不足，请联系系统管理员，申请新标签！");
        }
        labelServiceManager.distributeLabelList(purchaseOrder, labelList);

        purchaseOrder.setStatus("9");
        baseManager.saveOrUpdate(PurchaseOrder.class.getName(), purchaseOrder);
        return purchaseOrder;
    }

    /**
     * 获取为订单分配的所有标签
     * @param purchaseOrder
     * @return
     */
    private List<Label> getLabelListByOrder(PurchaseOrder purchaseOrder) throws Exception {
        List<Label> list = labelServiceManager.getLabelListByOrder(purchaseOrder);
        if (list == null || list.size()==0){
            throw new Exception("获取订单标签失败");
        }
        return list;
    }

    /**
     * 批量激活或作废订单标签
     * @param purchaseOrder
     * @param labels
     * @param type
     * @return
     */
    private PurchaseOrder activateOrCancelLabelList(PurchaseOrder purchaseOrder, List<Label> labels, String type){
        String status = "4";
        if (type.trim().equals("A")){
            status = "3";
        }
        labelServiceManager.activateOrCancelLabelList(status, labels);

        purchaseOrder.setStatus(status);
        baseManager.saveOrUpdate(PurchaseOrder.class.getName(), purchaseOrder);
        return purchaseOrder;
    }

    /**
     * 订单信息基本内容
     * @param purchaseOrder
     * @param request
     * @param type
     * @return
     * @throws Exception
     */
    private PurchaseOrder getBaseProperty(PurchaseOrder purchaseOrder, HttpServletRequest request, String type) throws Exception {

        if (type.equals("new")){
            String serial = autoSerialManager.nextSerial("serial");
            purchaseOrder.setSerial(serial);
            purchaseOrder.setStatus("1");
            purchaseOrder.setCreateDatetime(new Date());
        }
//        else{
//            String serial = request.getParameter("serial");
//            purchaseOrder.setSerial(serial);
//            String status = request.getParameter("status");
//            purchaseOrder.setStatus(status);
//        }

        return purchaseOrder;
    }

    /**
     * 订单关联对象
     * @param purchaseOrder
     * @param request
     * @return
     */
    private PurchaseOrder getRelationObject(PurchaseOrder purchaseOrder, HttpServletRequest request){
        String tenantId = request.getParameter("tenant.id");
        Tenant tenant = (Tenant) baseManager.getObject(Tenant.class.getName(), tenantId);

        purchaseOrder.setTenant(tenant);
        return purchaseOrder;
    }

}
