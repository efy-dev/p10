package com.efeiyi.ec.system.purchaseOrderDelivery.controller;

import com.ming800.core.base.controller.BaseController;
import com.ming800.core.p.service.CommonManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;

/**
 * Created by Administrator on 2015/9/10.
 */
@Controller
@RequestMapping("/purchaseOrderDelivery")
public class PurchaseOrderDeliveryController extends BaseController {

    @Autowired
    private CommonManager commonManager;

    @RequestMapping("/getLogisticsCompany.do")
    @ResponseBody
    public HashMap getLogisticsCompany() throws Exception {
        return commonManager.getLogisticsCompany();
    }
}
