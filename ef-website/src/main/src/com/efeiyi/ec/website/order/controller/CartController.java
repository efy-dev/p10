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
        String productId = request.getParameter("productId");
        XQuery xQuery = new XQuery("listCart_default", request);
        List<Object> list = baseManager.listObject(xQuery);
        Product product = new Product();
        product.setId(productId);
        CartProduct cartProduct = new CartProduct();
        cartProduct.setProduct(product);
        Cart cart = (Cart) list.get(0);
        cart.getCartProductList().add(cartProduct);
        baseManager.saveOrUpdate(Cart.class.getName(), cart);
        return true;
    }


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
