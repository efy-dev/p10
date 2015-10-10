package com.efeiyi.ec.website.order.service;

import com.efeiyi.ec.purchase.model.Cart;

/**
 * Created by Administrator on 2015/10/10 0010.
 */
public interface CartManager {

    /**
     * 初始化当前用户的购物车
     */
    Cart initCart();
}
