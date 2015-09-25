package com.efeiyi.ec.website.order.controller;

import com.efeiyi.ec.purchase.model.PurchaseOrderComment;
import com.efeiyi.ec.purchase.model.PurchaseOrderProduct;
import com.efeiyi.ec.website.organization.util.AuthorizationUtil;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import com.ming800.core.does.model.XSaveOrUpdate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * Created by Administrator on 2015/9/17.
 */
@Controller
@RequestMapping("comment")
public class PurchaseCommentController {
    @Autowired
    private BaseManager baseManager;

    @RequestMapping("/finishOrderList.do")
    public String finishOrder(HttpServletRequest request,Model model) throws Exception {

        XQuery xQuery = new XQuery("plistPurchaseOrder_default1",request);
        xQuery.addRequestParamToModel(model, request);
        List<Object> list = baseManager.listPageInfo(xQuery).getList();
        model.addAttribute("finishList",list);
        return "/purchaseOrder/purchaseComment";
    }

    @RequestMapping("/saveComment.do")
    public String saveOrUpdateComment(HttpServletRequest request) throws Exception {

        String id=request.getParameter("productId");
        XSaveOrUpdate xUpdate =new XSaveOrUpdate("saveOrUpdateComment",request);
        xUpdate.getParamMap().put("purchaseOrderProduct_id",id);
        PurchaseOrderComment comment = (PurchaseOrderComment)baseManager.saveOrUpdate(xUpdate);

        PurchaseOrderProduct purchaseOrderProduct = (PurchaseOrderProduct)baseManager.getObject(PurchaseOrderProduct.class.getName(),id);
        purchaseOrderProduct.setStatus("1");
        purchaseOrderProduct.setPurchaseOrderComment(comment);
        baseManager.saveOrUpdate(PurchaseOrderProduct.class.getName(),purchaseOrderProduct);


        return"redirect:/comment/finishOrderList.do";
    }

}
