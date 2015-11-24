package com.efeiyi.ec.website.activity.controller;

import com.efeiyi.ec.activity.model.SeckillProduct;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.PageInfo;
import com.ming800.core.does.model.XQuery;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.ws.rs.Path;
import java.util.Collections;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

/**
 * Created by Administrator on 2015/11/17 0017.
 */
@Controller
//@RequestMapping({"/miao"})
public class SeckillController {

    @Autowired
    private BaseManager baseManager;

    /**
     * 当天秒杀的商品，所有秒杀的商品 以开始时间排序 往期回顾？
     *
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/miao")
    public String listSeckillProduct(HttpServletRequest request, Model model) throws Exception {
        XQuery seckillQuery = new XQuery("plistSeckillProduct_default", request, 4);
        PageInfo pageInfo = baseManager.listPageInfo(seckillQuery);
        Date currentDate = new Date();
        Iterator iterator = pageInfo.getList().iterator();
        while (iterator.hasNext()) {
            SeckillProduct seckillProduct = (SeckillProduct) iterator.next();
            if (currentDate.getTime() > seckillProduct.getEndDatetime().getTime() || seckillProduct.getAmount() <= 0) {
                iterator.remove();
            }
        }
        model.addAttribute("productList", pageInfo.getList());
        model.addAttribute("pageInfo", pageInfo);
        return "/activity/seckillProductList";
    }


    /**
     * 秒杀商品分为几个状态 1.已经开始 2.已经结束 3.即将开始
     *
     * @param request
     * @param model
     * @param seckillProductId
     * @return
     * @throws Exception
     */
    @RequestMapping("/miao/{seckillProductId}")
    public String viewSeckillProduct(HttpServletRequest request, Model model, @PathVariable String seckillProductId) throws Exception {
        SeckillProduct seckillProduct = (SeckillProduct) baseManager.getObject(SeckillProduct.class.getName(), seckillProductId);
        seckillProduct.setAttentionAmount((seckillProduct.getAttentionAmount() == null ? seckillProduct.getAttentionAmount() : 0) + 1);
        model.addAttribute("seckillProduct", seckillProduct);

        XQuery purchaseOrderProductQuery = new XQuery("listPurchaseOrderProduct_default",request);
        purchaseOrderProductQuery.put("productModel_id", seckillProduct.getProductModel().getId());
        List<Object> purchaseOrderProductList = baseManager.listObject(purchaseOrderProductQuery);
        Collections.reverse(purchaseOrderProductList);

//        XQuery productPicturexQuery = new XQuery("listProductPicture_default",request);
//        productPicturexQuery.put("product_id",seckillProduct.getProductModel().getProduct().getId());
//        List<Object> productPictureList = baseManager.listObject(productPicturexQuery);
//        model.addAttribute("productPictureList",productPictureList);

        //获得当前秒杀的状态 通过时间
        String status = "1";
        Date currentDate = new Date();
        if (currentDate.getTime() < seckillProduct.getEndDatetime().getTime() && currentDate.getTime() > seckillProduct.getStartDatetime().getTime()) {
            //秒杀正在进行中
            status = "2";
        } else if (currentDate.getTime() > seckillProduct.getEndDatetime().getTime()) {
            //秒杀已经结束
            status = "3";
        } else if (currentDate.getTime() < seckillProduct.getStartDatetime().getTime()) {
            //即将开始
            status = "1";
        }

        if (seckillProduct.getAmount() <= 0) {
            status = "3";
        }
        model.addAttribute("miaoStatus", status);
        return "/activity/seckillProductView";
    }


    @RequestMapping({"/miao/buy/{productId}/{amount}"})
    public String miaoBuy(@PathVariable String productId, @PathVariable String amount) {
        synchronized (this) {
            SeckillProduct seckillProduct = (SeckillProduct) baseManager.getObject(SeckillProduct.class.getName(), productId);
            String status = "1";
            Date currentDate = new Date();
            if (seckillProduct.getAmount() <= 0) {
                return "redirect:/miao/" + productId;
            }
            if (currentDate.getTime() < seckillProduct.getEndDatetime().getTime() && currentDate.getTime() > seckillProduct.getStartDatetime().getTime()) {
                //秒杀正在进行中
                status = "2";
                //再这里减秒杀库存
                seckillProduct.setAmount(seckillProduct.getAmount()-Integer.parseInt(amount));
                return "redirect:http://www.efeiyi.com/order/miaoBuy/" + productId + "/" + amount;
            } else if (currentDate.getTime() > seckillProduct.getEndDatetime().getTime()) {
                //秒杀已经结束
                status = "3";
                return "redirect:/miao/" + productId;
            } else if (currentDate.getTime() < seckillProduct.getStartDatetime().getTime()) {
                //即将开始
                status = "1";
                return "redirect:/miao/" + productId;
            } else {
                return "redirect:/miao/" + productId;
            }
        }
    }
}
