package com.efeiyi.ec.website.order.controller;

import com.efeiyi.ec.organization.model.Consumer;
import com.efeiyi.ec.purchase.model.*;
import com.efeiyi.ec.website.organization.util.AuthorizationUtil;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import com.ming800.core.p.model.AutoSerial;
import com.ming800.core.p.service.AutoSerialManager;
import com.ming800.core.p.service.impl.AutoSerialManagerImpl;
import com.ming800.core.util.DateUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * Created by Administrator on 2015/9/14 0014.
 * 优惠券的部分包括领取优惠券和使用优惠券
 * 领取优惠卷则是列出所有可用优惠券，这里包括 1.全场通用的优惠券 2.店铺优惠券 3.单品优惠券 每个订单只能使用一张优惠券
 * 每次注册用户的时候都需要发放一张优惠券，这个时候需要设定一下默认是发放哪种优惠券，后台加个接口选择一下需要发放的优惠券
 */
@Controller
public class CouponController {

    @Autowired
    private BaseManager baseManager;

    @Autowired
    private AutoSerialManager autoSerialManager;


    @RequestMapping({"/listUserCoupon.do"})
    @ResponseBody
    public List<Object> listUserCoupon(HttpServletRequest request) throws Exception {
        PurchaseOrder purchaseOrder = (PurchaseOrder) baseManager.getObject(PurchaseOrder.class.getName(), request.getParameter("purchaseOrderId"));
        XQuery couponQuery = new XQuery("listCoupon_useful", request);
        couponQuery.put("couponBatch_startDate", new Date());
        couponQuery.put("couponBatch_endDate", new Date());
        List<Object> couponList = baseManager.listObject(couponQuery);
        Iterator couponIterator = couponList.iterator();
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
        while (couponIterator.hasNext()) {
            Coupon couponTemp = (Coupon) couponIterator.next();
            couponTemp.setStartTimeL(simpleDateFormat.format(couponTemp.getCouponBatch().getStartDate()));
            couponTemp.setEndTimeL(simpleDateFormat.format(couponTemp.getCouponBatch().getEndDate()));
            if (!isUserful(purchaseOrder, couponTemp)) {
                couponIterator.remove();
            }
        }
        return couponList;
    }

