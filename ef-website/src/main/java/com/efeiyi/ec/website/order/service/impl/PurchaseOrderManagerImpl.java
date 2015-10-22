package com.efeiyi.ec.website.order.service.impl;

import com.efeiyi.ec.purchase.model.Cart;
import com.efeiyi.ec.purchase.model.CartProduct;
import com.efeiyi.ec.purchase.model.PurchaseOrder;
import com.efeiyi.ec.purchase.model.PurchaseOrderProduct;
import com.efeiyi.ec.website.order.service.PurchaseOrderManager;
import com.efeiyi.ec.website.organization.util.AuthorizationUtil;
import com.ming800.core.base.service.BaseManager;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;

/**
 * Created by Administrator on 2015/10/21 0021.
 */
public class PurchaseOrderManagerImpl implements PurchaseOrderManager {

    @Autowired
    private BaseManager baseManager;

    @Override
    public PurchaseOrder saveOrUpdatePurchaseOrder(Cart cart) {

        PurchaseOrder purchaseOrder = createNewPurchaseOrder(cart.getCartProductList());
        return purchaseOrder;

    }

    private PurchaseOrder createNewPurchaseOrder(List<CartProduct> cartProductList) {

        PurchaseOrder purchaseOrder = new PurchaseOrder();
        purchaseOrder.setUser(AuthorizationUtil.getMyUser());
        baseManager.saveOrUpdate(PurchaseOrder.class.getName(), purchaseOrder);

        if (cartProductList != null && cartProductList.size() > 0) {
            for (CartProduct cartProduct : cartProductList) {
                PurchaseOrderProduct purchaseOrderProduct = new PurchaseOrderProduct(purchaseOrder,cartProduct.getProductModel(),cartProduct.getAmount(),cartProduct.getProductModel().getPrice());
                baseManager.saveOrUpdate(PurchaseOrderProduct.class.getName(),purchaseOrderProduct);
            }
        }
        return purchaseOrder;
    }

    @Override
    public PurchaseOrder confirmPurchaseOrder(PurchaseOrder purchaseOrder) {
        return null;
    }
}
