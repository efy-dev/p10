package com.efeiyi.pal.system.order.controller;

import com.efeiyi.pal.organization.model.Tenant;
import com.efeiyi.pal.organization.model.User;
import com.efeiyi.pal.purchase.model.PurchaseOrder;
import com.efeiyi.pal.purchase.model.PurchaseOrderLabel;
import com.efeiyi.pal.purchase.model.PurchaseOrderPayment;
import com.ming800.core.base.dao.XdoDao;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.base.util.XDoUtil;
import com.ming800.core.does.model.Do;
import com.ming800.core.does.service.DoHandler;
import com.ming800.core.util.ApplicationContextUtil;
import org.springframework.ui.ModelMap;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by Administrator on 2015/8/17.
 */
public class PurchaseOrderHandler implements DoHandler {

    private BaseManager baseManager = (BaseManager) ApplicationContextUtil.getApplicationContext().getBean("baseManagerImpl");
    private XdoDao xdoDao = (XdoDao) ApplicationContextUtil.getApplicationContext().getBean("xdoDaoSupport");

    @Override
    public ModelMap handle(ModelMap modelMap, HttpServletRequest request) throws Exception {
        PurchaseOrder purchaseOrder = new PurchaseOrder();

        String purchaseOrderId = request.getParameter("id");
        String type = "new";
        if (purchaseOrderId != null && !purchaseOrderId.equals("")) {
            type = "edit";
            purchaseOrder = (PurchaseOrder) baseManager.getObject(PurchaseOrder.class.getName(), purchaseOrderId);
        }
        Do tempDo = (Do) modelMap.get("tempDo");
        purchaseOrder = (PurchaseOrder) XDoUtil.processSaveOrUpdateTempObject(tempDo, purchaseOrder, purchaseOrder.getClass(), request, type, xdoDao);

        purchaseOrder = getRelationAttributeObject(purchaseOrder, request, type);

        modelMap.put("object", purchaseOrder);

        return modelMap;
    }

    /**
     * 获取关联属性的对象
     * @param purchaseOrder
     * @param request
     * @param type
     * @return
     */
    private PurchaseOrder getRelationAttributeObject(PurchaseOrder purchaseOrder, HttpServletRequest request, String type){
        String tenantId = request.getParameter("tenant.id");
        String userId = request.getParameter("user.id");

        Tenant tenant = (Tenant) baseManager.getObject(Tenant.class.getName(), tenantId);
        User user = (User) baseManager.getObject(User.class.getName(), userId);

        if (type.equals("new")){
            List<PurchaseOrderLabel> purchaseOrderLabelList = new ArrayList();
            purchaseOrder.setPurchaseOrderLabelList(purchaseOrderLabelList);
            List<PurchaseOrderPayment> purchaseOrderPaymentList = new ArrayList();
            purchaseOrder.setPurchaseOrderPaymentList(purchaseOrderPaymentList);
        }

        purchaseOrder.setTenant(tenant);
        purchaseOrder.setUser(user);

        return purchaseOrder;
    }

}