    //判断优惠券是否可以用（对于某个订单）
    //优惠券的种类有三种，1全场通用 2店铺 3品类 4单品 都需要判断
    //1全场通用 ： 如果是满减卷就只判断订单的价格，如果是低值卷，那么就不用判断了
    //2店铺 ： 判断订单中是否有该店铺的商品，如果有就继续判断如果是满减，就判断订单价格，低值卷就不用判断了直接可用
    //3品类 ： 判断订单中是否有该品类的商品，如果有就继续判断如果是满减，就判断订单价格，低值卷就不用判断了直接可用
    //4单品 ： 判断订单中是否有该优惠券指定的商品，如果有就不用判断了直接可用
    private boolean isUserful(PurchaseOrder purchaseOrder, Coupon coupon) {
        try {
            boolean isUseful = false;
            if (coupon.getCouponBatch().getRange().equals("1")) {
                if (coupon.getCouponBatch().getType().equals("1")) {
                    if (purchaseOrder.getTotal().floatValue() >= coupon.getCouponBatch().getPriceLimit()) {
                        isUseful = true;
                    } else {
                        isUseful = false;
                    }
                } else {
                    isUseful = true;
                }
            } else if (coupon.getCouponBatch().getRange().equals("2")) {
                for (PurchaseOrderProduct purchaseOrderProduct : purchaseOrder.getPurchaseOrderProductList()) {
                    if (purchaseOrderProduct.getProductModel().getProduct().getProject().getId().equals(coupon.getCouponBatch().getProject().getId())) {
                        if (coupon.getCouponBatch().getType().equals("1")) {
                            BigDecimal totalPrice = new BigDecimal(0);
                            for (PurchaseOrderProduct purchaseOrderProductTemp : purchaseOrder.getPurchaseOrderProductList()) {
                                if (purchaseOrderProductTemp.getProductModel().getProduct().getProject().getId().equals(coupon.getCouponBatch().getProject().getId())) {
                                    totalPrice = totalPrice.add(purchaseOrderProduct.getPurchasePrice());
                                }
                            }
                            totalPrice = totalPrice.setScale(2, BigDecimal.ROUND_HALF_UP);
                            if (Float.parseFloat(totalPrice.toString()) >= coupon.getCouponBatch().getPriceLimit()) {
                                isUseful = true;
                            } else {
                                isUseful = false;
                            }
                        } else {
                            isUseful = true;
                        }
                        if (isUseful) {
                            break;
                        }
                    }
                }
            } else if (coupon.getCouponBatch().getRange().equals("3")) {
                for (PurchaseOrderProduct purchaseOrderProduct : purchaseOrder.getPurchaseOrderProductList()) {
                    if (purchaseOrderProduct.getProductModel().getProduct().getTenant().getId().equals(coupon.getCouponBatch().getTenant().getId())) {
                        if (coupon.getCouponBatch().getType().equals("1")) {
                            BigDecimal totalPrice = new BigDecimal(0);
                            for (PurchaseOrderProduct purchaseOrderProductTemp : purchaseOrder.getPurchaseOrderProductList()) {
                                if (purchaseOrderProductTemp.getProductModel().getProduct().getTenant().getId().equals(coupon.getCouponBatch().getTenant().getId())) {
                                    totalPrice = totalPrice.add(purchaseOrderProduct.getPurchasePrice());
                                }
                            }
                            totalPrice = totalPrice.setScale(2, BigDecimal.ROUND_HALF_UP);
                            if (Float.parseFloat(totalPrice.toString()) >= coupon.getCouponBatch().getPriceLimit()) {
                                isUseful = true;
                            } else {
                                isUseful = false;
                            }
                        } else {
                            isUseful = true;
                        }
                        if (isUseful) {
                            break;
                        }
                    } else {
                        isUseful = false;
                    }
                }
            } else if (coupon.getCouponBatch().getRange().equals("4")) {
                for (PurchaseOrderProduct purchaseOrderProduct : purchaseOrder.getPurchaseOrderProductList()) {
                    if (purchaseOrderProduct.getProductModel().getProduct().getId().equals(coupon.getCouponBatch().getProduct().getId())) {
                        isUseful = true;
                        break;
                    } else {
                        isUseful = false;
                    }
                }
            }

            return isUseful;
        } catch (Exception e) {
            return false;
        }
    }


    /**
     * 列出单品优惠券
     *
     * @return
     */
    @RequestMapping({"/listProductCoupon.do"})
    @ResponseBody
    public List<Object> listProductCoupon(HttpServletRequest request) throws Exception {
        XQuery productCouponXQuery = new XQuery("listCouponBatch_product", request);
        productCouponXQuery.put("priceLimit", Float.parseFloat(request.getParameter("priceLimit")));
        productCouponXQuery.put("product_id", request.getParameter("productId"));
        return baseManager.listObject(productCouponXQuery);
    }

    /**
     * 列出店铺优惠券
     *
     * @return
     */
    @RequestMapping({"/listTenantCoupon.do"})
    @ResponseBody
    public List<Object> listTenantCoupon(HttpServletRequest request) throws Exception {
        XQuery productCouponXQuery = new XQuery("listCouponBatch_product", request);
        productCouponXQuery.put("priceLimit", Float.parseFloat(request.getParameter("priceLimit")));
        productCouponXQuery.put("tenant_id", request.getParameter("tenantId"));
        return baseManager.listObject(productCouponXQuery);
    }

    /**
     * 列出店铺优惠券
     *
     * @return
     */
    @RequestMapping({"/listNormalCoupon.do"})
    @ResponseBody
    public List<Object> listNormalCoupon(HttpServletRequest request) throws Exception {
        XQuery productCouponXQuery = new XQuery("listCouponBatch_normal", request);
        productCouponXQuery.put("priceLimit", Float.parseFloat(request.getParameter("priceLimit")));
        return baseManager.listObject(productCouponXQuery);
    }

