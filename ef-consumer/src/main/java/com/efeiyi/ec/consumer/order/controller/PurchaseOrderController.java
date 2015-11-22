package com.efeiyi.ec.consumer.order.controller;

import com.efeiyi.ec.consumer.organization.util.AuthorizationUtil;
import com.efeiyi.ec.organization.model.BigUser;
import com.efeiyi.ec.product.model.ProductModel;
import com.efeiyi.ec.purchase.model.*;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.persistence.PreUpdate;
import javax.persistence.Transient;
import javax.servlet.http.HttpServletRequest;
import javax.transaction.Transactional;
import java.io.InputStream;
import java.net.URL;
import java.net.URLConnection;
import java.util.ArrayList;
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
     * @param request
     * @param model
     * @return
     * @throws Exception
     */

    @RequestMapping({"/myEfeiyi/list.do"})
    public String listPruchaseOrder(HttpServletRequest request, Model model) throws Exception {
        String orderStatus = request.getParameter("status");
        model.addAttribute("status", orderStatus);
        XQuery xQuery = null;
        int c = 0;
        if (orderStatus == null || orderStatus == "" || orderStatus =="0") {
            xQuery = new XQuery("plistPurchaseOrder_default", request, 10);
        } else {
            c = Integer.parseInt(orderStatus);
            switch (c) {
                case 1:
                    xQuery = new XQuery("plistPurchaseOrder_default1", request, 10);
                    break;
                case 5:
                    xQuery = new XQuery("plistPurchaseOrder_default5", request, 10);
                    break;
                case 9:
                    xQuery = new XQuery("plistPurchaseOrder_default9", request, 10);
                    break;
                case 13:
                    xQuery = new XQuery("plistPurchaseOrder_default13", request, 10);
                    break;
                case 17:
                    xQuery = new XQuery("plistPurchaseOrder_default17", request, 10);
                    break;
                default:
                    xQuery = new XQuery("plistPurchaseOrder_default", request, 10);
            }

        }
        xQuery.addRequestParamToModel(model, request);

        xQuery.setQueryHql((xQuery.getQueryHql())+ " and s.fatherPurchaseOrder.id is null");
        xQuery.updateHql();

        List<Object> list = baseManager.listPageInfo(xQuery).getList();
        String userId = AuthorizationUtil.getMyUser().getId();
        BigUser user = (BigUser) baseManager.getObject(BigUser.class.getName(), userId);
        model.addAttribute("orderList", list);
        model.addAttribute("user", user);
        return "/purchaseOrder/purchaseOrderList";
    }


    @RequestMapping({"/createGiftImage/{orderId}"})
    public String createGiftImage(@PathVariable String orderId){

        PurchaseOrderGift purchaseOrderGift = (PurchaseOrderGift)baseManager.getObject(PurchaseOrderGift.class.getName(),orderId);
        return null;
    }

    /**
     * 手机端个人中心(订单查询)
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping({"/myMobileEfeiyi/list.do"})
    public String listPruchaseOrderForMobile(HttpServletRequest request, Model model) throws Exception {
        XQuery xQuery = new XQuery("plistPurchaseOrder_default", request);
        xQuery.addRequestParamToModel(model, request);
        List<Object> list = baseManager.listPageInfo(xQuery).getList();
        model.addAttribute("orderList", list);
        return "purchaseOrder/purchaseOrder";
    }

    /**
     * 查看订单详情
     * @param model
     * @param orderId
     * @return
     */
    @RequestMapping({"/myEfeiyi/view/{orderId}"})
    public String viewPurchaseOrder(Model model, @PathVariable String orderId) {
        List dl = new ArrayList();
        double couponPrice = 0;
        PurchaseOrder purchaseOrder = (PurchaseOrder) baseManager.getObject(PurchaseOrder.class.getName(), orderId);
        model.addAttribute("order", purchaseOrder);
        model.addAttribute("coupon","0");
        if(purchaseOrder.getOrderStatus().equals("1")||purchaseOrder.getOrderStatus().equals("17")){
            PurchaseOrderPayment purchaseOrderPaymentTemp=purchaseOrder.getPurchaseOrderPaymentList().get(0);
            for(PurchaseOrderPaymentDetails purchaseOrderPaymentDetailsTemp:purchaseOrderPaymentTemp.getPurchaseOrderPaymentDetailsList()){
                if(purchaseOrderPaymentDetailsTemp.getPayWay().equals("4")){
                    couponPrice +=purchaseOrderPaymentDetailsTemp.getCoupon().getCouponBatch().getPrice();
                    model.addAttribute("coupon","1");
                }
            }
        }else {
            for(PurchaseOrderPayment purchaseOrderPaymentTemp:purchaseOrder.getPurchaseOrderPaymentList()){
                if(purchaseOrderPaymentTemp.getStatus().equals("2")){
                    for(PurchaseOrderPaymentDetails purchaseOrderPaymentDetailsTemp:purchaseOrderPaymentTemp.getPurchaseOrderPaymentDetailsList()){
                        if(purchaseOrderPaymentDetailsTemp.getPayWay().equals("4")){
                            couponPrice +=purchaseOrderPaymentDetailsTemp.getCoupon().getCouponBatch().getPrice();
                            model.addAttribute("coupon","1");
                        }
                    }

                }

            }
        }
        model.addAttribute("couponPrice",couponPrice);
        String lc = "";
        String serial = "";
        String content = "";
        if (purchaseOrder.getSubPurchaseOrder()==null || purchaseOrder.getSubPurchaseOrder().size() == 0) {
            List pl = purchaseOrder.getPurchaseOrderDeliveryList();
            if (pl.size() > 0) {

                serial = purchaseOrder.getPurchaseOrderDeliveryList().get(0).getSerial();
                lc = purchaseOrder.getPurchaseOrderDeliveryList().get(0).getLogisticsCompany();

                try {
                    URL url = new URL("http://www.kuaidi100.com/applyurl?key=" + "f8e96a50d49ef863" + "&com=" + lc + "&nu=" + serial);
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
            }

            dl.add(content);
            model.addAttribute("dl", dl);
            model.addAttribute("pl", pl);
        } else {
            List pl = new ArrayList();
            for (PurchaseOrder purchaseOrderTemp : purchaseOrder.getSubPurchaseOrder()){
                if (purchaseOrderTemp.getPurchaseOrderDeliveryList()!=null && purchaseOrderTemp.getPurchaseOrderDeliveryList().size()>0){
                    for (PurchaseOrderDelivery purchaseOrderDeliveryTemp : purchaseOrderTemp.getPurchaseOrderDeliveryList()){
                        pl.add(purchaseOrderDeliveryTemp);
                    }
                }
            }



            for (int i = 0; i < pl.size(); i++) {
                serial = ((PurchaseOrderDelivery)(pl.get(i))).getSerial();
                lc = ((PurchaseOrderDelivery)(pl.get(i))).getLogisticsCompany();
                try {
                    URL url = new URL("http://www.kuaidi100.com/applyurl?key=" + "f8e96a50d49ef863" + "&com=" + lc + "&nu=" + serial);
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
                    dl.add(content);
                    urlStream.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }

            }

            model.addAttribute("pl", pl);
            model.addAttribute("dl", dl);
        }

//        if (purchaseOrder.getOrderType()!=null && purchaseOrder.getOrderType().equals("3")){
//            PurchaseOrderGift purchaseOrderGift = (PurchaseOrderGift)baseManager.getObject(PurchaseOrderGift.class.getName(),purchaseOrder.getId());
//            model.addAttribute("order",purchaseOrderGift);
//            return "/purchaseOrder/purchaseOrderGiftView";
//        }

        return "/purchaseOrder/purchaseOrderView";
    }

    /**
     * 取消订单
     * @param orderId
     * @return
     * @throws Exception
     */
    @RequestMapping({"/cancelOrder/{orderId}"})
    public String cancelPurchaseOrder(@PathVariable String orderId) throws Exception {
        PurchaseOrder purchaseOrder = (PurchaseOrder) baseManager.getObject(PurchaseOrder.class.getName(), orderId);
        for (PurchaseOrderProduct purchaseOrderProduct : purchaseOrder.getPurchaseOrderProductList()) {
            if (purchaseOrderProduct.getProductModel().getAmount() != null) {
                purchaseOrderProduct.getProductModel().setAmount(purchaseOrderProduct.getProductModel().getAmount() + purchaseOrderProduct.getPurchaseAmount());
            } else {
                ProductModel productModel = (ProductModel) baseManager.getObject(ProductModel.class.getName(), purchaseOrderProduct.getProductModel().getId());
                productModel.setAmount(productModel.getAmount() + purchaseOrderProduct.getPurchaseAmount());
            }
        }
        purchaseOrder.setOrderStatus(PurchaseOrder.ORDER_STATUS_CONSEL);
        baseManager.saveOrUpdate(PurchaseOrder.class.getName(), purchaseOrder);
        return "redirect:/order/myEfeiyi/list.do";
    }

    /**
     * 确定收货
     * @param orderId
     * @return
     */
    @RequestMapping({"/confirmGet/{orderId}"})
    public String confirmGet(@PathVariable String orderId) {
        PurchaseOrder purchaseOrder = (PurchaseOrder) baseManager.getObject(PurchaseOrder.class.getName(), orderId);
        purchaseOrder.setOrderStatus(PurchaseOrder.ORDER_STATUS_UNCOMMENT);
        baseManager.saveOrUpdate(PurchaseOrder.class.getName(), purchaseOrder);
        return "redirect:/order/myEfeiyi/list.do";
    }

    /**
     * 订单删除
     * @param orderId
     * @return
     */
    @RequestMapping({"/deleteOrder/{orderId}"})
    public String deleteOrder(@PathVariable String orderId) {
        PurchaseOrder purchaseOrder = (PurchaseOrder) baseManager.getObject(PurchaseOrder.class.getName(), orderId);
        for (PurchaseOrderProduct purchaseOrderProduct : purchaseOrder.getPurchaseOrderProductList()) {
            if (purchaseOrderProduct.getProductModel().getAmount() != null) {
                purchaseOrderProduct.getProductModel().setAmount(purchaseOrderProduct.getProductModel().getAmount() + purchaseOrderProduct.getPurchaseAmount());
            } else {
                ProductModel productModel = (ProductModel) baseManager.getObject(ProductModel.class.getName(), purchaseOrderProduct.getProductModel().getId());
                productModel.setAmount(productModel.getAmount() + purchaseOrderProduct.getPurchaseAmount());
            }
        }
        baseManager.saveOrUpdate(PurchaseOrder.class.getName(), purchaseOrder);
        baseManager.remove(PurchaseOrder.class.getName(), orderId);
        return "redirect:/order/myEfeiyi/list.do";
    }


}
