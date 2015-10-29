package com.efeiyi.ec.website.order.controller;

import com.efeiyi.ec.organization.model.MyUser;
import com.efeiyi.ec.product.model.Product;
import com.efeiyi.ec.product.model.ProductModel;
import com.efeiyi.ec.purchase.model.Cart;
import com.efeiyi.ec.purchase.model.CartProduct;
import com.efeiyi.ec.tenant.model.Tenant;
import com.efeiyi.ec.website.order.service.CartManager;
import com.efeiyi.ec.website.organization.util.AuthorizationUtil;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

/**
 * Created by Administrator on 2015/7/30.
 */
@Controller
public class CartController {


    @Autowired
    private BaseManager baseManager;

    @Autowired
    private CartManager cartManager;

    @RequestMapping({"/cart/view"})
    public String viewCart(HttpServletRequest request, Model model) throws Exception {
        Cart cart = null;
        MyUser currentUser = AuthorizationUtil.getMyUser();
        if (currentUser.getId() != null) {
            cart = cartManager.fetchCart();
        } else {
            if (request.getSession().getAttribute("cart") != null) {
                cart = (Cart) request.getSession().getAttribute("cart");
            } else {
                cart = new Cart();
                cart.setCartProductList(new ArrayList<CartProduct>());
                request.getSession().setAttribute("cart", cart);
            }
        }

        List<Tenant> tenantListTemp = new ArrayList<>();
        List<Tenant> tenantList = new ArrayList<>();
        List<CartProduct> cartProductList = cart.getCartProductList();
        HashMap<String, List> productMap = new HashMap<>();
        for (CartProduct cartProduct : cartProductList) {
            if (cart.getId() != null) {
//            Tenant tenant = cartProduct.getProductModel().getProduct().getTenant();
                ProductModel productModel = cartProduct.getProductModel();
                Product product = productModel.getProduct();
                Tenant tenant = product.getTenant();
                tenantListTemp.add(tenant);
            } else {
                cartProduct = (CartProduct) baseManager.getObject(CartProduct.class.getName(), cartProduct.getId());
                ProductModel productModel = cartProduct.getProductModel();
                Product product = productModel.getProduct();
                Tenant tenant = product.getTenant();
                tenantListTemp.add(tenant);
            }
        }

        for (Tenant tenantTemp : tenantListTemp) {
            boolean isContain = false;
            for (Tenant tenant : tenantList) {
                if (tenant.getId().equals(tenantTemp.getId())) {
                    isContain = true;
                    break;
                } else {
                    isContain = false;
                }
            }
            if (!isContain) {
                tenantList.add(tenantTemp);
            }
        }

        for (Tenant tenant : tenantList) {
            List<Object> productList = new ArrayList<>();
            for (CartProduct cartProduct : cartProductList) {
                if (cart.getId() != null) {
                    if (cartProduct.getProductModel().getProduct().getTenant().getId().equals(tenant.getId())) {
                        productList.add(cartProduct);
                    }
                } else {
                    cartProduct = (CartProduct) baseManager.getObject(CartProduct.class.getName(), cartProduct.getId());
                    if (cartProduct.getProductModel().getProduct().getTenant().getId().equals(tenant.getId())) {
                        productList.add(cartProduct);
                    }
                }
            }
            productMap.put(tenant.getId(), productList);
        }

        model.addAttribute("tenantList", tenantList);
        model.addAttribute("productMap", productMap);
        model.addAttribute("cart", cart);
        return "/purchaseOrder/cart";
    }


    private Cart getCurrentCart(HttpServletRequest request) {
        Cart cart;
        if (AuthorizationUtil.isAuthenticated()) {
            cart = cartManager.fetchCart();
        } else {
            Object cartObj = request.getSession().getAttribute("cart");
            if (cartObj != null) {
                cart = (Cart) cartObj;
            } else {
                cart = new Cart();
                cart.setCartProductList(new ArrayList<CartProduct>());
                cart.setTotalPrice(new BigDecimal(0));
                request.getSession().setAttribute("cart",cart);
            }
        }
        return cart;
    }

    /*
        1.获取Cart （需要知道是否登陆来判断cart的来源，1.数据库 2.session）
        2.判断当前的商品是否在购物车中存在，如果存在单纯增加数量，在增加数量的时候需要判断库存

        在该方法中需要做的就是判断是否登陆得到购物车，然后取到ProductModel 调用CartManager的方法

     */
    @RequestMapping({"/cart/addProduct.do"})
    public String addProduct(HttpServletRequest request, Model model) throws Exception {
        String url = request.getParameter("redirect");
        if (url == null) {
            model.addAttribute("redirect", "");
        } else {
            model.addAttribute("redirect", url);
        }
        String productId = request.getParameter("id");
        ProductModel productModel = (ProductModel) baseManager.getObject(ProductModel.class.getName(), productId);
        cartManager.addToCart(getCurrentCart(request), productModel, Integer.parseInt(request.getParameter("amount")));
        // 需要判断用户是否登录

        return "/purchaseOrder/addProductSuccess";
    }

    @RequestMapping({"/cart/removeProduct.do"})
    public String removeProduct(HttpServletRequest request) throws Exception {
        String cartProductId = request.getParameter("cartProductId");
        CartProduct cartProduct = (CartProduct) baseManager.getObject(CartProduct.class.getName(), cartProductId);
        cartManager.removeFromCart(getCurrentCart(request), cartProduct);
        return "redirect:/cart/view";
    }

