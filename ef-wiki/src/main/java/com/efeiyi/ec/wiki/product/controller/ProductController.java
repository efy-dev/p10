package com.efeiyi.ec.wiki.product.controller;

import com.efeiyi.ec.organization.model.MyUser;
import com.efeiyi.ec.product.model.Product;
import com.efeiyi.ec.wiki.base.controller.WikibaseController;
import com.efeiyi.ec.wiki.model.ProductComment;
import com.efeiyi.ec.wiki.organization.util.AuthorizationUtil;
import com.ming800.core.base.service.BaseManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.Date;

/**
 * Created by Administrator on 2015/10/13.
 *
 */
@Controller
@RequestMapping("/product")
public class ProductController extends WikibaseController {
    private static Logger logger = Logger.getLogger(ProductController.class);
    @Autowired
    BaseManager baseManager;
    @RequestMapping("/saveComment.do")
    @ResponseBody
    public Object saveComment(HttpServletRequest request, Model model) throws Exception {
        String productId = request.getParameter("productId");
        String content = request.getParameter("content");
        MyUser user = AuthorizationUtil.getMyUser();
        if (user.getId() == null) {
            return false;
        }
        Product product = (Product) baseManager.getObject(Product.class.getName(), productId);
        ProductComment productComment = new ProductComment();
        productComment.setCreateDateTime(new Date());
        productComment.setUser(user);
        productComment.setProduct(product);
        productComment.setStatus("1");
        productComment.setContent(content);
        productComment.setAmount(0l);
        ProductComment fatherProductComment = new ProductComment();
        fatherProductComment.setId("0");
        productComment.setFatherComment(fatherProductComment);
        baseManager.saveOrUpdate(ProductComment.class.getName(), productComment);
        product.setAmount(product.getAmount() == null ? 1 : product.getAmount() + 1);
        baseManager.saveOrUpdate(Product.class.getName(), product);
        return productComment;
    }

    @RequestMapping("/saveComment2.do")
    @ResponseBody
    public Object saveComment2(HttpServletRequest request, Model model) throws Exception {//此方法待作废
        String productId = request.getParameter("productId");
        String content = request.getParameter("content");
        String contentId = request.getParameter("contentId");
        MyUser user = AuthorizationUtil.getMyUser();
        if (user.getId() == null) {
            return false;
        }

        Product product = (Product) baseManager.getObject(Product.class.getName(), productId);
        ProductComment productComment = new ProductComment();
        productComment.setCreateDateTime(new Date());
        productComment.setUser(user);
        productComment.setProduct(product);
        productComment.setStatus("1");
        productComment.setContent(content);
        productComment.setAmount(0l);
        ProductComment fatherProductComment = new ProductComment();
        fatherProductComment.setId(contentId);
        productComment.setFatherComment(fatherProductComment);
        baseManager.saveOrUpdate(ProductComment.class.getName(), productComment);
        product.setAmount(product.getAmount() == null ? 1 : product.getAmount() + 1);
        baseManager.saveOrUpdate(Product.class.getName(), product);
        return productComment;
    }

}
