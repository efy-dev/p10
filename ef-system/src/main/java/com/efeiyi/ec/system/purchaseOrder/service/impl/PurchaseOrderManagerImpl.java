package com.efeiyi.ec.system.purchaseOrder.service.impl;

import com.efeiyi.ec.organization.model.MyUser;
import com.efeiyi.ec.purchase.model.PurchaseOrder;
import com.efeiyi.ec.purchase.model.PurchaseOrderDelivery;
import com.efeiyi.ec.system.organization.util.AuthorizationUtil;
import com.efeiyi.ec.system.purchaseOrder.dao.PurchaseOrderDao;
import com.efeiyi.ec.system.purchaseOrder.service.PurchaseOrderManager;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.p.service.AutoSerialManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Created by IntelliJ IDEA.
 * User: ming
 * Date: 12-10-15
 * Time: ÏÂÎç5:02
 * To change this template use File | Settings | File Templates.
 */

@Service
@Transactional
public class PurchaseOrderManagerImpl implements PurchaseOrderManager {

    @Autowired
    private PurchaseOrderDao purchaseOrderDao;

    @Autowired
    private AutoSerialManager autoSerialManager;

    @Autowired
    private BaseManager baseManager;



    @Override
    public String updateOrderStatus(PurchaseOrder purchaseOrder) {

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
        try {
            purchaseOrderDao.updateOrderStatus(purchaseOrder);
            String serial = autoSerialManager.nextSerial("purchaseOrderDelivery");
            PurchaseOrderDelivery purchaseOrderDelivery = new PurchaseOrderDelivery();
            purchaseOrderDelivery.setPurchaseOrder(purchaseOrder);
            purchaseOrderDelivery.setCreateDateTime(new Date());
            purchaseOrderDelivery.setSerial(serial);
            MyUser user = AuthorizationUtil.getMyUser();
            System.out.println(user.getFullName());
            //purchaseOrderDelivery.setConsumerAddress();
            purchaseOrderDelivery.setStatus("1");
            baseManager.saveOrUpdate("PurchaseOrderDelivery.class", purchaseOrderDelivery);
        }catch (Exception e){
            e.printStackTrace();
        }
        return purchaseOrder.getId();
    }
}
