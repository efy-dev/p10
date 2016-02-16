package com.efeiyi.ec.website.order.service;

import com.efeiyi.ec.product.model.ProductModel;
import com.efeiyi.ec.purchase.model.Cart;
import com.efeiyi.ec.purchase.model.CartProduct;
import com.efeiyi.ec.purchase.model.PurchaseOrder;
import com.efeiyi.ec.tenant.model.Tenant;

import javax.servlet.http.HttpServletRequest;

/**
 * Created by Administrator on 2015/10/10 0010.
 * <p/>
 * 购物车中的操作包括一下几个
 * 1.增加某件商品的数量
 * 2.减掉某件商品的数量
 * 3.改变某件商品的数量
 * 4.添加指定数量的某件商品到购物车中（未制定数量的，数量默认为1）
 * 5.选中某件商品
 * 6.选中购物车中某个店铺的商品
 * 7.选中全部的商品
 * 8.计算购物车中已经选中商品的价钱（可以是私有操作） 在controller中不需要知道如何计算 直接返回Cart
 */
public interface CartManager {

    /**
     * 初始化当前用户的购物车 是否登陆的判断放到Controller中去处理，如果登陆 那么就直接fetchCart获取购物车，如果未登陆，就直接取session中的Cart CartManager中需要添加一个临时变量存储cart
     */
    Cart addToCart(Cart cart, ProductModel productModel, Integer count);

    Cart removeFromCart(Cart cart, CartProduct cartProduct);

    Cart fetchCart();

    Cart getCurrentCart(HttpServletRequest request);

    Cart fetchCart(String userId);

    CartProduct addCount(Cart cart, CartProduct cartProduct);

    CartProduct subtractCount(Cart cart, CartProduct cartProduct);

    CartProduct changeCount(Cart cart, CartProduct cartProduct, Integer count);

    Cart chooseProduct(Cart cart, CartProduct cartProduct, String chooseStatus);

    Cart chooseTenant(Cart cart, Tenant tenant, String chooseStatus);

    Cart chooseAll(Cart cart, String chooseStatus);

    Cart copyCart(Cart sessionCart,Cart realCart);

    void clearCart(HttpServletRequest request, PurchaseOrder purchaseOrder);


}
