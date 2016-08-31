//package com.efeiyi.ec.consumer.order.controller;
//
//import com.efeiyi.ec.organization.model.MyUser;
//import com.efeiyi.ec.purchase.model.Cart;
//import com.efeiyi.ec.purchase.model.CartProduct;
//import com.efeiyi.ec.website.base.util.AuthorizationUtil;
//import com.ming800.core.base.service.BaseManager;
//import com.ming800.core.does.model.XQuery;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.stereotype.Controller;
//import org.springframework.web.bind.annotation.RequestMapping;
//import org.springframework.web.bind.annotation.ResponseBody;
//
//import javax.servlet.http.HttpServletRequest;
//import java.util.List;
//
///**
// * Created by Administrator on 2015/7/30.
// */
//@Controller
//public class ConsumerCartController {
//
//
//    @Autowired
//    private BaseManager baseManager;
//
//
//    @RequestMapping({"/cart/cartAmount.do"})
//    @ResponseBody
//    public String getCartAmount(HttpServletRequest request) throws Exception {
//        MyUser user = AuthorizationUtil.getMyUser();
//        Cart cart;
//        if (user.getId() != null) {
//            XQuery xQuery = new XQuery("listCart_default", request);
//            List<Object> list = baseManager.listObject(xQuery);
//            cart = (Cart) list.get(0);
//        } else {
//            if (request.getSession().getAttribute("cart") != null) {
//                cart = (Cart) request.getSession().getAttribute("cart");
//            } else {
//                cart = new Cart();
//            }
//        }
//
//        if (cart.getCartProductList() == null || cart.getCartProductList().size() == 0) {
//            return "0";
//        } else {
//            return cart.getCartProductList().size() + "";
//        }
//    }
//
//    @RequestMapping({"/cart/cartCheck.do"})
//    @ResponseBody
//    public boolean cartCheck(HttpServletRequest request) {
//        Cart cart;
//        if (AuthorizationUtil.getMyUser().getId() != null) {
//            String cartId = request.getParameter("cartId");
//            cart = (Cart) baseManager.getObject(Cart.class.getName(), cartId);
//        } else {
//            cart = (Cart) request.getSession().getAttribute("cart");
//        }
//        Integer cartAmount = 0;
//        for (CartProduct cartProduct : cart.getCartProductList()) {
//            CartProduct cartProduct1 = (CartProduct) baseManager.getObject(CartProduct.class.getName(), cartProduct.getId());
//            if (cartProduct1.getIsChoose().equals("1")) {
//                cartAmount++;
//            }
//        }
//        if (cartAmount > 0) {
//            return true;
//        } else {
//            return false;
//        }
//
//    }
//
//
//}