    @RequestMapping({"/cart/addProductCount.do"})
    @ResponseBody
    public Object addProductCount(HttpServletRequest request) {
        String cartProductId = request.getParameter("cartProductId");
        CartProduct cartProduct = (CartProduct) baseManager.getObject(CartProduct.class.getName(), cartProductId);
        return cartManager.addCount(getCurrentCart(request), cartProduct);
    }

    @RequestMapping({"/cart/changeProductCount.do"})
    @ResponseBody
    public Object changeProductCount(HttpServletRequest request) {
        String cartProductId = request.getParameter("cartProductId");
        String productAmount = request.getParameter("amount");
        CartProduct cartProduct = (CartProduct) baseManager.getObject(CartProduct.class.getName(), cartProductId);
        return cartManager.changeCount(getCurrentCart(request), cartProduct, Integer.parseInt(productAmount));

    }

    @RequestMapping({"/cart/subtractProductCount.do"})
    @ResponseBody
    public Object subtractProductCount(HttpServletRequest request) {
        String cartProductId = request.getParameter("cartProductId");
        CartProduct cartProduct = (CartProduct) baseManager.getObject(CartProduct.class.getName(), cartProductId);
        return cartManager.subtractCount(getCurrentCart(request), cartProduct);
    }

    @RequestMapping({"/cart/chooseProduct.do"})
    @ResponseBody
    public Object chooseProduct(HttpServletRequest request) {
        String cartProductId = request.getParameter("cartProductId");
        CartProduct cartProduct = (CartProduct) baseManager.getObject(CartProduct.class.getName(), cartProductId);

        return cartManager.chooseProduct(getCurrentCart(request), cartProduct, "1");

    }

    @RequestMapping("/cart/cancelChooseProduct.do")
    @ResponseBody
    public Object cancelChooseProduct(HttpServletRequest request) {
        String cartProductId = request.getParameter("cartProductId");
        CartProduct cartProduct = (CartProduct) baseManager.getObject(CartProduct.class.getName(), cartProductId);

        return cartManager.chooseProduct(getCurrentCart(request), cartProduct, "0");
    }

    @RequestMapping("/cart/chooseTenant.do")
    @ResponseBody
    public String chooseTenant(HttpServletRequest request) {
        String tenantId = request.getParameter("tenantId");
        Tenant tenant = new Tenant();
        tenant.setId(tenantId);
        Cart cart = cartManager.chooseTenant(getCurrentCart(request), tenant, "1");
        String result = "{\"tenantId\":\"" + tenantId + "\",\"totalPrice\":\"" + cart.getTotalPrice() + "\"}";
        return result;
    }


    @RequestMapping("/cart/cancelChooseTenant.do")
    @ResponseBody
    public String cancelChooseTenant(HttpServletRequest request) {
        String tenantId = request.getParameter("tenantId");
        Tenant tenant = new Tenant();
        tenant.setId(tenantId);
        Cart cart = cartManager.chooseTenant(getCurrentCart(request), tenant, "0");
        String result = "{\"tenantId\":\"" + tenantId + "\",\"totalPrice\":\"" + cart.getTotalPrice() + "\"}";
        return result;
    }


    @RequestMapping({"/cart/chooseAll.do"})
    @ResponseBody
    public String chooseAll(HttpServletRequest request) {
        String cartId = request.getParameter("cartId");
        String chooseType = request.getParameter("chooseType");
        Cart cart = cartManager.chooseAll(getCurrentCart(request), chooseType);
        String result = "{\"chooseType\":\"" + chooseType + "\",\"totalPrice\":\"" + cart.getTotalPrice() + "\"}";
        return result;
    }

    @RequestMapping({"/cart/cartAmount.do"})
    @ResponseBody
    public String getCartAmount(HttpServletRequest request) throws Exception {
        MyUser user = AuthorizationUtil.getMyUser();
        Cart cart = null;
        if (user.getId() != null) {
            XQuery xQuery = new XQuery("listCart_default", request);
            List<Object> list = baseManager.listObject(xQuery);
            cart = (Cart) list.get(0);
        } else {
            if (request.getSession().getAttribute("cart") != null) {
                cart = (Cart) request.getSession().getAttribute("cart");
            } else {
                cart = new Cart();
            }
        }

        if (cart.getCartProductList() == null || cart.getCartProductList().size() == 0) {
            return "0";
        } else {
            return cart.getCartProductList().size() + "";
        }
    }

    @RequestMapping({"/cart/cartCheck.do"})
    @ResponseBody
    public boolean cartCheck(HttpServletRequest request) {
        Cart cart = null;
        if (AuthorizationUtil.getMyUser().getId() != null) {
            String cartId = request.getParameter("cartId");
            cart = (Cart) baseManager.getObject(Cart.class.getName(), cartId);
        } else {
            cart = (Cart) request.getSession().getAttribute("cart");
        }
        Integer cartAmount = 0;
        for (CartProduct cartProduct : cart.getCartProductList()) {
            CartProduct cartProduct1 = (CartProduct) baseManager.getObject(CartProduct.class.getName(), cartProduct.getId());
            if (cartProduct1.getIsChoose().equals("1")) {
                cartAmount++;
            }
        }
        if (cartAmount > 0) {
            return true;
        } else {
            return false;
        }

    }


}
