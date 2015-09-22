package com.efeiyi.ec.website.order.controller;

import com.efeiyi.ec.organization.model.MyUser;
import com.efeiyi.ec.product.model.Product;
import com.efeiyi.ec.product.model.ProductModel;
import com.efeiyi.ec.purchase.model.Cart;
import com.efeiyi.ec.purchase.model.CartProduct;
import com.efeiyi.ec.tenant.model.Tenant;
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

    @RequestMapping({"/cart/view"})
    public String viewCart(HttpServletRequest request, Model model) throws Exception {
        Cart cart = null;
        MyUser currentUser = AuthorizationUtil.getMyUser();
        if (currentUser.getId() != null) {
            XQuery xQuery = new XQuery("listCart_default", request);
            List<Object> list = baseManager.listObject(xQuery);
            cart = (Cart) list.get(0);
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


    @RequestMapping({"/cart/addProduct.do"})
    public String addProduct(HttpServletRequest request) throws Exception {
        String productId = request.getParameter("id");
        // 需要判断用户是否登录
        Cart cart = null;
        MyUser currentUser = AuthorizationUtil.getMyUser();
        if (currentUser.getId() != null) {
            XQuery xQuery = new XQuery("listCart_default", request);
            List<Object> list = baseManager.listObject(xQuery);
            cart = (Cart) list.get(0);
        } else {
            Object cartTemp = request.getSession().getAttribute("cart");
            if (cartTemp != null) {
                cart = (Cart) cartTemp;
            } else {
                cart = new Cart();
                cart.setCartProductList(new ArrayList<CartProduct>());
                request.getSession().setAttribute("cart", cart);
            }
        }

        boolean ne = false;
        boolean ab = false;

//        XQuery xQuery1 = new XQuery("listCartProduct_default", request);
//        xQuery1.put("cart_id", cart.getId());
        List<CartProduct> list1 = cart.getCartProductList();

        if (list1.size() > 0) {
            for (CartProduct cartProductTemp : list1) {
                CartProduct cartProduct = cartProductTemp;
                if (productId.equals(cartProduct.getProductModel().getId())) {
                    if (null != request.getParameter("amount") && "" != request.getParameter("amount")) {
                        if (cartProduct.getAmount() + Integer.parseInt(request.getParameter("amount")) < cartProduct.getProductModel().getAmount()) {
                            cartProduct.setAmount(cartProduct.getAmount() + Integer.parseInt(request.getParameter("amount")));
                        } else {
                            cartProduct.setAmount(cartProduct.getProductModel().getAmount());
                        }
                    } else {
                        if (cartProduct.getAmount() + 1 < cartProduct.getProductModel().getAmount()) {
                            cartProduct.setAmount(cartProduct.getAmount() + 1);
                        } else {
                            cartProduct.setAmount(cartProduct.getProductModel().getAmount());
                        }
                    }
                    baseManager.saveOrUpdate(CartProduct.class.getName(), cartProduct);

                    ab = true;
                    ne = true;

                }
            }
        }
        if (!ne) {
            ProductModel product = new ProductModel();
            product.setId(productId);
            CartProduct cartProduct = new CartProduct();
            cartProduct.setProductModel(product);
            if (cart.getId() != null) {
                cartProduct.setCart(cart);
            }
            cartProduct.setStatus("1");
            cartProduct.setIsChoose("0");
            if (null != request.getParameter("amount") && "" != request.getParameter("amount")) {
                cartProduct.setAmount(Integer.parseInt(request.getParameter("amount")));
            } else {
                cartProduct.setAmount(1);
            }
            cart.getCartProductList().add(cartProduct);
            baseManager.saveOrUpdate(CartProduct.class.getName(), cartProduct);
            ab = true;
        }

        if (AuthorizationUtil.getMyUser().getId() != null) {
            float totalPrice = 0;
            for (CartProduct cartProductTemp : cart.getCartProductList()) {
                if (cartProductTemp.getIsChoose() != null && cartProductTemp.getIsChoose().equals("1")) {
                    float price = cartProductTemp.getProductModel().getPrice().floatValue() * cartProductTemp.getAmount();
                    totalPrice += price;
                }
            }
            cart.setTotalPrice(new BigDecimal(totalPrice));
            baseManager.saveOrUpdate(Cart.class.getName(), cart);
        } else {
            float totalPrice = 0;
            for (CartProduct cartProductTemp : cart.getCartProductList()) {
                cartProductTemp = (CartProduct) baseManager.getObject(CartProduct.class.getName(), cartProductTemp.getId());
                if (cartProductTemp.getIsChoose() != null && cartProductTemp.getIsChoose().equals("1")) {
                    float price = cartProductTemp.getProductModel().getPrice().floatValue() * cartProductTemp.getAmount();
                    totalPrice += price;
                }
            }
            cart.setTotalPrice(new BigDecimal(totalPrice));
        }

        return "/purchaseOrder/addProductSuccess";
    }

    @RequestMapping({"/cart/removeProduct.do"})
    public String removeProduct(HttpServletRequest request) throws Exception {
        String cartId = request.getParameter("cartProductId");
        if (AuthorizationUtil.getMyUser().getId() != null) {
            String cartProductId = request.getParameter("cartProductId");
            baseManager.remove(CartProduct.class.getName(), cartProductId);
        } else {
            String cartProductId = request.getParameter("cartProductId");
            baseManager.remove(CartProduct.class.getName(), cartProductId);
            Cart cart = (Cart) request.getSession().getAttribute("cart");
            for (CartProduct cartProductTemp : cart.getCartProductList()) {
                if (cartProductTemp.getId().equals(cartProductId)) {
                    cart.getCartProductList().remove(cartProductTemp);
                    break;
                }
            }
        }

        CartProduct cartProduct = (CartProduct) baseManager.getObject(CartProduct.class.getName(), request.getParameter("cartProductId"));

        if (AuthorizationUtil.getMyUser().getId() != null) {
            Cart cart = cartProduct.getCart();
            float totalPrice = 0;
            for (CartProduct cartProductTemp : cart.getCartProductList()) {
                if (cartProductTemp.getIsChoose() != null && cartProductTemp.getIsChoose().equals("1")) {
                    float price = cartProductTemp.getProductModel().getPrice().floatValue() * cartProductTemp.getAmount();
                    totalPrice += price;
                }
            }
            cart.setTotalPrice(new BigDecimal(totalPrice));
            baseManager.saveOrUpdate(Cart.class.getName(), cart);
        } else {
            Cart cart = (Cart) request.getSession().getAttribute("cart");
            for (CartProduct cartProductTemp : cart.getCartProductList()) {
                if (cartProductTemp.getId().equals(cartProduct.getId())) {
                    cartProductTemp.setAmount(cartProduct.getAmount());
                }
            }
            float totalPrice = 0;
            for (CartProduct cartProductTemp : cart.getCartProductList()) {
                cartProductTemp = (CartProduct) baseManager.getObject(CartProduct.class.getName(), cartProductTemp.getId());
                if (cartProductTemp.getIsChoose() != null && cartProductTemp.getIsChoose().equals("1")) {
                    float price = cartProductTemp.getProductModel().getPrice().floatValue() * cartProductTemp.getAmount();
                    totalPrice += price;
                }
            }
            cart.setTotalPrice(new BigDecimal(totalPrice));
            cartProduct.setCart(cart);
        }


        return "redirect:/cart/view";
    }


    @RequestMapping({"/cart/addProductCount.do"})
    @ResponseBody
    public Object addProductCount(HttpServletRequest request) {
        String cartProductId = request.getParameter("cartProductId");
        CartProduct cartProduct = (CartProduct) baseManager.getObject(CartProduct.class.getName(), cartProductId);
        if (cartProduct.getAmount() < cartProduct.getProductModel().getAmount()) {
            cartProduct.setAmount(cartProduct.getAmount() + 1);
            baseManager.saveOrUpdate(CartProduct.class.getName(), cartProduct);
        }

        if (AuthorizationUtil.getMyUser().getId() != null) {
            Cart cart = cartProduct.getCart();
            float totalPrice = 0;
            for (CartProduct cartProductTemp : cart.getCartProductList()) {
                if (cartProductTemp.getIsChoose() != null && cartProductTemp.getIsChoose().equals("1")) {
                    float price = cartProductTemp.getProductModel().getPrice().floatValue() * cartProductTemp.getAmount();
                    totalPrice += price;
                }
            }
            cart.setTotalPrice(new BigDecimal(totalPrice));
            baseManager.saveOrUpdate(Cart.class.getName(), cart);
        } else {
            Cart cart = (Cart) request.getSession().getAttribute("cart");
            for (CartProduct cartProductTemp : cart.getCartProductList()) {
                if (cartProductTemp.getId().equals(cartProduct.getId())) {
                    cartProductTemp.setAmount(cartProduct.getAmount());
                }
            }
            float totalPrice = 0;
            for (CartProduct cartProductTemp : cart.getCartProductList()) {
                cartProductTemp = (CartProduct) baseManager.getObject(CartProduct.class.getName(), cartProductTemp.getId());
                if (cartProductTemp.getIsChoose() != null && cartProductTemp.getIsChoose().equals("1")) {
                    float price = cartProductTemp.getProductModel().getPrice().floatValue() * cartProductTemp.getAmount();
                    totalPrice += price;
                }
            }
            cart.setTotalPrice(new BigDecimal(totalPrice));
            cartProduct.setCart(cart);
        }

        return cartProduct;
    }

    @RequestMapping({"/cart/changeProductCount.do"})
    @ResponseBody
    public Object changeProductCount(HttpServletRequest request) {
        String cartProductId = request.getParameter("cartProductId");
        String productAmount = request.getParameter("amount");
        CartProduct cartProduct = (CartProduct) baseManager.getObject(CartProduct.class.getName(), cartProductId);
        if (Integer.parseInt(productAmount) >= cartProduct.getProductModel().getAmount()) {
            cartProduct.setAmount(cartProduct.getProductModel().getAmount());
            baseManager.saveOrUpdate(CartProduct.class.getName(), cartProduct);
        } else {
            cartProduct.setAmount(Integer.parseInt(productAmount));
            baseManager.saveOrUpdate(CartProduct.class.getName(), cartProduct);
        }

        if (AuthorizationUtil.getMyUser().getId() != null) {
            Cart cart = cartProduct.getCart();
            float totalPrice = 0;
            for (CartProduct cartProductTemp : cart.getCartProductList()) {
                if (cartProductTemp.getIsChoose() != null && cartProductTemp.getIsChoose().equals("1")) {
                    float price = cartProductTemp.getProductModel().getPrice().floatValue() * cartProductTemp.getAmount();
                    totalPrice += price;
                }
            }
            cart.setTotalPrice(new BigDecimal(totalPrice));
            baseManager.saveOrUpdate(Cart.class.getName(), cart);
        } else {
            Cart cart = (Cart) request.getSession().getAttribute("cart");
            for (CartProduct cartProductTemp : cart.getCartProductList()) {
                if (cartProductTemp.getId().equals(cartProduct.getId())) {
                    cartProductTemp.setAmount(cartProduct.getAmount());
                }
            }
            float totalPrice = 0;
            for (CartProduct cartProductTemp : cart.getCartProductList()) {
                cartProductTemp = (CartProduct) baseManager.getObject(CartProduct.class.getName(), cartProductTemp.getId());
                if (cartProductTemp.getIsChoose() != null && cartProductTemp.getIsChoose().equals("1")) {
                    float price = cartProductTemp.getProductModel().getPrice().floatValue() * cartProductTemp.getAmount();
                    totalPrice += price;
                }
            }
            cart.setTotalPrice(new BigDecimal(totalPrice));
            cartProduct.setCart(cart);
        }

        return cartProduct;
    }

    @RequestMapping({"/cart/subtractProductCount.do"})
    @ResponseBody
    public Object subtractProductCount(HttpServletRequest request) {
        String cartProductId = request.getParameter("cartProductId");
        CartProduct cartProduct = (CartProduct) baseManager.getObject(CartProduct.class.getName(), cartProductId);
        if (cartProduct.getAmount() > 1) {
            cartProduct.setAmount(cartProduct.getAmount() - 1);
            baseManager.saveOrUpdate(CartProduct.class.getName(), cartProduct);
        }

        if (AuthorizationUtil.getMyUser().getId() != null) {
            Cart cart = cartProduct.getCart();
            float totalPrice = 0;
            for (CartProduct cartProductTemp : cart.getCartProductList()) {
                if (cartProductTemp.getIsChoose() != null && cartProductTemp.getIsChoose().equals("1")) {
                    float price = cartProductTemp.getProductModel().getPrice().floatValue() * cartProductTemp.getAmount();
                    totalPrice += price;
                }
            }
            cart.setTotalPrice(new BigDecimal(totalPrice));
            baseManager.saveOrUpdate(Cart.class.getName(), cart);
        } else {
            Cart cart = (Cart) request.getSession().getAttribute("cart");
            for (CartProduct cartProductTemp : cart.getCartProductList()) {
                if (cartProductTemp.getId().equals(cartProduct.getId())) {
                    cartProductTemp.setAmount(cartProduct.getAmount());
                }
            }
            float totalPrice = 0;
            for (CartProduct cartProductTemp : cart.getCartProductList()) {
                cartProductTemp = (CartProduct) baseManager.getObject(CartProduct.class.getName(), cartProductTemp.getId());
                if (cartProductTemp.getIsChoose() != null && cartProductTemp.getIsChoose().equals("1")) {
                    float price = cartProductTemp.getProductModel().getPrice().floatValue() * cartProductTemp.getAmount();
                    totalPrice += price;
                }
            }
            cart.setTotalPrice(new BigDecimal(totalPrice));
            cartProduct.setCart(cart);
        }


        return cartProduct;
    }

    @RequestMapping({"/cart/chooseProduct.do"})
    @ResponseBody
    public Object chooseProduct(HttpServletRequest request) {
        String cartProductId = request.getParameter("cartProductId");
        CartProduct cartProduct = (CartProduct) baseManager.getObject(CartProduct.class.getName(), cartProductId);
        cartProduct.setIsChoose("1"); //1代表选中
        baseManager.saveOrUpdate(CartProduct.class.getName(), cartProduct);
        Cart cart = null;
        if (AuthorizationUtil.getMyUser().getId() != null) {
            cart = cartProduct.getCart();
            float totalPrice = 0;
            for (CartProduct cartProductTemp : cart.getCartProductList()) {
                if (cartProductTemp.getIsChoose() != null && cartProductTemp.getIsChoose().equals("1")) {
                    float price = cartProductTemp.getProductModel().getPrice().floatValue() * cartProductTemp.getAmount();
                    totalPrice += price;
                }
            }
            cart.setTotalPrice(new BigDecimal(totalPrice));
            baseManager.saveOrUpdate(Cart.class.getName(), cart);
        } else {
            cart = (Cart) request.getSession().getAttribute("cart");
            for (CartProduct cartProductTemp : cart.getCartProductList()) {
                if (cartProductTemp.getId().equals(cartProduct.getId())) {
                    cartProductTemp.setAmount(cartProduct.getAmount());
                }
            }
            float totalPrice = 0;
            for (CartProduct cartProductTemp : cart.getCartProductList()) {
                cartProductTemp = (CartProduct) baseManager.getObject(CartProduct.class.getName(), cartProductTemp.getId());
                if (cartProductTemp.getIsChoose() != null && cartProductTemp.getIsChoose().equals("1")) {
                    float price = cartProductTemp.getProductModel().getPrice().floatValue() * cartProductTemp.getAmount();
                    totalPrice += price;
                }
            }

            List<CartProduct> cartProductList = cart.getCartProductList();
            for (CartProduct cartProductTemp : cartProductList) {
                if (cartProductTemp.getId().equals(cartProductId)) {
                    cartProductTemp.setIsChoose("1");
//                    baseManager.saveOrUpdate(CartProduct.class.getName(), cartProductTemp);
                }
            }

            cart.setTotalPrice(new BigDecimal(totalPrice));
        }


        return cart;

    }

    @RequestMapping("/cart/cancelChooseProduct.do")
    @ResponseBody
    public Object cancelChooseProduct(HttpServletRequest request) {
        String cartProductId = request.getParameter("cartProductId");
        CartProduct cartProduct = (CartProduct) baseManager.getObject(CartProduct.class.getName(), cartProductId);
        cartProduct.setIsChoose("0"); //0代表取消选中
        baseManager.saveOrUpdate(CartProduct.class.getName(), cartProduct);
        Cart cart = null;
        if (AuthorizationUtil.getMyUser().getId() != null) {
            cart = cartProduct.getCart();
            float totalPrice = 0;
            for (CartProduct cartProductTemp : cart.getCartProductList()) {
                if (cartProductTemp.getIsChoose() != null && cartProductTemp.getIsChoose().equals("1")) {
                    float price = cartProductTemp.getProductModel().getPrice().floatValue() * cartProductTemp.getAmount();
                    totalPrice += price;
                }
            }
            cart.setTotalPrice(new BigDecimal(totalPrice));
            baseManager.saveOrUpdate(Cart.class.getName(), cart);
        } else {
            cart = (Cart) request.getSession().getAttribute("cart");
            for (CartProduct cartProductTemp : cart.getCartProductList()) {
                if (cartProductTemp.getId().equals(cartProduct.getId())) {
                    cartProductTemp.setAmount(cartProduct.getAmount());
                }
            }
            float totalPrice = 0;
            for (CartProduct cartProductTemp : cart.getCartProductList()) {
                cartProductTemp = (CartProduct) baseManager.getObject(CartProduct.class.getName(), cartProductTemp.getId());
                if (cartProductTemp.getIsChoose() != null && cartProductTemp.getIsChoose().equals("1")) {
                    float price = cartProductTemp.getProductModel().getPrice().floatValue() * cartProductTemp.getAmount();
                    totalPrice += price;
                }
            }

            List<CartProduct> cartProductList = cart.getCartProductList();
            for (CartProduct cartProductTemp : cartProductList) {
                if (cartProductTemp.getId().equals(cartProductId)) {
                    cartProductTemp.setIsChoose("0");
//                    baseManager.saveOrUpdate(CartProduct.class.getName(), cartProductTemp);
                }
            }

            cart.setTotalPrice(new BigDecimal(totalPrice));
        }
        return cart;
    }

    @RequestMapping("/cart/chooseTenant.do")
    @ResponseBody
    public String chooseTenant(HttpServletRequest request) {
        String tenantId = request.getParameter("tenantId");
        String cartId = request.getParameter("cartId");
        if (AuthorizationUtil.getMyUser().getId() != null) {
            Cart cart = (Cart) baseManager.getObject(Cart.class.getName(), cartId);
            List<CartProduct> cartProductList = cart.getCartProductList();
            for (CartProduct cartProductTemp : cartProductList) {
                if (cartProductTemp.getProductModel().getProduct().getTenant().getId().equals(tenantId)) {
                    cartProductTemp.setIsChoose("1");
                    baseManager.saveOrUpdate(CartProduct.class.getName(), cartProductTemp);
                }
            }

            float totalPrice = 0;
            for (CartProduct cartProductTemp : cart.getCartProductList()) {
                if (cartProductTemp.getIsChoose() != null && cartProductTemp.getIsChoose().equals("1")) {
                    float price = cartProductTemp.getProductModel().getPrice().floatValue() * cartProductTemp.getAmount();
                    totalPrice += price;
                }
            }
            cart.setTotalPrice(new BigDecimal(totalPrice));
            baseManager.saveOrUpdate(Cart.class.getName(), cart);
            String result = "{\"tenantId\":\"" + tenantId + "\",\"totalPrice\":\"" + cart.getTotalPrice().intValue() + "\"}";
            return result;
        } else {
//            Cart cart = (Cart) baseManager.getObject(Cart.class.getName(), cartId);
            Cart cart = (Cart) request.getSession().getAttribute("cart");
            List<CartProduct> cartProductList = cart.getCartProductList();
            for (CartProduct cartProductTemp : cartProductList) {
                cartProductTemp = (CartProduct) baseManager.getObject(CartProduct.class.getName(), cartProductTemp.getId());
                if (cartProductTemp.getProductModel().getProduct().getTenant().getId().equals(tenantId)) {
                    cartProductTemp.setIsChoose("1");
                    baseManager.saveOrUpdate(CartProduct.class.getName(), cartProductTemp);
                }
            }

            float totalPrice = 0;
            for (CartProduct cartProductTemp : cart.getCartProductList()) {
                cartProductTemp = (CartProduct) baseManager.getObject(CartProduct.class.getName(), cartProductTemp.getId());
                if (cartProductTemp.getIsChoose() != null && cartProductTemp.getIsChoose().equals("1")) {
                    float price = cartProductTemp.getProductModel().getPrice().floatValue() * cartProductTemp.getAmount();
                    totalPrice += price;
                }
            }
            cart.setTotalPrice(new BigDecimal(totalPrice));
//            baseManager.saveOrUpdate(Cart.class.getName(), cart);
            String result = "{\"tenantId\":\"" + tenantId + "\",\"totalPrice\":\"" + cart.getTotalPrice().intValue() + "\"}";
            return result;
        }
    }


    @RequestMapping("/cart/cancelChooseTenant.do")
    @ResponseBody
    public String cancelChooseTenant(HttpServletRequest request) {
        String tenantId = request.getParameter("tenantId");
        String cartId = request.getParameter("cartId");
        if (AuthorizationUtil.getMyUser().getId() != null) {

            Cart cart = (Cart) baseManager.getObject(Cart.class.getName(), cartId);
            List<CartProduct> cartProductList = cart.getCartProductList();
            for (CartProduct cartProductTemp : cartProductList) {
                if (cartProductTemp.getProductModel().getProduct().getTenant().getId().equals(tenantId)) {
                    cartProductTemp.setIsChoose("0");
                    baseManager.saveOrUpdate(CartProduct.class.getName(), cartProductTemp);
                }
            }

            float totalPrice = 0;
            for (CartProduct cartProductTemp : cart.getCartProductList()) {
                if (cartProductTemp.getIsChoose() != null && cartProductTemp.getIsChoose().equals("1")) {
                    float price = cartProductTemp.getProductModel().getPrice().floatValue() * cartProductTemp.getAmount();
                    totalPrice += price;
                }
            }
            cart.setTotalPrice(new BigDecimal(totalPrice));
            baseManager.saveOrUpdate(Cart.class.getName(), cart);
            String result = "{\"tenantId\":\"" + tenantId + "\",\"totalPrice\":\"" + cart.getTotalPrice().intValue() + "\"}";
            return result;
        } else {
            Cart cart = (Cart) request.getSession().getAttribute("cart");
            List<CartProduct> cartProductList = cart.getCartProductList();
            for (CartProduct cartProductTemp : cartProductList) {
                cartProductTemp = (CartProduct) baseManager.getObject(CartProduct.class.getName(), cartProductTemp.getId());
                if (cartProductTemp.getProductModel().getProduct().getTenant().getId().equals(tenantId)) {
                    cartProductTemp.setIsChoose("0");
                    baseManager.saveOrUpdate(CartProduct.class.getName(), cartProductTemp);
                }
            }

            float totalPrice = 0;
            for (CartProduct cartProductTemp : cart.getCartProductList()) {
                cartProductTemp = (CartProduct) baseManager.getObject(CartProduct.class.getName(), cartProductTemp.getId());
                if (cartProductTemp.getIsChoose() != null && cartProductTemp.getIsChoose().equals("1")) {
                    float price = cartProductTemp.getProductModel().getPrice().floatValue() * cartProductTemp.getAmount();
                    totalPrice += price;
                }
            }
            cart.setTotalPrice(new BigDecimal(totalPrice));
//            baseManager.saveOrUpdate(Cart.class.getName(), cart);
            String result = "{\"tenantId\":\"" + tenantId + "\",\"totalPrice\":\"" + cart.getTotalPrice().intValue() + "\"}";
            return result;
        }
    }


    @RequestMapping({"/cart/chooseAll.do"})
    @ResponseBody
    public String chooseAll(HttpServletRequest request) {
        String cartId = request.getParameter("cartId");
        String chooseType = request.getParameter("chooseType");
        if (AuthorizationUtil.getMyUser().getId() != null) {

            Cart cart = (Cart) baseManager.getObject(Cart.class.getName(), cartId);
            List<CartProduct> cartProductList = cart.getCartProductList();

            for (CartProduct cartProductTemp : cartProductList) {
                if (chooseType.equals("1")) {
                    cartProductTemp.setIsChoose("1");
                } else {
                    cartProductTemp.setIsChoose("0");
                }
                baseManager.saveOrUpdate(CartProduct.class.getName(), cartProductTemp);
            }

            float totalPrice = 0;
            for (CartProduct cartProductTemp : cart.getCartProductList()) {
                if (cartProductTemp.getIsChoose() != null && cartProductTemp.getIsChoose().equals("1")) {
                    float price = cartProductTemp.getProductModel().getPrice().floatValue() * cartProductTemp.getAmount();
                    totalPrice += price;
                }
            }
            cart.setTotalPrice(new BigDecimal(totalPrice));
            baseManager.saveOrUpdate(Cart.class.getName(), cart);
            String result = "{\"chooseType\":\"" + chooseType + "\",\"totalPrice\":\"" + cart.getTotalPrice().intValue() + "\"}";
            return result;
        } else {

            Cart cart = (Cart) request.getSession().getAttribute("cart");
            List<CartProduct> cartProductList = cart.getCartProductList();
            for (CartProduct cartProductTemp : cartProductList) {
                if (chooseType.equals("1")) {
                    cartProductTemp.setIsChoose("1");
                } else {
                    cartProductTemp.setIsChoose("0");
                }
                baseManager.saveOrUpdate(CartProduct.class.getName(), cartProductTemp);
            }

            float totalPrice = 0;
            for (CartProduct cartProductTemp : cart.getCartProductList()) {
                cartProductTemp = (CartProduct) baseManager.getObject(CartProduct.class.getName(), cartProductTemp.getId());
                if (cartProductTemp.getIsChoose() != null && cartProductTemp.getIsChoose().equals("1")) {
                    ProductModel productModel = (ProductModel) baseManager.getObject(ProductModel.class.getName(), cartProductTemp.getProductModel().getId());
                    float price = productModel.getPrice().floatValue() * cartProductTemp.getAmount();
                    totalPrice += price;
                }
            }
            cart.setTotalPrice(new BigDecimal(totalPrice));
//            baseManager.saveOrUpdate(Cart.class.getName(), cart);
            String result = "{\"chooseType\":\"" + chooseType + "\",\"totalPrice\":\"" + cart.getTotalPrice().intValue() + "\"}";
            return result;
        }

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
        }else {
            cart = (Cart)request.getSession().getAttribute("cart");
        }
        Integer cartAmount = 0;
        for (CartProduct cartProduct : cart.getCartProductList()) {
            CartProduct cartProduct1 = (CartProduct) baseManager.getObject(CartProduct.class.getName(),cartProduct.getId());
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
