package com.efeiyi.ec.website.product.controller;

import com.alibaba.fastjson.JSON;
import com.efeiyi.ec.group.model.Group;
import com.efeiyi.ec.group.model.GroupProduct;
import com.efeiyi.ec.organization.model.MyUser;
import com.efeiyi.ec.product.model.Product;
import com.efeiyi.ec.website.organization.util.AuthorizationUtil;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.PageInfo;
import com.ming800.core.does.model.XQuery;
import com.ming800.core.taglib.PageEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

/**
 * Created by Administrator on 2015/10/20.
 */
@Controller
@RequestMapping("/product")
public class GroupProductController {
    @Autowired
    private BaseManager baseManager;

    @RequestMapping(value = "/groupProduct1.do")
    public String listProduct1(HttpServletRequest request, Model model) throws Exception {
     return  "/groupProduct/groupProductList";
    }


    /**
     * 团购产品列表
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/groupProduct.do/{index}")
    @ResponseBody
    public List<GroupProduct> listProduct(HttpServletRequest request,@PathVariable String index) throws Exception {
        XQuery xQuery = new XQuery("listGroupProduct_default",request);
        xQuery.put("status","1");
        PageEntity pageEntity = new PageEntity();
        if (index != null) {
            pageEntity.setIndex(Integer.parseInt(index));
        }
        pageEntity.setSize(4);
        xQuery.setPageEntity(pageEntity);
        PageInfo pageInfo = baseManager.listPageInfo(xQuery);
        List<GroupProduct> list = pageInfo.getList();
        for(GroupProduct groupProduct:list){
            groupProduct.setProductName(groupProduct.getProductModel().getProduct().getName());
        }
        return list;
    }
    /**
     * 开团详情页
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/groupProduct/{groupProductId}")
    public String groupProductDetails(@PathVariable String groupProductId ,HttpServletRequest request, Model model) throws Exception {
        GroupProduct groupProduct = (GroupProduct) baseManager.getObject(GroupProduct.class.getName(), groupProductId);
        XQuery purchaseOrderProductQuery = new XQuery("listPurchaseOrderProduct_default",request);
        purchaseOrderProductQuery.put("productModel_id", groupProduct.getProductModel().getId());
        List<Object> purchaseOrderProductList = baseManager.listObject(purchaseOrderProductQuery);
        Collections.reverse(purchaseOrderProductList);
        model.addAttribute("groupProduct", groupProduct);
        model.addAttribute("purchaseOrderProductList", purchaseOrderProductList);
        return "/groupProduct/groupProductDetails";
    }
    /**
     * 评价详情
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/groupProduct/purchaseOrderComment/{groupProductId}/{index}")
    @ResponseBody
    public List<Object> getPurchaseOrderCommentList(@PathVariable String groupProductId ,HttpServletRequest request,@PathVariable String index) throws Exception {
        GroupProduct groupProduct = (GroupProduct) baseManager.getObject(GroupProduct.class.getName(), groupProductId);
        XQuery purchaseOrderProductQuery = new XQuery("listPurchaseOrderProduct_default",request);
        purchaseOrderProductQuery.put("productModel_id", groupProduct.getProductModel().getId());
        PageEntity pageEntity = new PageEntity();
        if (index != null) {
            pageEntity.setIndex(Integer.parseInt(index));
        }
        pageEntity.setSize(4);
        purchaseOrderProductQuery.setPageEntity(pageEntity);
        PageInfo pageInfo = baseManager.listPageInfo(purchaseOrderProductQuery);
        List<Object> list = pageInfo.getList();
        if(list!=null&&list.size()>0){
        Collections.reverse(list);
        }
        return list;
    }

}
