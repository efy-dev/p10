package com.efeiyi.ec.website.order.service.impl;

import com.efeiyi.ec.organization.model.MyUser;
import com.efeiyi.ec.organization.model.User;
import com.efeiyi.ec.product.model.Product;
import com.efeiyi.ec.product.model.ProductModel;
import com.efeiyi.ec.purchase.model.Cart;
import com.efeiyi.ec.purchase.model.CartProduct;
import com.efeiyi.ec.tenant.model.Tenant;
import com.efeiyi.ec.website.order.service.CartManager;
import com.efeiyi.ec.website.order.service.StockManager;
import com.efeiyi.ec.website.organization.util.AuthorizationUtil;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
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

    @Autowired
    private StockManager stockManager;

    private void updateTotalPrice(Cart cart) {
        BigDecimal totalPrice = new BigDecimal(0);
        for (CartProduct cartProductTemp : cart.getCartProductList()) {
            ProductModel productModel = (ProductModel) baseManager.getObject(ProductModel.class.getName(), cartProductTemp.getProductModel().getId());
            cartProductTemp.setProductModel(productModel);
            if (cartProductTemp.getIsChoose() != null && cartProductTemp.getIsChoose().equals("1")) {
                totalPrice = totalPrice.add(cartProductTemp.getProductModel().getPrice().multiply(new BigDecimal(cartProductTemp.getAmount())));
            }
        }
        totalPrice = totalPrice.setScale(2, BigDecimal.ROUND_HALF_UP);
        cart.setTotalPrice(totalPrice);
    }

    @Override
    public Cart addToCart(Cart cart, ProductModel productModel, Integer count) {
        count = count != null ? count : 1;
        List<CartProduct> cartProductList = cart.getCartProductList();
        boolean isProductExist = false;
        if (cartProductList != null && cartProductList.size() > 0) {
            for (CartProduct cartProductTemp : cartProductList) {
                if (productModel.getId().equals(cartProductTemp.getProductModel().getId())) {
                    isProductExist = true;
                    if (cart.getId() == null) {
                        cartProductTemp.setProductModel((ProductModel) baseManager.getObject(ProductModel.class.getName(), cartProductTemp.getProductModel().getId()));
                    }
                    if (stockManager.isOutOfStock(cartProductTemp.getProductModel(), cartProductTemp.getAmount() + count)) {
                        cartProductTemp.setAmount(cartProductTemp.getProductModel().getAmount());
                    } else {
                        cartProductTemp.setAmount(cartProductTemp.getAmount() + count);
                    }
                    if (cart.getId() == null) {
                        cartProductTemp.setCart(null);
                    }
                    cartProductTemp.setIsChoose("1");
                    baseManager.saveOrUpdate(CartProduct.class.getName(), cartProductTemp);
                    break;
                }
            }
        }
        if (!isProductExist) {
            CartProduct cartProduct = new CartProduct();
            cartProduct.setProductModel(productModel);
            cartProduct.setAmount(count);
            if (cart.getId() != null) {
                cartProduct.setCart(cart);
            }
            cartProduct.setIsChoose("1");
            cartProduct.setStatus("1");
            baseManager.saveOrUpdate(CartProduct.class.getName(), cartProduct);
            cartProductList.add(cartProduct);
        }
        updateTotalPrice(cart);
        if (cart.getId() != null) {
            baseManager.saveOrUpdate(Cart.class.getName(), cart);
        }
        return cart;
    }

    @Override
    public Cart removeFromCart(Cart cart, CartProduct cartProduct) {
        baseManager.remove(CartProduct.class.getName(), cartProduct.getId());
        for (CartProduct cartProductTemp : cart.getCartProductList()) {
            if (cartProductTemp.getId().equals(cartProduct.getId())) {
                cart.getCartProductList().remove(cartProductTemp);
                break;
            }
        }
        updateTotalPrice(cart);
        if (cart.getId() != null) {
            baseManager.saveOrUpdate(Cart.class.getName(), cart);
        }
        return cart;
    }

    @Override
    public Cart fetchCart() {
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


    @Override
    public Cart fetchCart(String userId){
        Cart cart;
        String hql = "select obj from " + Cart.class.getName() + " obj where obj.user.id=:userid";
        LinkedHashMap<String, Object> param = new LinkedHashMap<>();
        param.put("userid", userId);
        cart = (Cart) baseManager.getUniqueObjectByConditions(hql, param);
        return cart;
    }


    @Override
    public Cart copyCart(Cart cart) {
        Cart realCart = fetchCart();
        if (cart != null) {
            List<CartProduct> cartProductList = cart.getCartProductList();
            for (CartProduct cartProductTemp : cartProductList) {
                cartProductTemp.setCart(realCart);
                realCart.getCartProductList().add(cartProductTemp);
                baseManager.saveOrUpdate(CartProduct.class.getName(), cartProductTemp);
                updateTotalPrice(realCart);
                baseManager.saveOrUpdate(Cart.class.getName(), realCart);
            }
        }
        return realCart;
    }

    @Override
    public CartProduct addCount(Cart cart, CartProduct cartProduct) {
        if (!stockManager.isOutOfStock(cartProduct.getProductModel(), cartProduct.getAmount() + 1)) {
            cartProduct.setAmount(cartProduct.getAmount() + 1);
            baseManager.saveOrUpdate(CartProduct.class.getName(), cartProduct);
            for (CartProduct cartProductTemp : cart.getCartProductList()) {
                if (cartProductTemp.getId().equals(cartProduct.getId())) {
                    cartProductTemp.setAmount(cartProduct.getAmount());
//                    cartProductTemp = cartProduct;
                    break;
                }
            }
            cartProduct.setCartCatch(cart);
        } else {
            cartProduct = null;
        }
        updateTotalPrice(cart);
        if (cart.getId() != null) {
            baseManager.saveOrUpdate(Cart.class.getName(), cart);
        }
        return cartProduct;
    }

    @Override
    public CartProduct subtractCount(Cart cart, CartProduct cartProduct) {
        if (cartProduct.getAmount() - 1 > 0) {
            cartProduct.setAmount(cartProduct.getAmount() - 1);
            baseManager.saveOrUpdate(CartProduct.class.getName(), cartProduct);
            for (CartProduct cartProductTemp : cart.getCartProductList()) {
                if (cartProductTemp.getId().equals(cartProduct.getId())) {
                    cartProductTemp.setAmount(cartProduct.getAmount());
                    break;
                }
            }
            cartProduct.setCartCatch(cart);
        } else {
            cartProduct = null;
        }
        updateTotalPrice(cart);
        if (cart.getId() != null) {
            baseManager.saveOrUpdate(Cart.class.getName(), cart);
        }
        return cartProduct;
    }

    @Override
    public CartProduct changeCount(Cart cart, CartProduct cartProduct, Integer count) {
        cartProduct.getProductModel().setAmount(count);
        if (!stockManager.isOutOfStock(cartProduct.getProductModel(), cartProduct.getAmount())) {
            cartProduct.setAmount(cartProduct.getAmount() - 1);
            baseManager.saveOrUpdate(CartProduct.class.getName(), cartProduct);
            for (CartProduct cartProductTemp : cart.getCartProductList()) {
                if (cartProductTemp.getId().equals(cartProduct.getId())) {
                    cartProductTemp.setAmount(cartProduct.getAmount());
                    break;
                }
            }
            cartProduct.setCartCatch(cart);
        } else {
            cartProduct = null;
        }
        updateTotalPrice(cart);
        if (cart.getId() != null) {
            baseManager.saveOrUpdate(Cart.class.getName(), cart);
        }
        return cartProduct;
    }

    @Override
    public Cart chooseProduct(Cart cart, CartProduct cartProduct, String chooseStatus) {
        cartProduct.setIsChoose(chooseStatus);
        baseManager.saveOrUpdate(CartProduct.class.getName(), cartProduct);
        for (CartProduct cartProductTemp : cart.getCartProductList()) {
            if (cartProductTemp.getId().equals(cartProduct.getId())) {
                cartProductTemp.setIsChoose(cartProduct.getIsChoose());
//                cartProductTemp = cartProduct;
                break;
            }
        }
        updateTotalPrice(cart);
        if (cart.getId() != null) {
            baseManager.saveOrUpdate(Cart.class.getName(), cart);
        }
        return cart;
    }

    @Override
    public Cart chooseTenant(Cart cart, Tenant tenant, String chooseStatus) {
        List<CartProduct> cartProductList = cart.getCartProductList();
        for (CartProduct cartProductTemp : cartProductList) {
            CartProduct cartProductTemp2 = (CartProduct) baseManager.getObject(CartProduct.class.getName(), cartProductTemp.getId());
            if (cartProductTemp2.getProductModel().getProduct().getTenant().getId().equals(tenant.getId())) {
                cartProductTemp2.setIsChoose(chooseStatus);
                cartProductTemp.setIsChoose(chooseStatus);
                baseManager.saveOrUpdate(CartProduct.class.getName(), cartProductTemp2);
            }
        }
        updateTotalPrice(cart);
        baseManager.saveOrUpdate(Cart.class.getName(), cart);
        return cart;
    }

    @Override
    public Cart chooseAll(Cart cart, String chooseStatus) {
        List<CartProduct> cartProductList = cart.getCartProductList();

        for (CartProduct cartProductTemp : cartProductList) {
            cartProductTemp.setIsChoose(chooseStatus);
            baseManager.saveOrUpdate(CartProduct.class.getName(), cartProductTemp);
        }

        updateTotalPrice(cart);
        baseManager.saveOrUpdate(Cart.class.getName(), cart);
        return cart;
    }
}
