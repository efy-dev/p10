package com.efeiyi.ec.consumer.order.controller;

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
 * Created by Administrator on 2015/9/21.
 */
@Controller
@RequestMapping("/purchaseCollect")
public class PurchaseCollectController {
    @Autowired
    private BaseManager baseManager;

    @RequestMapping("/collectList.do")
    public String purchaseCollect(HttpServletRequest request, Model model) throws Exception {
        XQuery xQuery = new XQuery("plistProductFavorite_default", request, 8);
        xQuery.addRequestParamToModel(model, request);
        List<Object> list = baseManager.listPageInfo(xQuery).getList();
        model.addAttribute("collectList", list);
        return "/purchaseOrder/purchaseCollect";
    }

    @RequestMapping("/wapCollectList.do")
    public String wapPurchaseCollect(HttpServletRequest request, Model model) throws Exception {
        XQuery xQuery = new XQuery("plistProductFavorite_default", request);
        xQuery.addRequestParamToModel(model, request);
        List<Object> list = baseManager.listObject(xQuery);
        model.addAttribute("collectList", list);
        return "/purchaseOrder/purchaseCollect";
    }


    @RequestMapping({"/unfollow.do"})
    public String addProductFavorite(HttpServletRequest request) throws Exception {
        XSaveOrUpdate xSaveOrUpdate = new XSaveOrUpdate("saveOrUpdateProductFavorite", request);
        xSaveOrUpdate.getParamMap().put("status", 2);
        baseManager.saveOrUpdate(xSaveOrUpdate);
        return "redirect:/purchaseCollect/collectList.do";
    }

    @RequestMapping({"/wapUnfollow.do"})
    public String wapAddProductFavorite(HttpServletRequest request) throws Exception {
        XSaveOrUpdate xSaveOrUpdate = new XSaveOrUpdate("saveOrUpdateProductFavorite", request);
        xSaveOrUpdate.getParamMap().put("status", 2);
        baseManager.saveOrUpdate(xSaveOrUpdate);
        return "redirect:/purchaseCollect/wapCollectList.do";
    }
}
