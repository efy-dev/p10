package com.efeiyi.ec.system.purchaseOrder.controller;



import com.efeiyi.ec.purchase.model.PurchaseOrder;
import com.efeiyi.ec.system.purchaseOrder.service.PurchaseOrderManager;
import com.ming800.core.base.controller.BaseController;
import com.ming800.core.base.service.BaseManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * Created by Administrator on 2015/6/18.
 */
@Controller
@RequestMapping("/purchaseOrder")
public class PurchaseOrderController extends BaseController {

    @Autowired
    private  PurchaseOrderManager purchaseOrderManager;

    @Autowired
    private BaseManager baseManager;

    /**
     * ����
     * ,PurchaseOrderDelivery purchaseOrderDelivery,Authentication authentication
     * @param purchaseOrder
     * @return
     */
    @RequestMapping("/updateOrderStatus.do")
    @ResponseBody
    public String updateOrderStatus(PurchaseOrder purchaseOrder,HttpServletRequest request){

        String logisticsCompany = request.getParameter("logisticsCompany");
        String serial = request.getParameter("serial");
        String id = "";
        purchaseOrder = (PurchaseOrder) baseManager.getObject(PurchaseOrder.class.getName(),purchaseOrder.getId());
        try {
            if(null == purchaseOrder.getFatherPurchaseOrder()){//如果是父订单发货 所有的子订单都得变成已发货状态
                purchaseOrder.setOrderStatus("7");
                id = purchaseOrderManager.updateOrderStatus(purchaseOrder,serial,logisticsCompany);
                List<PurchaseOrder> subPurchaseOrderList = purchaseOrder.getSubPurchaseOrder();
                if(null != subPurchaseOrderList && subPurchaseOrderList.size() > 0){
                    PurchaseOrder p1 = null;
                    for(int i = 0;i < subPurchaseOrderList.size();i++){
                        p1 = subPurchaseOrderList.get(i);
                        if("1".equals(p1.getOrderStatus()) || "5".equals(p1.getOrderStatus())){
                            p1.setOrderStatus("7");
                            purchaseOrderManager.updateOrderStatus(p1);
                        }
                    }
                }
            }else{
                PurchaseOrder fPurchaseOrder = purchaseOrder.getFatherPurchaseOrder();
                List<PurchaseOrder> subPurchaseOrderList = fPurchaseOrder.getSubPurchaseOrder();
                PurchaseOrder p = null;
                for (int i = 0;i < subPurchaseOrderList.size();i++){
                    p = subPurchaseOrderList.get(i);

                    if(p.getId().equals(purchaseOrder.getId())){//在子订单列表中找到自己
                        if (i == subPurchaseOrderList.size()-1){//如果自己是最后一个并且前面的子订单都是已发货的，修改父订单状态，修改自己状态
                            fPurchaseOrder.setOrderStatus("7");
                            purchaseOrderManager.updateOrderStatus(fPurchaseOrder);
                            purchaseOrder.setOrderStatus("7");
                            id = purchaseOrderManager.updateOrderStatus(purchaseOrder,serial,logisticsCompany);
                            break;
                        }else {//如果自己不在列表的最后一个
                            continue;
                        }
                    }

                    if("1".equals(p.getOrderStatus()) || "5".equals(p.getOrderStatus())){//如果有未发货的就修改自己 然后跳出循环
//                        if(i == subPurchaseOrderList.size()-1){//如果循环到了最后一个 并且最后一个不是自己并且前面没有未发货的
//                            fPurchaseOrder.setOrderStatus("7");
//                            purchaseOrderManager.updateOrderStatus(fPurchaseOrder);
//                            purchaseOrder.setOrderStatus("7");
//                            id = purchaseOrderManager.updateOrderStatus(purchaseOrder,serial,logisticsCompany);
//                            p.setOrderStatus("7");
//                            purchaseOrderManager.updateOrderStatus(p);
//                        }else{//如果有未发货的并且不是列表的最后一个 修改自己状态 跳出循环
                            purchaseOrder.setOrderStatus("7");
                            id = purchaseOrderManager.updateOrderStatus(purchaseOrder,serial,logisticsCompany);
//                        }
                        break;
                    }
                    if(i == subPurchaseOrderList.size()-1){//如果循环到了最后一个 并且最后一个不是自己并且前面没有未发货的
                        fPurchaseOrder.setOrderStatus("7");
                        purchaseOrderManager.updateOrderStatus(fPurchaseOrder);
                        purchaseOrder.setOrderStatus("7");
                        id = purchaseOrderManager.updateOrderStatus(purchaseOrder,serial,logisticsCompany);
                    }

                }
            }

        }catch (Exception e){
            e.printStackTrace();
        }

        return  id;
    }

    @RequestMapping("/saveReceiver.do")
    @ResponseBody
    public void saveReceiver(HttpServletRequest request){
        String name = request.getParameter("name");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String purchaseOrderId = request.getParameter("id");

        PurchaseOrder purchaseOrder = (PurchaseOrder) baseManager.getObject(PurchaseOrder.class.getName(),purchaseOrderId);

        if (null == purchaseOrder.getFatherPurchaseOrder()){
            List<PurchaseOrder> list = purchaseOrder.getSubPurchaseOrder();
            PurchaseOrder subPurchaseOrder = null;
            for(int i = 0;i < list.size();i++){
                subPurchaseOrder = list.get(i);
                subPurchaseOrder.setReceiverPhone(phone);
                subPurchaseOrder.setReceiverName(name);
                subPurchaseOrder.setPurchaseOrderAddress(address);
                baseManager.saveOrUpdate(PurchaseOrder.class.getName(),subPurchaseOrder);
            }
            purchaseOrder.setPurchaseOrderAddress(address);
            purchaseOrder.setReceiverName(name);
            purchaseOrder.setReceiverPhone(phone);
            baseManager.saveOrUpdate(PurchaseOrder.class.getName(),purchaseOrder);
        }else{
            purchaseOrder.setPurchaseOrderAddress(address);
            purchaseOrder.setReceiverName(name);
            purchaseOrder.setReceiverPhone(phone);
            baseManager.saveOrUpdate(PurchaseOrder.class.getName(),purchaseOrder);
        }
    }
}
