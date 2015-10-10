package com.efeiyi.ec.website.order.service.impl;

import com.efeiyi.ec.organization.model.MyUser;
import com.efeiyi.ec.organization.model.User;
import com.efeiyi.ec.purchase.model.Cart;
import com.efeiyi.ec.purchase.model.CartProduct;
import com.efeiyi.ec.website.order.service.CartManager;
import com.efeiyi.ec.website.organization.util.AuthorizationUtil;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;

/**
 * Created by Administrator on 2015/10/10 0010.
 */
@Service
public class CartManagerImpl implements CartManager {

    @Autowired
    private BaseManager baseManager;

    //初始化购物车
    public Cart initCart() {
        MyUser bigUser = AuthorizationUtil.getMyUser();
        Cart cart;
        String hql = "select obj from " + Cart.class.getName() + " obj where obj.user.id=:userid";
        LinkedHashMap<String, Object> param = new LinkedHashMap<>();
        param.put("userid", bigUser.getId());

        cart = (Cart) baseManager.getUniqueObjectByConditions(hql, param);
        if (cart == null && bigUser.getId() != null) {
            User user = new User();
            user.setId(bigUser.getId());
            cart = new Cart();
            cart.setUser(user);
            cart.setCreateDatetime(new Date());
            cart.setCartProductList(new ArrayList<CartProduct>());
            baseManager.saveOrUpdate(Cart.class.getName(), cart);
        }
        return cart;
    }

}