    /**
     * 领取优惠券
     * 生成优惠券的时候需要生成一个兑换码  生成规则是 创建时间+随机数201510231000007043
     *
     * @return
     */
    @RequestMapping({"/claimCoupon/{unkey}"})
    @ResponseBody
    public boolean claimCoupon(HttpServletRequest request, @PathVariable String unkey) throws Exception {
        XQuery xQuery = new XQuery("listCouponBatch_bycdkey", request);
        xQuery.put("uniqueKey", unkey);
        Date date = new Date();
        xQuery.put("startDate", date);
        xQuery.put("endDate", date);
        List<Object> couponBatchList = baseManager.listObject(xQuery);
        CouponBatch couponBatch = null;
        if (couponBatchList != null && couponBatchList.size() > 0) {
            couponBatch = (CouponBatch) couponBatchList.get(0);
        }
        Coupon coupon = new Coupon();
        coupon.setStatus("1");
        coupon.setSerial(autoSerialManager.nextSerial("orderSerial"));
        coupon.setCouponBatch(couponBatch);
        Date currentDate = new Date();
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyyMMdd");
        String currentDateStr = simpleDateFormat.format(currentDate);
        coupon.setUniqueKey(currentDateStr + coupon.getSerial());
        Consumer consumer = (Consumer) baseManager.getObject(Consumer.class.getName(), AuthorizationUtil.getMyUser().getId());
        coupon.setConsumer(consumer);
        baseManager.saveOrUpdate(Coupon.class.getName(), coupon);
        return true;
    }

    @RequestMapping({"/exchangeCoupon.do"})
    @ResponseBody
    public Object exchangeCoupon(HttpServletRequest request) throws Exception {
        synchronized (this) {
            Coupon coupon = null;
            String cdkey = request.getParameter("cdkey");
            String purchaseOrderId = request.getParameter("purchaseOrderId");
            PurchaseOrder purchaseOrder = (PurchaseOrder) baseManager.getObject(PurchaseOrder.class.getName(), purchaseOrderId);
            XQuery xQuery = new XQuery("listCouponBatch_bycdkey", request);
            xQuery.put("uniqueKey", cdkey);
            Date date = new Date();
            xQuery.put("startDate", date);
            xQuery.put("endDate", date);
            List<Object> couponBatchList = baseManager.listObject(xQuery);
            if (couponBatchList != null && couponBatchList.size() > 0) {
                CouponBatch currentCouponBatch = (CouponBatch) couponBatchList.get(0);
                if (currentCouponBatch.getAmount() != null) {
                    if (currentCouponBatch.getCouponList() != null && currentCouponBatch.getAmount() <= currentCouponBatch.getCouponList().size()) {
                        return "null";
                    }
                }
//            生成一张该批次的优惠券  这里使用的是通码
                coupon = new Coupon();
                coupon.setStatus("1");
                coupon.setSerial(autoSerialManager.nextSerial("orderSerial"));
                coupon.setCouponBatch(currentCouponBatch);
                Date currentDate = new Date();
                SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyyMMdd");
                String currentDateStr = simpleDateFormat.format(currentDate);
                coupon.setUniqueKey(currentDateStr + coupon.getSerial());
                Consumer consumer = (Consumer) baseManager.getObject(Consumer.class.getName(), AuthorizationUtil.getMyUser().getId());
                coupon.setConsumer(consumer);
                baseManager.saveOrUpdate(Coupon.class.getName(), coupon);
                SimpleDateFormat simpleDateFormat2 = new SimpleDateFormat("yyyy-MM-dd");
                coupon.setStartTimeL(simpleDateFormat2.format(coupon.getCouponBatch().getStartDate()));
                coupon.setEndTimeL(simpleDateFormat2.format(coupon.getCouponBatch().getEndDate()));
            } else {
                XQuery xQuery2 = new XQuery("listCoupon_bycdkey", request);
                xQuery2.setQueryHql(xQuery2.getQueryHql() + " and s.consumer.id is null ");
                xQuery2.updateHql();
                xQuery2.put("uniqueKey", cdkey);
                xQuery2.put("couponBatch_startDate", date);
                xQuery2.put("couponBatch_endDate", date);
                List result = baseManager.listObject(xQuery2);
                if (result != null && result.size() > 0) {
                    coupon = (Coupon) result.get(0);
                    if (coupon.getStatus().equals("2") || coupon.getWhetherBind().equals("2")) {
                        return "null";
                    }
                    Consumer consumer = (Consumer) baseManager.getObject(Consumer.class.getName(), AuthorizationUtil.getMyUser().getId());
                    coupon.setConsumer(consumer);
                    coupon.setWhetherBind("2");
                    baseManager.saveOrUpdate(Coupon.class.getName(), coupon);
                    SimpleDateFormat simpleDateFormat2 = new SimpleDateFormat("yyyy-MM-dd");
                    coupon.setStartTimeL(simpleDateFormat2.format(coupon.getCouponBatch().getStartDate()));
                    coupon.setEndTimeL(simpleDateFormat2.format(coupon.getCouponBatch().getEndDate()));
                }
            }


            if (coupon == null) {
                return "null";
            } else {
                coupon.setIsUseful(isUserful(purchaseOrder, coupon) ? "1" : "0");
                List<Object> couponList = new ArrayList<>();
                couponList.add(coupon);
                return couponList;
            }
        }
    }


