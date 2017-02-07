package com.efeiyi.ec.website.order.service.impl;

import com.efeiyi.ec.purchase.model.PrepaidCard;
import com.efeiyi.ec.purchase.model.PrepaidCardRecord;
import com.efeiyi.ec.purchase.model.PurchaseOrder;
import com.efeiyi.ec.purchase.model.PurchaseOrderProduct;
import com.efeiyi.ec.website.order.service.PrepaidCardManager;
import com.ming800.core.base.service.BaseManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;

@Service
public class PrepaidCardManagerImpl implements PrepaidCardManager {

    private final static String tenantId = "iugd2v0v7mbwxumv";


    private BaseManager baseManager;

    @Autowired
    public PrepaidCardManagerImpl(BaseManager baseManager) {
        this.baseManager = baseManager;
    }

    @Override
    public PrepaidCardRecord createPrepaidCardRecord(PurchaseOrder order, PrepaidCard prepaidCard) {
        List<PurchaseOrderProduct> tenantProductList = new ArrayList<>();
        for (PurchaseOrderProduct pProduct : order.getPurchaseOrderProductList()) {
            if (tenantId.equals(pProduct.getProductModel().getProduct().getTenant().getId())) {
                tenantProductList.add(pProduct);
            }
        }

        BigDecimal producesPrice = calculateProducesPrice(tenantProductList);
        BigDecimal prepaidCardBalance = prepaidCard.getBalance();

        PrepaidCardRecord prepaidCardRecord;
        if (producesPrice.compareTo(prepaidCardBalance) < 0) {
            prepaidCardRecord = new PrepaidCardRecord(producesPrice, order.getId(), prepaidCard, PrepaidCardRecord.TYPE_ADD);
        } else {
            prepaidCardRecord = new PrepaidCardRecord(prepaidCardBalance, order.getId(), prepaidCard, PrepaidCardRecord.TYPE_ADD);
        }

        baseManager.saveOrUpdate(PrepaidCardRecord.class.getName(), prepaidCardRecord);

        return prepaidCardRecord;
    }

    @Override
    public PrepaidCardRecord createPrepaidCardRecord(String orderId, PrepaidCard prepaidCard) {
        PurchaseOrder purchaseOrder = (PurchaseOrder) baseManager.getObject(PurchaseOrder.class.getName(), orderId);
        return this.createPrepaidCardRecord(purchaseOrder, prepaidCard);
    }

    private BigDecimal calculateProducesPrice(List<PurchaseOrderProduct> productList) {
        BigDecimal result = BigDecimal.valueOf(0);
        for (PurchaseOrderProduct product : productList) {
            result = result.add(product.getPurchasePrice().multiply(BigDecimal.valueOf(product.getPurchaseAmount())));
        }
        return result;
    }

    @Override
    public PrepaidCardRecord confirmPrepaidCardRecord(String purchaseOrderId) {
        PrepaidCardRecord prepaidCardRecord = getPrepaidCardRecordByOrderId(purchaseOrderId, PrepaidCardRecord.STATUS_INIT);
        if (prepaidCardRecord != null) {
            prepaidCardRecord.setStatus(PrepaidCardRecord.STATUS_USED);
            baseManager.saveOrUpdate(prepaidCardRecord.getClass().getName(), prepaidCardRecord);
        }
        return prepaidCardRecord;
    }

    @Override
    public PrepaidCardRecord getPrepaidCardRecordById(String prepaidCardRecordId) {
        return (PrepaidCardRecord) baseManager.getObject(PrepaidCardRecord.class.getName(), prepaidCardRecordId);
    }

    @Override
    public PrepaidCardRecord saveOrUpdatePrepaidCardRecord(PrepaidCardRecord prepaidCardRecord) {
        baseManager.saveOrUpdate(prepaidCardRecord.getClass().getName(), prepaidCardRecord);
        return prepaidCardRecord;
    }

    @Override
    public PrepaidCard getPrepaidCardById(String prepaidCardId) {
        return (PrepaidCard) baseManager.getObject(PrepaidCard.class.getName(), prepaidCardId);
    }

    @Override
    public PrepaidCard getPrepaidCardByCode(String code) {
        String hql = "select obj from PrepaidCard obj where obj.code=:code ";
        LinkedHashMap<String, Object> param = new LinkedHashMap<>();
        param.put("code", code);
        return (PrepaidCard) baseManager.getUniqueObjectByConditions(hql, param);
    }

    @Override
    public PrepaidCard saveOrUpdatePrepaidCard(PrepaidCard prepaidCard) {
        baseManager.saveOrUpdate(PrepaidCard.class.getName(), prepaidCard);
        return prepaidCard;
    }

    @Override
    public PrepaidCardRecord getPrepaidCardRecordByOrderId(String purchaseOrderId, String status) {
        String hql = "select obj from PrepaidCardRecord obj where obj.status=:status and obj.targetId=:targetId";
        LinkedHashMap<String, Object> param = new LinkedHashMap<>();
        param.put("status", status);
        param.put("targetId", purchaseOrderId);
        return (PrepaidCardRecord) baseManager.getUniqueObjectByConditions(hql, param);
    }
}
