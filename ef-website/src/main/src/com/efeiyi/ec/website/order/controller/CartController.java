package com.efeiyi.ec.website.order.controller;

import com.efeiyi.ec.product.model.Product;
import com.efeiyi.ec.purchase.model.Cart;
import com.efeiyi.ec.purchase.model.CartProduct;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * Created by Administrator on 2015/7/30.
 */
@Controller
public class CartController {


    @Autowired
    private BaseManager baseManager;

    @RequestMapping({"/cart/view"})
    public String viewCart(HttpServletRequest request, Model model) throws Exception {
        XQuery xQuery = new XQuery("listCart_default", request);
        List<Object> list = baseManager.listObject(xQuery);
        model.addAttribute("cart", list.get(0));
        return "/purchaseOrder/purchaseOrderList";
    }


    @RequestMapping({"/cart/addProduct.do"})
    @ResponseBody
    public boolean addProduct(HttpServletRequest request) throws Exception {
        String productId = request.getParameter("id");
        XQuery xQuery = new XQuery("listCart_default", request);
        List<Object> list = baseManager.listObject(xQuery);
        boolean ne = false;
        boolean ab = false;
        Cart cart = (Cart) list.get(0);
        XQuery xQuery1 = new XQuery("listCartProduct_default", request);
        xQuery1.put("cart_id", cart.getId());
        List<Object> list1 = baseManager.listObject(xQuery1);

        if (list1.size()>0) {
            for (Object cartProductTemp : list1) {
                CartProduct cartProduct = (CartProduct)cartProductTemp;
                if (productId.equals(cartProduct.getProduct().getId())) {
                    if (null != request.getParameter("amount") && "" != request.getParameter("amount")) {
                        cartProduct.setAmount(cartProduct.getAmount() + Integer.parseInt(request.getParameter("amount")));
                    } else {
                        cartProduct.setAmount(cartProduct.getAmount() + 1);
                    }
                    baseManager.saveOrUpdate(CartProduct.class.getName(), cartProduct);

                    ab = true;
                    ne = true;

                }
            }
        }
        if (!ne) {
            Product product = new Product();
            product.setId(productId);
            CartProduct cartProduct = new CartProduct();
            cartProduct.setProduct(product);
            cartProduct.setCart(cart);
            cartProduct.setStatus("1");
            if (null != request.getParameter("amount") && "" != request.getParameter("amount")) {
                cartProduct.setAmount(Integer.parseInt(request.getParameter("amount")));
            } else {
                cartProduct.setAmount(1);
            }
            baseManager.saveOrUpdate(CartProduct.class.getName(), cartProduct);
            ab = true;
        }
        return ab;
    }

/*
        XQuery xQuery1 = new XQuery("listCartProduct_default", request);
        xQuery.put("cart_id",cart.getId());

        List<Object> list1 = baseManager.listObject(xQuery1);

        list1.add(cartProduct);

        cart.setCartProductList((List)list1);
        baseManager.saveOrUpdate(Cart.class.getName(), cart);
        return true;*/



    @RequestMapping({"/cart/removeProduct.do"})
    @ResponseBody
    public boolean removeProduct(HttpServletRequest request) throws Exception {
        String cartProductId = request.getParameter("cartProductId");
        baseManager.remove(CartProduct.class.getName(), cartProductId);
        return true;
    }


    @RequestMapping({"/cart/addProductCount"})
    @ResponseBody
    public boolean addProductCount(HttpServletRequest request) {
        String cartProductId = request.getParameter("cartProductId");
        CartProduct cartProduct = (CartProduct) baseManager.getObject(CartProduct.class.getName(), cartProductId);
        cartProduct.setAmount(cartProduct.getAmount() + 1);
        baseManager.saveOrUpdate(CartProduct.class.getName(), cartProduct);
        return true;
    }

    @RequestMapping({"/cart/subtractProductCount"})
    @ResponseBody
    public boolean subtractProductCount(HttpServletRequest request) {
        String cartProductId = request.getParameter("cartProductId");
        CartProduct cartProduct = (CartProduct) baseManager.getObject(CartProduct.class.getName(), cartProductId);
        if (cartProduct.getAmount() > 0) {
            cartProduct.setAmount(cartProduct.getAmount() - 1);
        }
        baseManager.saveOrUpdate(CartProduct.class.getName(), cartProduct);
        return true;
    }


}
