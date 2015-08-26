package com.efeiyi.ec.website.product.controller;

import com.efeiyi.ec.organization.model.MyUser;
import com.efeiyi.ec.product.model.Product;
import com.efeiyi.ec.product.model.ProductFavorite;
import com.efeiyi.ec.product.model.ProductModel;
import com.efeiyi.ec.project.model.Project;
import com.efeiyi.ec.purchase.model.Cart;
import com.efeiyi.ec.purchase.model.CartProduct;
import com.efeiyi.ec.website.organization.util.AuthorizationUtil;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import com.ming800.core.does.model.XSaveOrUpdate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.swing.event.TreeModelListener;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;

/**
 * Created by Administrator on 2015/7/8.
 */
@Controller
@RequestMapping("/product")
public class ProductController {

    @Autowired
    private BaseManager baseManager;

    @RequestMapping(value = "/productList.do")
    public ModelAndView listProduct(HttpServletRequest request, ModelMap model) throws Exception{
        String id = request.getParameter("id");
        XQuery xQuery = new XQuery("plistProduct_default",request);
        List productList = baseManager.listObject(xQuery);
        model.addAttribute("productList",productList);
        return  new ModelAndView("/product/productList",model);
    }


    @RequestMapping({"/{productId}"})
    public String viewProduct(@PathVariable String productId, HttpServletRequest request ,Model model){
        ProductModel productModel = (ProductModel)baseManager.getObject(ProductModel.class.getName(),productId);
        model.addAttribute("productModel",productModel);
        return "/product/productView";
    }

    @RequestMapping("/list/{projectId}")
    public String plistProduct(@PathVariable String projectId,HttpServletRequest request, Model model) throws Exception{
        //前端传递projectId
        XQuery xQuery = new XQuery("plistProductModel_default",request);
        xQuery.put("product_category_id", projectId);
        xQuery.addRequestParamToModel(model,request);
        List<Object> productModelList = baseManager.listPageInfo(xQuery).getList();
        Project project  = (Project)baseManager.getObject(Project.class.getName(),projectId);
        String proName = project.getName();
        String[] str = new String[16];
        for(int i = 0;i<proName.length();i++){
            str[i] = String.valueOf(proName.charAt(i));
        }
        model.addAttribute("proName",proName);
        model.addAttribute("strProjectName",str);
        model.addAttribute("project",project);
        model.addAttribute("productModelList",productModelList);
        return "/product/productModelList";
    }

    @RequestMapping(value = "/getProduct.do")
    public String getProduct(HttpServletRequest request, Model model) {
        String id = request.getParameter("id");
        Product product = (Product) baseManager.getObject(Product.class.getName(), id);
        model.addAttribute("product", product);
        return "/product/productView";
    }

    /**
     * 产品收藏
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping({"/addProductFavorite.do"})
    @ResponseBody
    public boolean addProductFavorite(HttpServletRequest request) throws Exception{
        String productId =request.getParameter("productId");
        XSaveOrUpdate xSaveOrUpdate = new XSaveOrUpdate("saveOrUpdateProductFavorite" ,request);
        xSaveOrUpdate.getParamMap().put("user_id", AuthorizationUtil.getMyUser().getId());
        xSaveOrUpdate.getParamMap().put("product_id", productId);
        baseManager.saveOrUpdate(xSaveOrUpdate);
        return true;
    }
    /**
     * 爆款推荐
     */
    @RequestMapping({"/hot/{productModelId}"})
    public String recommendation(@PathVariable String productModelId, HttpServletRequest request, Model model) throws Exception {
        ProductModel productModel = (ProductModel) baseManager.getObject(ProductModel.class.getName(), productModelId);
        List<ProductModel> productModelList  = productModel.getProduct().getProductModelList();
        model.addAttribute("productModelList", productModelList);
        model.addAttribute("productModel", productModel);
        return "/product/recommendationList";
}
    /**
     * 删除收藏产品
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping({"/removeProductFavorite.do"})
    @ResponseBody
    public boolean removeProductFavorite(HttpServletRequest request) throws Exception{
        baseManager.remove(ProductFavorite.class.getName(),request.getParameter("productFavoriteId"));
        return true;
    }

    /**
     * 查看收藏产品
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping({"/favorite/list"})
    public List<Object> listProductFavorite(HttpServletRequest request) throws Exception{
        XQuery xQuery = new XQuery("plistProductFavorite_default",request);
        List<Object> objectList = baseManager.listObject(xQuery);
        return objectList;
    }

    /**商品详情
     * @param request
     * @return
     * @throws Exception
     */

    @RequestMapping({"/category/{productModelId}"})
    public String productDetalis(@PathVariable String productModelId, HttpServletRequest request, Model model){
        ProductModel productModel = (ProductModel) baseManager.getObject(ProductModel.class.getName(), productModelId);
        model.addAttribute("productModel", productModel);
        return "/product/productDetails";
    }
    /*
    *
    * 添加到购物车
    * */
    @RequestMapping({"/cart/{productModelId}"})
    public String addProduct(@PathVariable String productModelId,HttpServletRequest request) throws Exception {
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
            }
        }

        boolean ne = false;
        boolean ab = false;

        XQuery xQuery1 = new XQuery("listCartProduct_default", request);
        xQuery1.put("cart_id", cart.getId());
        List<Object> list1 = baseManager.listObject(xQuery1);

        if (list1.size() > 0) {
            for (Object cartProductTemp : list1) {
                CartProduct cartProduct = (CartProduct) cartProductTemp;
                if (productModelId.equals(cartProduct.getProductModel().getId())) {
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
            ProductModel product = new ProductModel();
            product.setId(productModelId);
            CartProduct cartProduct = new CartProduct();
            cartProduct.setProductModel(product);
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
        return "/purchaseOrder/addProductSuccess";
    }
}
