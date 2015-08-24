package com.efeiyi.ec.system.purchaseOrder.controller;



import com.efeiyi.ec.organization.model.MyUser;
import com.efeiyi.ec.product.model.Product;
import com.efeiyi.ec.purchase.model.PurchaseOrder;
import com.efeiyi.ec.purchase.model.PurchaseOrderDelivery;
import com.efeiyi.ec.system.organization.util.AuthorizationUtil;
import com.efeiyi.ec.system.purchaseOrder.service.PurchaseOrderManager;
import com.ming800.core.base.controller.BaseController;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import com.ming800.core.p.service.AutoSerialManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

/**
 * Created by Administrator on 2015/6/18.
 */
@Controller
@RequestMapping("/purchaseOrder")
public class PurchaseOrderController extends BaseController {
    @Autowired
    private BaseManager baseManager;

    @Autowired
    private  PurchaseOrderManager purchaseOrderManager;

    /**
     * 发货
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
