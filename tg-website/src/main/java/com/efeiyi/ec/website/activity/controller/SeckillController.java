package com.efeiyi.ec.website.activity.controller;

import com.efeiyi.ec.activity.model.SeckillProduct;
import com.efeiyi.ec.purchase.model.PurchaseOrder;
import com.efeiyi.ec.website.organization.util.AuthorizationUtil;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.PageInfo;
import com.ming800.core.does.model.XQuery;
import javafx.beans.property.adapter.ReadOnlyJavaBeanBooleanProperty;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

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
        if (pageInfo != null && pageInfo.getList() != null && !pageInfo.getList().isEmpty()) {
            Iterator iterator = pageInfo.getList().iterator();
            while (iterator.hasNext()) {
                SeckillProduct seckillProduct = (SeckillProduct) iterator.next();
                if (currentDate.getTime() > seckillProduct.getEndDatetime().getTime() || seckillProduct.getAmount() <= 0) {
                    iterator.remove();
                }
            }
            SeckillProduct seckillProduct = (SeckillProduct) pageInfo.getList().get(0);

            String status = "1";
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
            model.addAttribute("isShowTime", seckillProduct.getStartDatetime().getTime() - currentDate.getTime() < (24 * 60 * 60 * 1000));
            model.addAttribute("miaoStatus", status);
        }

        model.addAttribute("productList", pageInfo.getList());
        model.addAttribute("pageInfo", pageInfo);
        return "/activity/seckillProductList";
    }

    @RequestMapping({"/miao/order.do"})
    @ResponseBody
    public List<Object> listSeckillOrder(HttpServletRequest request) throws Exception {
        String productModelId = request.getParameter("productModelId");
        XQuery xQuery = new XQuery("listPurchaseOrder_default", request);
        xQuery.setHeadHql(xQuery.getHeadHql() + " inner join s.purchaseOrderProductList pp ");
        xQuery.setQueryHql(xQuery.getQueryHql() + " and pp.productModel.id=:productModelId ");
        xQuery.updateHql();
        xQuery.put("productModelId", productModelId);
        List<Object> purchaseOrderList = baseManager.listObject(xQuery);
        return purchaseOrderList;
    }

    @RequestMapping({"/miao/amount.do"})
    @ResponseBody
    public int fetchProductAmount(HttpServletRequest request) {
        String seckillProductId = request.getParameter("productId");
        SeckillProduct seckillProduct = (SeckillProduct) baseManager.getObject(SeckillProduct.class.getName(), seckillProductId);
        return seckillProduct.getAmount();
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
        baseManager.saveOrUpdate(SeckillProduct.class.getName(), seckillProduct);
        model.addAttribute("seckillProduct", seckillProduct);

        XQuery purchaseOrderProductQuery = new XQuery("listPurchaseOrderProduct_default", request);
        purchaseOrderProductQuery.put("productModel_id", seckillProduct.getProductModel().getId());
        List<Object> purchaseOrderProductList = baseManager.listObject(purchaseOrderProductQuery);
        Collections.reverse(purchaseOrderProductList);

        //需要判断当前的秒杀是否是再24消失内
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

        if (status.equals("1")) {
            //大于24小时
            model.addAttribute("isShowTime", seckillProduct.getStartDatetime().getTime() - currentDate.getTime() < (24 * 60 * 60 * 1000));
        }

        if (status == "3") {
            XQuery xQuery = new XQuery("plistPurchaseOrder_byDatetime", request, 1);
            xQuery.setHeadHql(xQuery.getHeadHql() + " inner join s.purchaseOrderProductList pp ");
            xQuery.setQueryHql(xQuery.getQueryHql() + " and pp.productModel.id=:productModelId ");
            xQuery.updateHql();
            xQuery.put("productModelId", seckillProduct.getProductModel().getId());
            List<Object> purchaseOrderList = baseManager.listObject(xQuery);
            if (!purchaseOrderList.isEmpty()) {
                Date finalOrderDatetime = ((PurchaseOrder) purchaseOrderList.get(0)).getCreateDatetime();
                long userTime = finalOrderDatetime.getTime() - seckillProduct.getStartDatetime().getTime();
                long time = userTime / 1000;
                long m = time / 60;
                long s = time % 60;
                model.addAttribute("minute", m);
                model.addAttribute("second", s);
            }
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
                seckillProduct.setAmount(seckillProduct.getAmount() - Integer.parseInt(amount));
                String callback = "a.efeiyi.com/miao/share/" + seckillProduct.getId() + "?userId=" + AuthorizationUtil.getMyUser().getId();
                return "redirect:http://www2.efeiyi.com/order/saveOrUpdateOrder2.do?productModelId=" + seckillProduct.getProductModel().getId() + "&amount=" + amount + "&price=" + seckillProduct.getPrice();
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

    @RequestMapping({"/miao/share/{productId}"})
    public String share(@PathVariable String productId, HttpServletRequest request) {
        String currentUserId = request.getParameter("userId");
        SeckillProduct seckillProduct = (SeckillProduct) baseManager.getObject(SeckillProduct.class.getName(), productId);
        if (AuthorizationUtil.isAuthenticated() && currentUserId.equals(AuthorizationUtil.getUser().getId())) {
            return "/activity/seckillShare";
        } else {
            return "redirect:/miao/" + seckillProduct.getId();
        }
    }
}
