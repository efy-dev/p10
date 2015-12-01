package com.efeiyi.ec.wiki.product.controller;

import com.efeiyi.ec.organization.model.MyUser;
import com.efeiyi.ec.organization.model.User;
import com.efeiyi.ec.product.model.Product;
import com.efeiyi.ec.project.model.ProjectFollowed;
import com.efeiyi.ec.wiki.base.controller.WikibaseController;
import com.efeiyi.ec.wiki.model.ProductComment;
import com.efeiyi.ec.wiki.model.ProductStore;
import com.efeiyi.ec.wiki.organization.util.AuthorizationUtil;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;

/**
 * Created by Administrator on 2015/10/13.
 *
 */
@Controller
public class ProductController extends WikibaseController {
    private static Logger logger = Logger.getLogger(ProductController.class);
    @Autowired
    BaseManager baseManager;
    @RequestMapping("/product/saveComment.do")
    @ResponseBody
    public Object saveComment(HttpServletRequest request) throws Exception {
        String productId = request.getParameter("productId");
        String content = request.getParameter("content");
        MyUser user = AuthorizationUtil.getMyUser();
        if (user.getId() == null) {
            return false;
        }
        Product product = (Product) baseManager.getObject(Product.class.getName(), productId);
        if(product==null || product.getId()==null){//参数非法
            return false;
        }
        ProductComment productComment = new ProductComment();
        productComment.setCreateDateTime(new Date());
        //productComment.setUser((User)baseManager.getObject(User.class.getName(),user.getId()));
        productComment.setUser(AuthorizationUtil.getUser());
        productComment.setProduct(product);
        productComment.setStatus("1");
        productComment.setContent(content);
        productComment.setAmount(0l);
        productComment.setModerator(null);
        productComment.setWatch("0");
        ProductComment fatherProductComment = new ProductComment();
        fatherProductComment.setId("0");
        productComment.setFatherComment(fatherProductComment);
        baseManager.saveOrUpdate(ProductComment.class.getName(), productComment);
        //product.setAmount(product.getAmount() == null ? 1 : product.getAmount() + 1);
        product.setFsAmount(product.getFsAmount() == null ? 1 : product.getFsAmount() + 1);
        baseManager.saveOrUpdate(Product.class.getName(), product);
        return productComment;
    }

    @RequestMapping("/product/saveComment2.do")
    @ResponseBody
    public Object saveComment2(HttpServletRequest request) throws Exception {//此方法待作废
        String productId = request.getParameter("productId");
        String content = request.getParameter("content");
        String contentId = request.getParameter("contentId");
        MyUser user = AuthorizationUtil.getMyUser();
        if (user.getId() == null) {
            return false;
        }

        Product product = (Product) baseManager.getObject(Product.class.getName(), productId);
        if(product==null || product.getId()==null){//参数非法
            return false;
        }
        ProductComment productComment = new ProductComment();
        productComment.setCreateDateTime(new Date());
        //productComment.setUser((User)baseManager.getObject(User.class.getName(),user.getId()));
        productComment.setUser(AuthorizationUtil.getUser());
        productComment.setProduct(product);
        productComment.setStatus("1");
        productComment.setContent(content);
        productComment.setAmount(0l);
        productComment.setWatch("0");
        //MyUser moderator =((ProductComment)baseManager.getObject(ProductComment.class.getName(),contentId)).getModerator();
        User moderator =((ProductComment)baseManager.getObject(ProductComment.class.getName(),contentId)).getUser();
        productComment.setModerator(moderator);
        ProductComment fatherProductComment = new ProductComment();
        fatherProductComment.setId(contentId);
        productComment.setFatherComment(fatherProductComment);
        baseManager.saveOrUpdate(ProductComment.class.getName(), productComment);
        //product.setAmount(product.getAmount() == null ? 1 : product.getAmount() + 1);
        product.setFsAmount(product.getFsAmount() == null ? 1 : product.getFsAmount() + 1);
        baseManager.saveOrUpdate(Product.class.getName(), product);
        return productComment;
    }
    @RequestMapping("/base/showProduct/{productId}")
    public ModelAndView showProduct(@PathVariable String productId, HttpServletRequest request, Model model) throws Exception {
        Product product = (Product) baseManager.getObject(Product.class.getName(), productId);
        boolean flag = IsattentionMaster2(request, product.getMaster().getId());//判断用户是否已经关注该作品的大师
        model.addAttribute("flag", flag);
        model.addAttribute("product", product);
        if (AuthorizationUtil.getMyUser().getId() != null) {
            model.addAttribute("myUser", AuthorizationUtil.getMyUser());
        }
        return new ModelAndView("/product/brifProduct");
    }

    @RequestMapping("/base/storeProduct.do")
    @ResponseBody
    public String storeProduct(HttpServletRequest request) throws Exception {
        String productId = request.getParameter("productId");
        ProductStore productStore = new ProductStore();
        MyUser user = AuthorizationUtil.getMyUser();
        if (user.getId() == null) {
            return "false";
        }else{
            String queryHql = "from ProductStore t where t.user.id=:userId and t.product.id=:productId and t.status!='0'";
            LinkedHashMap<String, Object> map = new LinkedHashMap<>();
            map.put("userId", user.getId());
            map.put("productId", productId);
            ProductStore ps = (ProductStore) baseManager.getUniqueObjectByConditions(queryHql, map);
            if (ps != null && ps.getId() != null){//不为null,说明已经收藏了
                baseManager.remove(ProductStore.class.getName(),ps.getId());
                return "repeat" ;
            }else{
                //productStore.setUser((User)baseManager.getObject(User.class.getName(),user.getId()));
                productStore.setUser(AuthorizationUtil.getUser());
                Product product = (Product) baseManager.getObject(Product.class.getName(), productId);
                productStore.setProduct(product);
                productStore.setStatus("1");
                productStore.setCreateDateTime(new Date());
                baseManager.saveOrUpdate(ProductStore.class.getName(), productStore);
                return "true";
            }
        }

    }


    public boolean IsattentionMaster2(HttpServletRequest request, String userid) throws Exception {
        boolean flag = false;
        if (AuthorizationUtil.getMyUser().getId() != null) {
            XQuery xQuery = new XQuery("listMasterFollowed_check", request);
            xQuery.put("master_id", userid);
            xQuery.put("user_id", AuthorizationUtil.getMyUser().getId());
            List<ProjectFollowed> list = baseManager.listObject(xQuery);
            if (list != null && !list.isEmpty()) {
                flag = true;
            }
        }
        return flag;
    }
}
