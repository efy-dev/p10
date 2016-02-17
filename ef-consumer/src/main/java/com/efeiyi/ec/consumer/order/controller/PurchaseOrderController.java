package com.efeiyi.ec.consumer.order.controller;

import com.efeiyi.ec.activity.group.model.PurchaseOrderGroup;
import com.efeiyi.ec.balance.model.BalanceRecord;
import com.efeiyi.ec.consumer.organization.model.SmsProvider;
import com.efeiyi.ec.consumer.organization.model.YunPianSmsProvider;
import com.efeiyi.ec.consumer.organization.util.AuthorizationUtil;
import com.efeiyi.ec.organization.model.BigUser;
import com.efeiyi.ec.organization.model.Consumer;
import com.efeiyi.ec.product.model.ProductModel;
import com.efeiyi.ec.purchase.model.*;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import java.io.InputStream;
import java.math.BigDecimal;
import java.net.URL;
import java.net.URLConnection;
import java.util.Date;
import java.util.List;

/**
 * Created by Administrator on 2015/10/12.
 */
@Controller
@RequestMapping({"order"})
public class PurchaseOrderController {

    @Autowired
    private BaseManager baseManager;

    /**
     * PC端订单列表
     *
     * @param request
     * @param model
     * @return
     * @throws Exception
     */

    @RequestMapping({"/myEfeiyi/list.do"})
    public String listPruchaseOrder(HttpServletRequest request, Model model) throws Exception {
        String orderStatus = request.getParameter("status");
        model.addAttribute("status", orderStatus);
        XQuery xQuery;
        if (orderStatus == null || orderStatus.equals("") || orderStatus.equals("0")) {
            xQuery = new XQuery("plistPurchaseOrder_default", request, 10);
        } else {
            xQuery = new XQuery("plistPurchaseOrder_default" + orderStatus + "", request, 10);
        }
        xQuery.addRequestParamToModel(model, request);
        xQuery.setQueryHql((xQuery.getQueryHql()) + " and s.fatherPurchaseOrder.id is null");
        xQuery.updateHql();
        List<Object> list = baseManager.listPageInfo(xQuery).getList();
        String userId = AuthorizationUtil.getMyUser().getId();
        BigUser user = (BigUser) baseManager.getObject(BigUser.class.getName(), userId);
        model.addAttribute("orderList", list);
        model.addAttribute("user", user);
        return "/purchaseOrder/purchaseOrderList";
    }

    /**
     * 查看订单详情1
     *
     * @param model
     * @param orderId
     * @return
     */
    @RequestMapping({"/myEfeiyi/view/{orderId}"})
    public String viewPurchaseOrder(Model model, @PathVariable String orderId) {
        double couponPrice = 0;
        String spendBalance = "0";
        PurchaseOrder purchaseOrder = (PurchaseOrder) baseManager.getObject(PurchaseOrder.class.getName(), orderId);
        model.addAttribute("order", purchaseOrder);
        model.addAttribute("coupon", "0");
        model.addAttribute("balance", "0");
        if (purchaseOrder.getOrderStatus().equals("1") || purchaseOrder.getOrderStatus().equals("17")) {
            PurchaseOrderPayment purchaseOrderPaymentTemp = purchaseOrder.getPurchaseOrderPaymentList().get(0);
            for (PurchaseOrderPaymentDetails purchaseOrderPaymentDetailsTemp : purchaseOrderPaymentTemp.getPurchaseOrderPaymentDetailsList()) {
                if (purchaseOrderPaymentDetailsTemp.getPayWay().equals("4")) {
                    couponPrice += purchaseOrderPaymentDetailsTemp.getCoupon().getCouponBatch().getPrice();
                    model.addAttribute("coupon", "1");
                }
                if (purchaseOrderPaymentDetailsTemp.getPayWay().equals("5")) {
                    spendBalance = purchaseOrderPaymentDetailsTemp.getMoney().toString();
                    model.addAttribute("balance", "1");
                }
            }
        } else {
            for (PurchaseOrderPayment purchaseOrderPaymentTemp : purchaseOrder.getPurchaseOrderPaymentList()) {
                if (purchaseOrderPaymentTemp.getStatus().equals("2")) {
                    for (PurchaseOrderPaymentDetails purchaseOrderPaymentDetailsTemp : purchaseOrderPaymentTemp.getPurchaseOrderPaymentDetailsList()) {
                        if (purchaseOrderPaymentDetailsTemp.getPayWay().equals("4")) {
                            couponPrice += purchaseOrderPaymentDetailsTemp.getCoupon().getCouponBatch().getPrice();
                            model.addAttribute("coupon", "1");
                        }
                        if (purchaseOrderPaymentDetailsTemp.getPayWay().equals("5")) {
                            spendBalance = purchaseOrderPaymentDetailsTemp.getMoney().toString();
                            model.addAttribute("balance", "1");
                        }
                    }
                }
            }
        }
        model.addAttribute("couponPrice", couponPrice);
        model.addAttribute("spendBalance", spendBalance);
        if (purchaseOrder.getPurchaseOrderDeliveryList() != null && !purchaseOrder.getPurchaseOrderDeliveryList().isEmpty()) {
            PurchaseOrderDelivery purchaseOrderDelivery = purchaseOrder.getPurchaseOrderDeliveryList().get(0);
            if (!purchaseOrderDelivery.getStatus().equals("0")) {
                String logisticsInfo = getLogistics(purchaseOrderDelivery.getSerial(), purchaseOrderDelivery.getLogisticsCompany());
                model.addAttribute("dl", logisticsInfo);
                model.addAttribute("pl", purchaseOrderDelivery);
            } else {
                model.addAttribute("pl", null);
            }
        } else {
            model.addAttribute("pl", null);
        }
        return "/purchaseOrder/purchaseOrderView";
    }