    @RequestMapping({"/useCoupon.do"})
    @ResponseBody
    public boolean useCoupon(HttpServletRequest request) {
        try {
            String status = request.getParameter("status"); //1选中 2未选中
            String purchaseOrderId = request.getParameter("purchaseOrderId");
            String couponId = request.getParameter("couponId");
            PurchaseOrder purchaseOrder = (PurchaseOrder) baseManager.getObject(PurchaseOrder.class.getName(), purchaseOrderId);
            Coupon coupon = (Coupon) baseManager.getObject(Coupon.class.getName(), couponId);
            if (purchaseOrder != null && coupon != null) {
                if (status.equals("1")) {
                    purchaseOrder.setCoupon(coupon);
                    baseManager.saveOrUpdate(PurchaseOrder.class.getName(), purchaseOrder);
                } else {
                    purchaseOrder.setCoupon(null);
                    baseManager.saveOrUpdate(PurchaseOrder.class.getName(), purchaseOrder);
                }
            }
            return true;
        } catch (Exception e) {
            return false;
        }
    }

    /**
     * 列出通用优惠券
     *
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping({"/coupon/list/{orderId}"})
    @ResponseBody
    public List<Coupon> listCouponByOrder(HttpServletRequest request, Model model, @PathVariable String orderId) throws Exception {
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm");
        PurchaseOrder purchaseOrder = (PurchaseOrder) baseManager.getObject(PurchaseOrder.class.getName(), orderId);
        XQuery couponQuery = new XQuery("listCoupon_byorder", request);
        couponQuery.put("couponBatch_startDate", new Date());
        couponQuery.put("couponBatch_endDate", new Date());
        List<Coupon> couponList = baseManager.listObject(couponQuery);
        Iterator<Coupon> couponIterator = couponList.iterator();
        while (couponIterator.hasNext()) {
            Coupon coupon = couponIterator.next();
            if (isUserful(purchaseOrder, coupon)) {
                coupon.getCouponBatch().setStartDateString(df.format(coupon.getCouponBatch().getStartDate()));
                coupon.getCouponBatch().setEndDateString(df.format(coupon.getCouponBatch().getEndDate()));
            } else {
                couponIterator.remove();
            }
        }
        model.addAttribute("couponList", couponList);
        return couponList;
    }

    @RequestMapping({"/coupon/listCoupon"})
    @ResponseBody
    public List<Object> listCouponBypriceLimit(HttpServletRequest request, Model model) throws Exception {
        XQuery xQuery = new XQuery("listCart_default", request);
        List<Object> list = baseManager.listObject(xQuery);
        Cart cart = (Cart) list.get(0);
        XQuery couponQuery = new XQuery("listCoupon_byorder", request);
        couponQuery.put("couponBatch_priceLimit", cart.getTotalPrice().floatValue());
        List<Object> couponList = baseManager.listObject(couponQuery);
        model.addAttribute("couponList", couponList);
        return couponList;
    }

    //使用优惠卷 使用优惠券可以放到manager中去处理 （使用优惠券只在结算页面可以使用）
    @RequestMapping({"/coupon/use.do"})
    @ResponseBody
    public boolean useCouponByOrder(HttpServletRequest request) {
        String orderId = request.getParameter("orderId");
        String couponId = request.getParameter("couponId");
        PurchaseOrder purchaseOrder = (PurchaseOrder) baseManager.getObject(PurchaseOrder.class.getName(), orderId);
        Coupon coupon = (Coupon) baseManager.getObject(Coupon.class.getName(), couponId);
        purchaseOrder.setCoupon(coupon);
        baseManager.saveOrUpdate(PurchaseOrder.class.getName(), purchaseOrder);
        return true;

    }

    /**
     * 发放优惠券
     *
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping({"/coupon/sentEverybodyACoupon"})
    public String sentCoupon(HttpServletRequest request, Model model) throws Exception {
        String time = request.getParameter("time");
        String month = time.substring(0, 2);
        String day = time.substring(2, 4);
        String hour = time.substring(4, 6);
        String min = time.substring(6, 8);
        String limitTime1 = "2015-" + month + "-" + day + " " + hour + ":" + min + ":" + "00";
        Date limitTime = DateUtil.parseAllDate(limitTime1);
        Date date = new Date();
        String queryHql = "from " + Consumer.class.getName() + " t where t.createDatetime >= :limitTime and t.createDatetime <= :timeNow order by t.id desc";
        LinkedHashMap<String, Object> queryParamMap = new LinkedHashMap<>();
        queryParamMap.put("limitTime", limitTime);
        queryParamMap.put("timeNow", date);
        List<Consumer> list1 = baseManager.listObject(queryHql, queryParamMap);
        XQuery xQuery2 = new XQuery("listCouponBatch_default", request);
        List<CouponBatch> list2 = baseManager.listObject(xQuery2);
        List list = new ArrayList();
        for (Consumer consumer : list1) {
            for (CouponBatch couponBatch : list2) {
                Coupon coupon = new Coupon();
                coupon.setConsumer(consumer);
                coupon.setCouponBatch(couponBatch);
                coupon.setStatus("1");

                baseManager.saveOrUpdate(Coupon.class.getName(), coupon);
                list.add(coupon);
            }
        }
        model.addAttribute("list", list);
        return "/purchaseOrder/couponMessage";

    }


    //------------------------------------------------------以下代码 待优化---------------------------------------------------

    @RequestMapping("/coupon/couponActivities.do")
    public String couponActivities(HttpServletRequest request, Model model) {
        model.addAttribute("couponBatchId", request.getParameter("couponBatchId"));
        return "/yhq";
    }

    @RequestMapping("/coupon/getCouponView.do")
    public String getCouponView(HttpServletRequest request, Model model) throws Exception {
        Coupon coupon;
        Date date = new Date();
        String couponBatchId = request.getParameter("couponBatchId");
        Consumer consumer = (Consumer) baseManager.getObject(Consumer.class.getName(), AuthorizationUtil.getMyUser().getId());
        CouponBatch couponBatch = (CouponBatch) baseManager.getObject(CouponBatch.class.getName(), couponBatchId);
        XQuery xQuery1 = new XQuery("listCoupon_have", request);
        xQuery1.put("couponBatch_id", couponBatchId);
        xQuery1.put("consumer_id", consumer.getId());
        List haveUser = baseManager.listObject(xQuery1);
        synchronized (this) {
            if (couponBatch != null) {
                if (haveUser == null || haveUser.size() == 0) {
                    XQuery xQuery3 = new XQuery("listCoupon_qbyhq", request);
                    xQuery3.put("couponBatch_id", couponBatchId);
                    List yhqList = baseManager.listObject(xQuery3);
                    XQuery xQuery2 = new XQuery("listCoupon_pdyhq", request);
                    xQuery2.put("couponBatch_id", couponBatchId);
                    List result = baseManager.listObject(xQuery2);
                    if (yhqList.size() != couponBatch.getAmount()) {
                        coupon = new Coupon();
                        coupon.setConsumer(consumer);
                        coupon.setStatus("1");
                        coupon.setSerial(autoSerialManager.nextSerial("orderSerial"));
                        coupon.setCouponBatch(couponBatch);
                        coupon.setWhetherBind("2");
                        coupon.setBindTime(date);
                        baseManager.saveOrUpdate(Coupon.class.getName(), coupon);
                        model.addAttribute("yhq", coupon);
                    } else if (result.size() > 0) {
                        coupon = (Coupon) result.get(0);
                        coupon.setConsumer(consumer);
                        coupon.setWhetherBind("2");
                        coupon.setBindTime(date);
                        baseManager.saveOrUpdate(Coupon.class.getName(), coupon);
                        model.addAttribute("yhq", coupon);
                    } else {
                        model.addAttribute("yhq", null);
                    }
                } else {
                    model.addAttribute("yhq", "used");
                }
            } else {
                model.addAttribute("yhq", null);
            }
        }
        return "/getYhq";
    }
}
