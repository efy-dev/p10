package com.efeiyi.pal.system.label.controller;

import com.efeiyi.pal.label.model.LabelBatch;
import com.efeiyi.pal.organization.model.Tenant;
import com.efeiyi.pal.product.model.Product;
import com.efeiyi.pal.purchase.model.PurchaseOrder;
import com.ming800.core.base.dao.XdoDao;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.base.service.XdoManager;
import com.ming800.core.base.util.XDoUtil;
import com.ming800.core.does.model.Do;
import com.ming800.core.does.service.DoHandler;
import com.ming800.core.util.ApplicationContextUtil;
import org.springframework.ui.ModelMap;

import javax.servlet.http.HttpServletRequest;

/**
 * Created by Administrator on 2015/7/23.
 */

public class LabelBatchHandler implements DoHandler {

    private BaseManager baseManager = (BaseManager) ApplicationContextUtil.getApplicationContext().getBean("baseManagerImpl");
    private XdoManager xdoManager = (XdoManager) ApplicationContextUtil.getApplicationContext().getBean("xdoManagerImpl");
    private XdoDao xdoDao = (XdoDao) ApplicationContextUtil.getApplicationContext().getBean("xdoDaoSupport");

    @Override
    public ModelMap handle(ModelMap modelMap, HttpServletRequest request) throws Exception {

        LabelBatch labelBatch = new LabelBatch();

        String labelBatchId = request.getParameter("id");
        String type = "new";
        if (labelBatchId != null && !labelBatchId.equals("")) {
            type = "edit";
            labelBatch = (LabelBatch) baseManager.getObject(LabelBatch.class.getName(), labelBatchId);
        }
        Do tempDo = (Do) modelMap.get("tempDo");
        labelBatch = (LabelBatch) XDoUtil.processSaveOrUpdateTempObject(tempDo, labelBatch, labelBatch.getClass(), request, type, xdoDao);

        labelBatch = getRelationAttributeObject(labelBatch, request);

        modelMap.put("object", labelBatch);
        return modelMap;
    }

    /**
     * 获取关联属性的对象
     * @param labelBatch
     * @param request
     * @return
     */
    private LabelBatch getRelationAttributeObject(LabelBatch labelBatch, HttpServletRequest request){
        String productId = request.getParameter("product.id");
        String tenantId = request.getParameter("tenant.id");
        String purchaseOrderId = request.getParameter("purchaseOrder.id");

        Product product = (Product) baseManager.getObject(Product.class.getName(), productId);
        Tenant tenant = (Tenant) baseManager.getObject(Tenant.class.getName(), tenantId);
//        PurchaseOrder purchaseOrder = (PurchaseOrder) baseManager.getObject(PurchaseOrder.class.getName(), purchaseOrderId);
        PurchaseOrder purchaseOrder = null;

        labelBatch.setProduct(product);
        labelBatch.setTenant(tenant);
        labelBatch.setPurchaseOrder(purchaseOrder);

        return labelBatch;
    }

}
