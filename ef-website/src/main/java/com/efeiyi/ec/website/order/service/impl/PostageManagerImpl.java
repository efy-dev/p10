package com.efeiyi.ec.website.order.service.impl;

import com.efeiyi.ec.organization.model.ConsumerAddress;
import com.efeiyi.ec.purchase.model.PurchaseOrder;
import com.efeiyi.ec.purchase.model.PurchaseOrderProduct;
import com.efeiyi.ec.tenant.model.BigTenant;
import com.efeiyi.ec.website.order.service.FreightManager;
import com.efeiyi.ec.website.order.service.PostageManager;
import com.ming800.core.base.service.BaseManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;

/**
 * Created by Administrator on 2016/2/24.
 */
@Service
public class PostageManagerImpl implements PostageManager{
    @Autowired
    private FreightManager freightManager;

    @Autowired
    private BaseManager baseManager;

    @Override
    public BigDecimal getFreight(PurchaseOrder purchaseOrder, ConsumerAddress consumerAddress) {
        String reachProvince = consumerAddress.getProvince().getName();
        BigDecimal freight = new BigDecimal(0);
        if(purchaseOrder.getSubPurchaseOrder()!=null && purchaseOrder.getSubPurchaseOrder().size()>0){
            for (PurchaseOrder purchaseOrder1:purchaseOrder.getSubPurchaseOrder()){
                freight = freight.add(getFreight(purchaseOrder1,reachProvince));
            }
        }else {
            freight = getFreight(purchaseOrder,reachProvince);
        }
        return freight;
    }

    @Override
    public BigDecimal getFreight(PurchaseOrder purchaseOrder,String reachProvince) {
        reachProvince = reachProvince.substring(0,2);
        BigDecimal freight = new BigDecimal(0);
        float weight = 0;
        String startCity = "";
        String returnFreight = "";
        for (PurchaseOrderProduct purchaseOrderProduct:purchaseOrder.getPurchaseOrderProductList()){
            if(purchaseOrderProduct.getProductModel().getWeight() != null && !purchaseOrderProduct.getProductModel().getWeight().equals("")){
                if(purchaseOrderProduct.getProductModel().getFreeDelivery() == null || "".equals(purchaseOrderProduct.getProductModel().getFreeDelivery()) || purchaseOrderProduct.getProductModel().getFreeDelivery().equals("0")){
                    weight += purchaseOrderProduct.getProductModel().getWeight()*purchaseOrderProduct.getPurchaseAmount();
                }
            }
        }
        String tenantId = purchaseOrder.getTenant().getId();
        BigTenant bigTenant = (BigTenant)baseManager.getObject(BigTenant.class.getName(),tenantId);
        if(bigTenant.getAddressCity() == null || bigTenant.getAddressCity().equals("")){
            return new BigDecimal(0);
        }else {
            startCity = bigTenant.getAddressCity().getName();
            if(weight == 0) {
                returnFreight = "0.00";
            }else {
                returnFreight = freightManager.calculateFreight(weight,startCity,reachProvince);
            }
            if((!"error".equals(returnFreight))&&(!"false".equals(returnFreight))){
                freight = (freight.add(new BigDecimal(returnFreight))).setScale(2,BigDecimal.ROUND_HALF_UP);
            }else {
                freight = new BigDecimal(10.00);
            }
            return freight;
        }
    }

    @Override
    public boolean fetchFreight(String freight, BigDecimal returnFreight) {
        int r = returnFreight.compareTo(new BigDecimal(freight));
        if (r == 0){
            return true;
        }else {
            return false;
        }
    }
}

