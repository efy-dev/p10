package com.efeiyi.pal.system.order.controller;

import com.efeiyi.pal.label.model.Label;
import com.efeiyi.pal.purchase.model.PurchaseOrder;
import com.efeiyi.pal.purchase.model.PurchaseOrderLabel;
import com.efeiyi.pal.system.order.service.LabelServiceManager;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.util.ApplicationContextUtil;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
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

    private BaseManager baseManager = (BaseManager) ApplicationContextUtil.getApplicationContext().getBean("baseManagerImpl");

    @RequestMapping("/deliverGoods.do")
    public ModelAndView deliverGoods(ModelMap modelMap, HttpServletRequest request) throws Exception {

        String purchaseOrderId = request.getParameter("orderId");
        if (purchaseOrderId == null || purchaseOrderId.trim().equals("")) {
            throw new Exception("订单Id不能为空!");
        }
        PurchaseOrder purchaseOrder = (PurchaseOrder) baseManager.getObject(PurchaseOrder.class.getName(), purchaseOrderId);
        Integer sumProduct = getSumProductAmount(purchaseOrder);
        List<Label> labelList = getLabelListBySumProduct(sumProduct);

        purchaseOrder = distributeLabelList(purchaseOrder, labelList);

        modelMap.put("object", purchaseOrder);
        String resultPage = "/purchaseOrder/purchaseOrderView";
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
        Integer minSerial = labelServiceManager.getMinSerial();
        List<Label> list = labelServiceManager.getLabelListByMinSerialAndSumProduct(minSerial, sumProduct);
        return list;
    }

    /**
     * 分配标签
     * @param purchaseOrder
     * @param labelList
     */
    private PurchaseOrder distributeLabelList(PurchaseOrder purchaseOrder, List<Label> labelList){
        List<PurchaseOrderLabel> POLList = purchaseOrder.getPurchaseOrderLabelList();
        int flag = 0;
        for (int j=0; j<POLList.size(); j++){
            PurchaseOrderLabel pol = POLList.get(j);
            for (int i=0; i<pol.getAmount(); i++){
                Label label = labelList.get(i+flag);
                label.setPurchaseOrderLabel(pol);
                label.setSeller(purchaseOrder.getTenant());
                label.setStatus("2");
                baseManager.saveOrUpdate(Label.class.getName(), label);
            }
            flag += pol.getAmount();
        }

        purchaseOrder.setStatus("9");
        baseManager.saveOrUpdate(PurchaseOrder.class.getName(), purchaseOrder);
        return purchaseOrder;
    }

}