    /**
     * 取消订单
     *
     * @param orderId
     * @return
     * @throws Exception
     */
    @RequestMapping({"/cancelOrder/{orderId}"})
    public String cancelPurchaseOrder(HttpServletRequest request, @PathVariable String orderId) throws Exception {
        PurchaseOrder purchaseOrder = (PurchaseOrder) baseManager.getObject(PurchaseOrder.class.getName(), orderId);
        if ("1".equals(purchaseOrder.getOrderStatus())) {
            for (PurchaseOrderProduct purchaseOrderProduct : purchaseOrder.getPurchaseOrderProductList()) {
                if (purchaseOrderProduct.getProductModel().getAmount() != null) {
                    purchaseOrderProduct.getProductModel().setAmount(purchaseOrderProduct.getProductModel().getAmount() + purchaseOrderProduct.getPurchaseAmount());
                } else {
                    ProductModel productModel = (ProductModel) baseManager.getObject(ProductModel.class.getName(), purchaseOrderProduct.getProductModel().getId());
                    productModel.setAmount(productModel.getAmount() + purchaseOrderProduct.getPurchaseAmount());
                }
            }

        }
        purchaseOrder.setOrderStatus(PurchaseOrder.ORDER_STATUS_CONSEL);
        baseManager.saveOrUpdate(PurchaseOrder.class.getName(), purchaseOrder);
        //订单取消回滚余额
        String consumerId = AuthorizationUtil.getMyUser().getId();
        XQuery xQuery = new XQuery("listBalanceRecord_default1", request);
        xQuery.put("consumer_id", consumerId);
        xQuery.put("key", orderId);
        List balanceDetailList = baseManager.listObject(xQuery);

        Consumer consumer = (Consumer) baseManager.getObject(Consumer.class.getName(), consumerId);
        BigDecimal balance = consumer.getBalance();
        if (balanceDetailList.size() > 0) {
            BalanceRecord balanceRecord1 = (BalanceRecord) balanceDetailList.get(0);

            BalanceRecord balanceRecord = new BalanceRecord();
            balanceRecord.setConsumer(consumer);
            balanceRecord.setCurrentBalance(balance);
            balanceRecord.setChangeBalance(balanceRecord1.getChangeBalance());
            balanceRecord.setResultBalance(balance.add(balanceRecord1.getChangeBalance()));
            balanceRecord.setCreateDateTime(new Date());
            balanceRecord.setStatus("2");
            balanceRecord.setType("3");
            balanceRecord.setKey(balanceRecord1.getId());
            baseManager.saveOrUpdate(BalanceRecord.class.getName(), balanceRecord);
            consumer.setBalance(balance.add(balanceRecord1.getChangeBalance()));
            baseManager.saveOrUpdate(Consumer.class.getName(), consumer);

        }
        //订单取消使用的卡券还原
        PurchaseOrderPayment purchaseOrderPaymentTemp = purchaseOrder.getPurchaseOrderPaymentList().get(0);
        for (PurchaseOrderPaymentDetails purchaseOrderPaymentDetailsTemp : purchaseOrderPaymentTemp.getPurchaseOrderPaymentDetailsList()) {
            if (purchaseOrderPaymentDetailsTemp.getPayWay().equals("4")) {
                Coupon coupon = purchaseOrderPaymentDetailsTemp.getCoupon();
                coupon.setStatus("1");
                baseManager.saveOrUpdate(Coupon.class.getName(), coupon);
            }

        }
        return "redirect:/order/myEfeiyi/list.do";
    }

