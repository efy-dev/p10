package com.efeiyi.ec.website.order.service.impl;

import com.efeiyi.ec.organization.model.ConsumerAddress;
import com.efeiyi.ec.product.model.ProductModel;
import com.efeiyi.ec.purchase.model.*;
import com.efeiyi.ec.tenant.model.Tenant;
import com.efeiyi.ec.website.order.service.PurchaseOrderManager;
import com.efeiyi.ec.website.organization.util.AuthorizationUtil;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XSaveOrUpdate;
import com.ming800.core.p.service.AutoSerialManager;
import org.hibernate.envers.AuditOverride;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashSet;
import java.util.List;

/**
 * Created by Administrator on 2015/10/21 0021.
 */
@Service
public class PurchaseOrderManagerImpl implements PurchaseOrderManager {

    @Autowired
    private BaseManager baseManager;

    @Autowired
    private AutoSerialManager autoSerialManager;

    @Override
    public PurchaseOrder saveOrUpdatePurchaseOrder(Cart cart, Model model) throws Exception {
        HashMap<String,List> productMap = new HashMap<>();
        PurchaseOrder purchaseOrder = createNewPurchaseOrder(cart.getCartProductList());
        LinkedHashSet<Tenant> tenantSet = new LinkedHashSet<>();
        List<CartProduct> cartProductList = cart.getCartProductList();
        for (CartProduct cartProductTemp : cartProductList) {
            if (cartProductTemp.getIsChoose().equals("1")) {
                cartProductTemp.setProductModel((ProductModel) baseManager.getObject(ProductModel.class.getName(), cartProductTemp.getProductModel().getId()));
                PurchaseOrderProduct purchaseOrderProduct = new PurchaseOrderProduct(purchaseOrder, cartProductTemp.getProductModel(), cartProductTemp.getAmount(), cartProductTemp.getProductModel().getPrice());
                baseManager.saveOrUpdate(PurchaseOrderProduct.class.getName(), purchaseOrderProduct);
                Tenant tenant = cartProductTemp.getProductModel().getProduct().getTenant();
                tenantSet.add(tenant);
                if (productMap.get(tenant.getId()) != null) {
                    productMap.get(tenant.getId()).add(cartProductTemp);
                } else {
                    List productList = new ArrayList();
                    productList.add(cartProductTemp);
                    productMap.put(tenant.getId(), productList);
                }
            }
        }
        if (tenantSet != null && tenantSet.size() > 1) {
            for (Tenant tenantTemp : tenantSet) {
                PurchaseOrder subPurchaseOrder = createNewPurchaseOrder(productMap.get(tenantTemp.getId()));
                subPurchaseOrder.setFatherPurchaseOrder(purchaseOrder);
                subPurchaseOrder.setTenant(tenantTemp);
                baseManager.saveOrUpdate(PurchaseOrder.class.getName(), subPurchaseOrder);
            }
        } else if (tenantSet != null && tenantSet.size() == 1) {
            purchaseOrder.setTenant(tenantSet.iterator().next());
            baseManager.saveOrUpdate(PurchaseOrder.class.getName(), purchaseOrder);
        }

        model.addAttribute("productMap", productMap);
        model.addAttribute("purchaseOrder", purchaseOrder);
        model.addAttribute("tenantList", tenantSet);

        return purchaseOrder;

    }

    private PurchaseOrder createNewPurchaseOrder(List<CartProduct> cartProductList) throws Exception {

        PurchaseOrder purchaseOrder = new PurchaseOrder();
        purchaseOrder.setUser(AuthorizationUtil.getMyUser());
        purchaseOrder.setSerial(autoSerialManager.nextSerial("orderSerial"));
        baseManager.saveOrUpdate(PurchaseOrder.class.getName(), purchaseOrder);

        BigDecimal totalPrice = new BigDecimal(0);
        if (cartProductList != null && cartProductList.size() > 0) {
            for (CartProduct cartProduct : cartProductList) {
                PurchaseOrderProduct purchaseOrderProduct = new PurchaseOrderProduct(purchaseOrder, cartProduct.getProductModel(), cartProduct.getAmount(), cartProduct.getProductModel().getPrice());
                totalPrice = totalPrice.add(cartProduct.getProductModel().getPrice().multiply(new BigDecimal(cartProduct.getAmount())));
                baseManager.saveOrUpdate(PurchaseOrderProduct.class.getName(), purchaseOrderProduct);
            }
            totalPrice = totalPrice.setScale(2, BigDecimal.ROUND_HALF_UP);
        }
        purchaseOrder.setTotal(totalPrice);
        purchaseOrder.setOriginalPrice(totalPrice);
        baseManager.saveOrUpdate(PurchaseOrder.class.getName(), purchaseOrder);
        return purchaseOrder;
    }

    @Override
    public PurchaseOrder confirmPurchaseOrder(PurchaseOrder purchaseOrder ,ConsumerAddress consumerAddress,HashMap<String, String> messageMap,String payWay) {
        String purchaseOrderAddress = (consumerAddress.getProvince() != null ? consumerAddress.getProvince().getName() : "") + " " + (consumerAddress.getCity() != null ? consumerAddress.getCity().getName() : "") + " " + (consumerAddress.getDetails() != null ? consumerAddress.getDetails() : "");
        purchaseOrder.setStatus("1");
        purchaseOrder.setPayWay(payWay);
//        purchaseOrder.setConsumerAddress(consumerAddress);
        purchaseOrder.setPurchaseOrderAddress(purchaseOrderAddress);
        purchaseOrder.setReceiverName(consumerAddress.getConsignee() != null ? consumerAddress.getConsignee() : "");
        purchaseOrder.setReceiverPhone(consumerAddress.getPhone() != null ? consumerAddress.getPhone() : "");
        if (purchaseOrder.getCoupon()!=null){
            Coupon coupon = purchaseOrder.getCoupon();
            coupon.setStatus("2");
            baseManager.saveOrUpdate(Coupon.class.getName(),coupon);
        }
        List<PurchaseOrder> subPurchaseOrderList = purchaseOrder.getSubPurchaseOrder();
        if (subPurchaseOrderList != null && subPurchaseOrderList.size() > 1) {
            for (PurchaseOrder purchaseOrderTemp : subPurchaseOrderList) {
                purchaseOrderTemp.setStatus("1");
                purchaseOrderTemp.setPurchaseOrderAddress(purchaseOrderAddress);
                purchaseOrderTemp.setReceiverName(consumerAddress.getConsignee() != null ? consumerAddress.getConsignee() : "");
                purchaseOrderTemp.setReceiverPhone(consumerAddress.getPhone() != null ? consumerAddress.getPhone() : "");
//                purchaseOrderTemp.setConsumerAddress(consumerAddress);
                purchaseOrderTemp.setMessage(messageMap.get(purchaseOrderTemp.getTenant().getId() + "Message"));
                purchaseOrderTemp.setPayWay(payWay);
                baseManager.saveOrUpdate(PurchaseOrder.class.getName(), purchaseOrderTemp);
            }
        } else {
            purchaseOrder.setMessage(messageMap.get(purchaseOrder.getTenant().getId() + "Message"));
        }
        baseManager.saveOrUpdate(PurchaseOrder.class.getName(), purchaseOrder);


        return purchaseOrder;
    }
}
