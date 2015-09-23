package com.efeiyi.ec.website.order.controller;

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
        XSaveOrUpdate xSaveOrUpdate =new XSaveOrUpdate("saveOrUpdateComment",request);
        baseManager.saveOrUpdate(xSaveOrUpdate);
        String id=request.getParameter("productId");
//        XSaveOrUpdate xUpdate =new XSaveOrUpdate("saveOrUpdateProduct",request);

//        String sql="update purchase_order_product set status= '1'and purchase_order_comment_id ='"++"' where id='"+id+"' ";
//        baseManager.executeSql(null,sql,null);
        return"redirect:/comment/finishOrderList.do";
    }
    public String checkComment(HttpServletRequest request,Model model){


        return null;
    }

}
