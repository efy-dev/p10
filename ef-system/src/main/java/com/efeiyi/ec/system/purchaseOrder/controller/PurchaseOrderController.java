package com.efeiyi.ec.system.purchaseOrder.controller;



import com.efeiyi.ec.purchase.model.PurchaseOrder;
import com.efeiyi.ec.system.purchaseOrder.service.PurchaseOrderManager;
import com.ming800.core.base.controller.BaseController;
import com.ming800.core.base.service.BaseManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * Created by Administrator on 2015/6/18.
 */
@Controller
@RequestMapping("/purchaseOrder")
public class PurchaseOrderController extends BaseController {

    @Autowired
    private  PurchaseOrderManager purchaseOrderManager;

    /**
     * ·¢»õ
     * ,PurchaseOrderDelivery purchaseOrderDelivery,Authentication authentication
     * @param purchaseOrder
     * @return
     */
    @RequestMapping("/updateOrderStatus.do")
    @ResponseBody
    public String updateOrderStatus(PurchaseOrder purchaseOrder){

        String id = "";
        try {
          id = purchaseOrderManager.updateOrderStatus(purchaseOrder);
        }catch (Exception e){
            e.printStackTrace();
        }

        return  id;
    }


}
