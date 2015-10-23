package com.efeiyi.ec.website.order.controller;

import com.efeiyi.ec.organization.model.Consumer;
import com.efeiyi.ec.purchase.model.Cart;
import com.efeiyi.ec.purchase.model.Coupon;
import com.efeiyi.ec.purchase.model.CouponBatch;
import com.efeiyi.ec.purchase.model.PurchaseOrder;
import com.efeiyi.ec.website.organization.util.AuthorizationUtil;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import com.ming800.core.p.service.AutoSerialManager;
import com.ming800.core.util.DateUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
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



    /**
     * 列出单品优惠券
     * @return
     */
    @RequestMapping({"/listProductCoupon.do"})
    @ResponseBody
    public List<Object> listProductCoupon(HttpServletRequest request) throws Exception{
        XQuery productCouponXQuery = new XQuery("listCouponBatch_product",request);
        productCouponXQuery.put("priceLimit",Float.parseFloat(request.getParameter("priceLimit")));
        productCouponXQuery.put("product_id", request.getParameter("productId"));
        return baseManager.listObject(productCouponXQuery);
    }

    /**
     * 列出店铺优惠券
     * @return
     */
    @RequestMapping({"/listTenantCoupon.do"})
    @ResponseBody
    public List<Object> listTenantCoupon(HttpServletRequest request) throws Exception{
        XQuery productCouponXQuery = new XQuery("listCouponBatch_product",request);
        productCouponXQuery.put("priceLimit",Float.parseFloat(request.getParameter("priceLimit")));
        productCouponXQuery.put("tenant_id", request.getParameter("tenantId"));
        return baseManager.listObject(productCouponXQuery);
    }

    /**
     * 列出店铺优惠券
     * @return
     */
    @RequestMapping({"/listNormalCoupon.do"})
    @ResponseBody
    public List<Object> listNormalCoupon(HttpServletRequest request) throws Exception{
        XQuery productCouponXQuery = new XQuery("listCouponBatch_normal",request);
        productCouponXQuery.put("priceLimit",Float.parseFloat(request.getParameter("priceLimit")));
        return baseManager.listObject(productCouponXQuery);
    }

    /**
     * 领取优惠券
     * 生成优惠券的时候需要生成一个兑换码  生成规则是 创建时间+随机数201510231000007043
     * @return
     */
    @RequestMapping({"/claimCoupon.do"})
    @ResponseBody
    public boolean claimCoupon(HttpServletRequest request) throws Exception{
        String couponBatchId = request.getParameter("couponBatchId");
        CouponBatch couponBatch = (CouponBatch)baseManager.getObject(CouponBatch.class.getName(),couponBatchId);
        Coupon coupon = new Coupon();
        coupon.setStatus("1");
        coupon.setSerial(autoSerialManager.nextSerial("orderSerial"));
        coupon.setCouponBatch(couponBatch);
        Date currentDate = new Date();
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyyMMdd");
        String currentDateStr = simpleDateFormat.format(currentDate);
        coupon.setCdkey(currentDateStr+coupon.getSerial());
        Consumer consumer = (Consumer)baseManager.getObject(Consumer.class.getName(),AuthorizationUtil.getMyUser().getId());
        coupon.setConsumer(consumer);
        baseManager.saveOrUpdate(Coupon.class.getName(),coupon);
        return true;
    }

    @RequestMapping({"/exchangeCoupon.do"})
    public boolean exchangeCoupon(){
        return true;
    }

    /**
     * 列出通用优惠券
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping({"/coupon/list/{orderId}"})
    @ResponseBody
    public List<Coupon> listCouponByOrder(HttpServletRequest request , Model model,@PathVariable String orderId) throws Exception{
        SimpleDateFormat df = new SimpleDateFormat("yyyy/MM/dd HH时mm分");
        PurchaseOrder purchaseOrder = (PurchaseOrder)baseManager.getObject(PurchaseOrder.class.getName(),orderId);
        XQuery couponQuery = new XQuery("listCoupon_byorder", request);
        couponQuery.put("couponBatch_priceLimit",purchaseOrder.getTotal().floatValue());
        List<Coupon> couponList = baseManager.listObject(couponQuery);
        for(Coupon coupon:couponList){
            coupon.getCouponBatch().setStartDateString(df.format(coupon.getCouponBatch().getStartDate()));
            coupon.getCouponBatch().setEndDateString(df.format(coupon.getCouponBatch().getEndDate()));
        }

        model.addAttribute("couponList",couponList);

        return couponList;

    }

    @RequestMapping({"/coupon/listCoupon"})
    @ResponseBody
    public List<Object> listCouponBypriceLimit(HttpServletRequest request , Model model) throws Exception{
            XQuery xQuery = new XQuery("listCart_default", request);
            List<Object> list = baseManager.listObject(xQuery);
            Cart cart = (Cart) list.get(0);
            XQuery couponQuery = new XQuery("listCoupon_byorder", request);
            couponQuery.put("couponBatch_priceLimit",cart.getTotalPrice().floatValue());
            List<Object> couponList = baseManager.listObject(couponQuery);
            model.addAttribute("couponList",couponList);
            return couponList;
    }

    //使用优惠卷 使用优惠券可以放到manager中去处理 （使用优惠券只在结算页面可以使用）
    @RequestMapping({"/coupon/use.do"})
    @ResponseBody
    public boolean useCouponByOrder(HttpServletRequest request){
        String orderId = request.getParameter("orderId");
        String couponId = request.getParameter("couponId");
        PurchaseOrder purchaseOrder = (PurchaseOrder)baseManager.getObject(PurchaseOrder.class.getName(),orderId);
        Coupon coupon = (Coupon)baseManager.getObject(Coupon.class.getName(),couponId);

        purchaseOrder.setCoupon(coupon);

        baseManager.saveOrUpdate(PurchaseOrder.class.getName(),purchaseOrder);

        return true;

    }

    /**
     * 发放优惠券
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping({"/coupon/sentEverybodyACoupon"})
    public String sentCoupon(HttpServletRequest request , Model model) throws Exception{
        String time = request.getParameter("time");
        String month = time.substring(0,2);
        String day = time.substring(2,4);
        String hour = time.substring(4,6);
        String min = time.substring(6,8);
        String limitTime1 = "2015-" + month + "-" + day + " " + hour + ":" + min + ":" + "00";
        Date limitTime = DateUtil.parseAllDate(limitTime1);
        Date date = new Date();

        String queryHql = "from "+Consumer.class.getName()+" t where t.createDatetime >= :limitTime and t.createDatetime <= :timeNow order by t.id desc";
        LinkedHashMap<String , Object> queryParamMap = new LinkedHashMap<>();
        queryParamMap.put("limitTime",limitTime);
        queryParamMap.put("timeNow",date);
        List<Consumer> list1 = baseManager.listObject(queryHql,queryParamMap);

        XQuery xQuery2 = new XQuery("listCouponBatch_default",request);
        List<CouponBatch> list2 = baseManager.listObject(xQuery2);
        List list = new ArrayList();
        for (Consumer consumer:list1){
            for(CouponBatch couponBatch:list2){
                Coupon coupon  = new Coupon();
                coupon.setConsumer(consumer);
                coupon.setCouponBatch(couponBatch);
                coupon.setStatus("1");

                baseManager.saveOrUpdate(Coupon.class.getName(), coupon);
                list.add(coupon);
            }
        }

        model.addAttribute("list",list);
        return "/purchaseOrder/couponMessage";

    }

}
