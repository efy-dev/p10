package com.efeiyi.ec.system.purchaseOrderDelivery.controller;

import com.efeiyi.ec.purchase.model.PurchaseOrderDelivery;
import com.ming800.core.base.controller.BaseController;
import com.ming800.core.p.service.CommonManager;
import org.hibernate.Query;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
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

    @Autowired
    @Qualifier("sessionFactory")
    private SessionFactory sessionFactory;

    /**
     * 得到所有的物流公司
     * */
    @RequestMapping("/getLogisticsCompany.do")
    @ResponseBody
    public HashMap getLogisticsCompany() throws Exception {
        return commonManager.getLogisticsCompany();
    }

    /**
     * 修改发货记录的物流公司或者物流单号
     */
    @RequestMapping("/updatePurchaseOrderDelivery.do")
    @ResponseBody
    public void updatePurchaseOrderDelivery(PurchaseOrderDelivery purchaseOrderDelivery) {
        String hql = "update PurchaseOrderDelivery set logisticsCompany=?,serial=? where id=?";
        Query query = this.sessionFactory.getCurrentSession().createQuery(hql)
                .setParameter(0, purchaseOrderDelivery.getLogisticsCompany())
                .setParameter(1, purchaseOrderDelivery.getSerial())
                .setParameter(2, purchaseOrderDelivery.getId());
        query.executeUpdate();
    }
}

