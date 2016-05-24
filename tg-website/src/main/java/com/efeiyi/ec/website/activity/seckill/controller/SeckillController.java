package com.efeiyi.ec.website.activity.seckill.controller;

import com.efeiyi.ec.activity.seckill.model.SeckillProduct;
import com.efeiyi.ec.activity.seckill.model.SeckillRecord;
import com.efeiyi.ec.purchase.model.PurchaseOrder;
import com.efeiyi.ec.purchase.model.PurchaseOrderProduct;
import com.efeiyi.ec.website.organization.util.AuthorizationUtil;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.PageInfo;
import com.ming800.core.does.model.XQuery;
import com.ming800.core.util.HttpUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.net.URLEncoder;
import java.util.*;

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
        String requestUrl = request.getRequestURL().toString();
        String requestParam = request.getQueryString();
        try {
            if (!HttpUtil.isPhone(request)) {
                String url = requestUrl + "?" + requestParam;
                url = URLEncoder.encode(url, "UTF-8");
                return "redirect:/toMobile.do?mobileUrl=" + url;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        XQuery seckillQuery = new XQuery("plistSeckillProduct_default", request, 4);
        PageInfo pageInfo = baseManager.listPageInfo(seckillQuery);
        Date currentDate = new Date();
        if (pageInfo != null && pageInfo.getList() != null && !pageInfo.getList().isEmpty()) {
            Iterator iterator = pageInfo.getList().iterator();
            while (iterator.hasNext()) {
                SeckillProduct seckillProduct = (SeckillProduct) iterator.next();
                if (currentDate.getTime() > seckillProduct.getEndDatetime().getTime() || seckillProduct.getUsefulAmount() <= 0) {
                    iterator.remove();
                }
            }
            SeckillProduct seckillProduct = null;
            if (pageInfo != null && pageInfo.getList() != null && !pageInfo.getList().isEmpty()) {
                seckillProduct = (SeckillProduct) pageInfo.getList().get(0);

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

                if (seckillProduct.getUsefulAmount() <= 0) {
                    status = "3";
                }
                model.addAttribute("isShowTime", seckillProduct.getStartDatetime().getTime() - currentDate.getTime() < (24 * 60 * 60 * 1000));
                model.addAttribute("miaoStatus", status);
            }
        }

        model.addAttribute("productList", pageInfo.getList() != null ? pageInfo.getList() : new ArrayList<>());
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
        return seckillProduct.getUsefulAmount();
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
        seckillProduct.setAttentionAmount((seckillProduct.getAttentionAmount() != null ? seckillProduct.getAttentionAmount() : 0) + 1);
        baseManager.saveOrUpdate(SeckillProduct.class.getName(), seckillProduct);
        model.addAttribute("seckillProduct", seckillProduct);

        XQuery purchaseOrderProductQuery = new XQuery("listPurchaseOrderProduct_default", request);
        purchaseOrderProductQuery.put("productModel_id", seckillProduct.getProductModel().getId());
        List<Object> purchaseOrderProductList = baseManager.listObject(purchaseOrderProductQuery);
        Collections.reverse(purchaseOrderProductList);

        String stockAlert = request.getParameter("stock");
        model.addAttribute("stockAlert",stockAlert);

        //需要判断当前的秒杀是否是再24小时内
        //获得当前秒杀的状态 通过时间
        String status = "1";
        String recordStatus = "1";
        if (AuthorizationUtil.isAuthenticated()) {
            XQuery xQuery = new XQuery("listSeckillRecord_default", request);
            xQuery.put("seckillProductId", seckillProduct.getId());
            List<Object> recordList = baseManager.listObject(xQuery);
            if (recordList != null && recordList.isEmpty()) {
                recordStatus = "1";
            } else if (recordList != null && !recordList.isEmpty()) {
                recordStatus = "0";
            }
        }
        model.addAttribute("recordStatus", recordStatus);
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

        if (seckillProduct.getUsefulAmount() <= 0) {
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
    public String miaoBuy(@PathVariable String productId, @PathVariable String amount, HttpServletRequest request) throws Exception {
        synchronized (this) {
            SeckillProduct seckillProduct = (SeckillProduct) baseManager.getObject(SeckillProduct.class.getName(), productId);
            String status = "1";
            String recordStatus = "1";
            if (AuthorizationUtil.isAuthenticated()) {
                XQuery xQuery = new XQuery("listSeckillRecord_default", request);
                xQuery.put("seckillProductId", seckillProduct.getId());
                List<Object> recordList = baseManager.listObject(xQuery);
                if (recordList != null && recordList.isEmpty()) {
                    recordStatus = "1";
                } else if (recordList != null && !recordList.isEmpty()) {
                    recordStatus = "0";
                }
            }
//            if (recordStatus.equals("0")) {
//                return "redirect:/miao/" + productId;
//            }
            Date currentDate = new Date();
            if (seckillProduct.getUsefulAmount() < Integer.parseInt(amount)) {
                return "redirect:/miao/" + productId+"?stock=false";
            }
            if (currentDate.getTime() < seckillProduct.getEndDatetime().getTime() && currentDate.getTime() > seckillProduct.getStartDatetime().getTime()) {
                //秒杀正在进行中
                status = "2";
                //再这里减秒杀库存 减去可用库存
                seckillProduct.setUsefulAmount(seckillProduct.getUsefulAmount() - Integer.parseInt(amount));
                seckillProduct.setOrderAmount((seckillProduct.getOrderAmount() != null ? seckillProduct.getOrderAmount() : 0) + Integer.parseInt(amount));
                baseManager.saveOrUpdate(SeckillProduct.class.getName(), seckillProduct);
                String callback = "a.efeiyi.com/miao/wait/" + seckillProduct.getId() + "?userId=" + AuthorizationUtil.getMyUser().getId();
                callback = URLEncoder.encode(callback, "UTF-8");
                return "redirect:http://mall.efeiyi.com/order/saveOrUpdateOrder2.do?productModelId=" + seckillProduct.getProductModel().getId() + "&amount=" + amount + "&price=" + seckillProduct.getPrice() + "&callback=" + callback + "&orderType=2";
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


    @RequestMapping({"/miao/wait/{productId}"})
    public String waitPage(@PathVariable String productId, HttpServletRequest request, Model model) {
        String purchaseOrderId = request.getParameter("purchaseOrderId");
        PurchaseOrder purchaseOrder = (PurchaseOrder) baseManager.getObject(PurchaseOrder.class.getName(), purchaseOrderId);
        if (purchaseOrder.getOrderStatus() == PurchaseOrder.ORDER_STATUS_WRECEIVE) {
            return "redirect:/miao/share/" + productId + "?purchaseOrderId=" + purchaseOrderId + "&userId=" + (request.getParameter("userId") != null ? request.getParameter("userId") : "");
        } else {
            model.addAttribute("redirect", "/miao/share/" + productId + "?purchaseOrderId=" + purchaseOrderId + "&userId=" + (request.getParameter("userId") != null ? request.getParameter("userId") : ""));
            model.addAttribute("productId", productId);
            model.addAttribute("purchaseOrderId", purchaseOrderId);
            return "/activity/orderDeal";
        }
    }

    @RequestMapping({"/miao/payError.do"})
    public String payError(HttpServletRequest request) {
        //支付失败的时候应该是 +可用库存 -订单库存
        String productId = request.getParameter("productId");
        SeckillProduct seckillProduct = (SeckillProduct) baseManager.getObject(SeckillProduct.class.getName(), productId);
        seckillProduct.setUsefulAmount((seckillProduct.getUsefulAmount() != null ? seckillProduct.getUsefulAmount() : 0) + 1);
        seckillProduct.setOrderAmount(seckillProduct.getOrderAmount() - 1);
        baseManager.saveOrUpdate(SeckillProduct.class.getName(), seckillProduct);
        return "redirect:/miao/" + productId;
    }

    @RequestMapping({"/miao/share/{productId}"})
    public String share(@PathVariable String productId, HttpServletRequest request, Model model) {
        //支付成功的时候需要 +不可用库存 -订单库存
        String currentUserId = request.getParameter("userId");
        String purchaseOrderId = request.getParameter("purchaseOrderId");
        PurchaseOrder purchaseOrder = (PurchaseOrder) baseManager.getObject(PurchaseOrder.class.getName(), purchaseOrderId);
        int amount = 0;
        List<PurchaseOrderProduct> purchaseOrderProducts = purchaseOrder.getPurchaseOrderProductList();
        if (purchaseOrderProducts != null && !purchaseOrderProducts.isEmpty()) {
            PurchaseOrderProduct purchaseOrderProduct = purchaseOrderProducts.get(0);
            amount = purchaseOrderProduct.getPurchaseAmount();
        }

        SeckillProduct seckillProduct = (SeckillProduct) baseManager.getObject(SeckillProduct.class.getName(), productId);
        if (AuthorizationUtil.isAuthenticated() && currentUserId.equals(AuthorizationUtil.getUser().getId())) {
            //创建秒杀记录 证明当前用户已经参与过该次秒杀
            SeckillRecord seckillRecord = new SeckillRecord();
            seckillRecord.setCreateDatetime(new Date());
            seckillRecord.setUserId(AuthorizationUtil.getMyUser().getId());
            seckillRecord.setSeckillProductId(seckillProduct.getId());
            baseManager.saveOrUpdate(SeckillRecord.class.getName(), seckillRecord);
            model.addAttribute("product", seckillProduct);
            seckillProduct.setUnusefulAmount((seckillProduct.getUnusefulAmount() != null ? seckillProduct.getUnusefulAmount() : 0) + amount);
            seckillProduct.setOrderAmount(seckillProduct.getOrderAmount() - amount);
            baseManager.saveOrUpdate(SeckillProduct.class.getName(), seckillProduct);
            return "/activity/seckillShare";
        } else {
            return "redirect:/miao/" + seckillProduct.getId();
        }
    }
}