    /**
     * 确定收货
     *
     * @param orderId
     * @return
     */
    @RequestMapping({"/confirmGet/{orderId}"})
    public String confirmGet(@PathVariable String orderId) {
        PurchaseOrder purchaseOrder = (PurchaseOrder) baseManager.getObject(PurchaseOrder.class.getName(), orderId);
        purchaseOrder.setOrderStatus(PurchaseOrder.ORDER_STATUS_UNCOMMENT);
        baseManager.saveOrUpdate(PurchaseOrder.class.getName(), purchaseOrder);
        //确定收货后给商家发送已收货短信
        String phone = purchaseOrder.getBigTenant().getPhone();
        String purchaseOrderSerial = purchaseOrder.getSerial();
        SmsProvider smsProvider = new YunPianSmsProvider();
        smsProvider.post(phone, purchaseOrderSerial, "1125941");
        return "redirect:/order/myEfeiyi/list.do";
    }

    /**
     * 订单删除
     *
     * @param orderId
     * @return
     */
    @RequestMapping({"/deleteOrder/{orderId}"})
    public String deleteOrder(@PathVariable String orderId) {
        PurchaseOrder purchaseOrder = (PurchaseOrder) baseManager.getObject(PurchaseOrder.class.getName(), orderId);
        purchaseOrder.setStatus("0");
        baseManager.saveOrUpdate(PurchaseOrder.class.getName(), purchaseOrder);
        return "redirect:/order/myEfeiyi/list.do?status=17";
    }

    /**
     * 订单列表显示团购详情页
     *
     * @param request
     * @return
     */
    @RequestMapping("/groupBuyView")
    public String getGroupBuy(HttpServletRequest request) throws Exception {
        String purchaseOrderId = request.getParameter("orderId");
        PurchaseOrderGroup purchaseOrderGroup = (PurchaseOrderGroup) baseManager.getObject(PurchaseOrderGroup.class.getName(), purchaseOrderId);
        String memberId = purchaseOrderGroup.getGroupMember().getId();
        String groupId = purchaseOrderGroup.getMyGroup().getId();
        String groupProductId = purchaseOrderGroup.getMyGroup().getGroupProduct().getId();
        return "redirect:Http://a.efeiyi.com/group/shareGroup?memberId=" + memberId + "&groupId=" + groupId + "&groupProductId=" + groupProductId + "&purchaseOrderId=" + purchaseOrderId + "";
    }

    /**
     * 获取物流信息
     *
     * @param serial
     * @param logisticsCompany
     * @return
     */
    private String getLogistics(String serial, String logisticsCompany) {
        String content = "";//物流信息
        try {
            URL url = new URL("http://www.kuaidi100.com/applyurl?key=" + "f8e96a50d49ef863" + "&com=" + logisticsCompany + "&nu=" + serial);
            URLConnection con = url.openConnection();
            con.setAllowUserInteraction(false);
            InputStream urlStream = url.openStream();
            byte b[] = new byte[10000];
            int numRead = urlStream.read(b);
            content = new String(b, 0, numRead);
            while (numRead != -1) {
                numRead = urlStream.read(b);
                if (numRead != -1) {
                    String newContent = new String(b, 0, numRead, "UTF-8");
                    content += newContent;
                }
            }
            urlStream.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return content;
    }


}
