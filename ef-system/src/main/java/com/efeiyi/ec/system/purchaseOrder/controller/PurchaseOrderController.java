package com.efeiyi.ec.system.purchaseOrder.controller;


import com.efeiyi.ec.purchase.model.PurchaseOrder;
import com.efeiyi.ec.purchase.model.PurchaseOrderDelivery;
import com.efeiyi.ec.purchase.model.PurchaseOrderPayment;
import com.efeiyi.ec.system.purchaseOrder.service.PurchaseOrderManager;
import com.efeiyi.ec.system.purchaseOrder.service.SmsCheckManager;
import com.efeiyi.ec.system.util.HTTPParam;
import com.efeiyi.ec.system.util.HTTPSend;
import com.ming800.core.base.controller.BaseController;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.p.PConst;
import com.ming800.core.p.service.AutoSerialManager;
import net.sf.json.JSONObject;
import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * Created by Administrator on 2015/6/18.
 */
@Controller
@RequestMapping("/purchaseOrder")
public class PurchaseOrderController extends BaseController {

    @Autowired
    private PurchaseOrderManager purchaseOrderManager;

    @Autowired
    private BaseManager baseManager;

    @Autowired
    private SmsCheckManager smsCheckManager;

    @Autowired
    private HTTPSend httpSend;

    @Autowired
    private AutoSerialManager autoSerialManager;

    /**
     * ����
     * ,PurchaseOrderDelivery purchaseOrderDelivery,Authentication authentication
     *
     * @param purchaseOrder
     * @return
     */
    @RequestMapping("/updateOrderStatus.do")
    @ResponseBody
    public String updateOrderStatus(PurchaseOrder purchaseOrder, HttpServletRequest request) {

        final String innerPurchaseOrderId = purchaseOrder.getId();
        String logisticsCompany = request.getParameter("logisticsCompany");
        String serial = request.getParameter("serial");
        String id = "";
        purchaseOrder = (PurchaseOrder) baseManager.getObject(PurchaseOrder.class.getName(), purchaseOrder.getId());
        try {
            if (null == purchaseOrder.getFatherPurchaseOrder()) {//如果是父订单发货 所有的子订单都得变成已发货状态
                purchaseOrder.setOrderStatus("7");
                id = purchaseOrderManager.updateOrderStatus(purchaseOrder, serial, logisticsCompany);
                List<PurchaseOrder> subPurchaseOrderList = purchaseOrder.getSubPurchaseOrder();
                if (null != subPurchaseOrderList && subPurchaseOrderList.size() > 0) {
                    PurchaseOrder p1 = null;
                    for (int i = 0; i < subPurchaseOrderList.size(); i++) {
                        p1 = subPurchaseOrderList.get(i);
                        if ("1".equals(p1.getOrderStatus()) || "5".equals(p1.getOrderStatus())) {
                            p1.setOrderStatus("7");
                            purchaseOrderManager.updateOrderStatus(p1);
                        }
                    }
                }

                StringBuffer url = request.getRequestURL();
                final String tempContextUrl = url.delete(url.length() - request.getRequestURI().length(), url.length()).append("/").toString();
                //启动一个定时器，发货七天用户没有点击收货的话，自动改为已收货
                final Timer timer = new Timer();
                timer.schedule(new TimerTask() {
                    @Override
                    public void run() {
                        List<HTTPParam> params = new ArrayList<HTTPParam>();
                        HTTPParam httpParam = new HTTPParam();
                        httpParam.setKey("innerPurchaseOrderId");
                        httpParam.setValue(innerPurchaseOrderId);
                        HTTPParam httpParam1 = new HTTPParam();
                        httpParam1.setKey("purchaseOrderType");
                        httpParam1.setValue("1");//如果是父订单的话类型是1
                        params.add(httpParam);
                        params.add(httpParam1);

                        try {
                            httpSend.sendPost(tempContextUrl + "purchaseOrder/autoReceive.do", params);
                        } catch (IOException e) {
                            e.printStackTrace();
                        }
                        timer.cancel();//停止定时器
                    }
                },7 * 24 * 60 * 60 * 1000);

            } else {
                PurchaseOrder fPurchaseOrder = purchaseOrder.getFatherPurchaseOrder();
                List<PurchaseOrder> subPurchaseOrderList = fPurchaseOrder.getSubPurchaseOrder();
                PurchaseOrder p = null;
                for (int i = 0; i < subPurchaseOrderList.size(); i++) {
                    p = subPurchaseOrderList.get(i);

                    if (p.getId().equals(purchaseOrder.getId())) {//在子订单列表中找到自己
                        if (i == subPurchaseOrderList.size() - 1) {//如果自己是最后一个并且前面的子订单都是已发货的，修改父订单状态，修改自己状态
                            fPurchaseOrder.setOrderStatus("7");
                            purchaseOrderManager.updateOrderStatus(fPurchaseOrder);
                            purchaseOrder.setOrderStatus("7");
                            id = purchaseOrderManager.updateOrderStatus(purchaseOrder, serial, logisticsCompany);
                            break;
                        } else {//如果自己不在列表的最后一个
                            continue;
                        }
                    }

                    if ("1".equals(p.getOrderStatus()) || "5".equals(p.getOrderStatus())) {//如果有未发货的就修改自己 然后跳出循环
//                        if(i == subPurchaseOrderList.size()-1){//如果循环到了最后一个 并且最后一个不是自己并且前面没有未发货的
//                            fPurchaseOrder.setOrderStatus("7");
//                            purchaseOrderManager.updateOrderStatus(fPurchaseOrder);
//                            purchaseOrder.setOrderStatus("7");
//                            id = purchaseOrderManager.updateOrderStatus(purchaseOrder,serial,logisticsCompany);
//                            p.setOrderStatus("7");
//                            purchaseOrderManager.updateOrderStatus(p);
//                        }else{//如果有未发货的并且不是列表的最后一个 修改自己状态 跳出循环
                        purchaseOrder.setOrderStatus("7");
                        id = purchaseOrderManager.updateOrderStatus(purchaseOrder, serial, logisticsCompany);
//                        }
                        break;
                    }
                    if (i == subPurchaseOrderList.size() - 1) {//如果循环到了最后一个 并且最后一个不是自己并且前面没有未发货的
                        fPurchaseOrder.setOrderStatus("7");
                        purchaseOrderManager.updateOrderStatus(fPurchaseOrder);
                        purchaseOrder.setOrderStatus("7");
                        id = purchaseOrderManager.updateOrderStatus(purchaseOrder, serial, logisticsCompany);
                    }

                }

                StringBuffer url = request.getRequestURL();
                final String tempContextUrl = url.delete(url.length() - request.getRequestURI().length(), url.length()).append("/").toString();
                //启动一个定时器，发货七天用户没有点击收货的话，自动改为已收货
                final Timer timer = new Timer();
                timer.schedule(new TimerTask() {
                    @Override
                    public void run() {

                        List<HTTPParam> params = new ArrayList<HTTPParam>();
                        HTTPParam httpParam = new HTTPParam();
                        httpParam.setKey("innerPurchaseOrderId");
                        httpParam.setValue(innerPurchaseOrderId);
                        HTTPParam httpParam1 = new HTTPParam();
                        httpParam1.setKey("purchaseOrderType");
                        httpParam1.setValue("2");//如果是子订单的话类型是2
                        params.add(httpParam);
                        params.add(httpParam1);

                        try {
                            httpSend.sendPost(tempContextUrl + "purchaseOrder/autoReceive.do", params);
                        } catch (IOException e) {
                            e.printStackTrace();
                        }

                        timer.cancel();//停止定时器
                    }
                }, 7 * 24 * 60 * 60 * 1000);


            }


            //发送短信提示发货 短信中提示的订单都是父订单的订单号
            String sysOrder = null;
            if (null == purchaseOrder.getFatherPurchaseOrder()) {
                sysOrder = purchaseOrder.getSerial();
            } else {
                sysOrder = purchaseOrder.getFatherPurchaseOrder().getSerial();
            }
            String logisticsCompanyZHCN = request.getParameter("logisticsCompanyZHCN");
            this.smsCheckManager.send(purchaseOrder.getUser().getUsername(), "#purchaseOrderSerial#=" + sysOrder + "&#LogisticsCompany#=" + logisticsCompanyZHCN + "&#serial#=" + serial, "1035759", PConst.TIANYI);

        } catch (Exception e) {
            e.printStackTrace();
        }

        return id;
    }

    @RequestMapping("/saveReceiver.do")
    @ResponseBody
    public void saveReceiver(HttpServletRequest request) {
        String name = request.getParameter("name");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String purchaseOrderId = request.getParameter("id");

        PurchaseOrder purchaseOrder = (PurchaseOrder) baseManager.getObject(PurchaseOrder.class.getName(), purchaseOrderId);

        if (null == purchaseOrder.getFatherPurchaseOrder()) {
            List<PurchaseOrder> list = purchaseOrder.getSubPurchaseOrder();
            PurchaseOrder subPurchaseOrder = null;
            for (int i = 0; i < list.size(); i++) {
                subPurchaseOrder = list.get(i);
                subPurchaseOrder.setReceiverPhone(phone);
                subPurchaseOrder.setReceiverName(name);
                subPurchaseOrder.setPurchaseOrderAddress(address);
                baseManager.saveOrUpdate(PurchaseOrder.class.getName(), subPurchaseOrder);
            }
            purchaseOrder.setPurchaseOrderAddress(address);
            purchaseOrder.setReceiverName(name);
            purchaseOrder.setReceiverPhone(phone);
            baseManager.saveOrUpdate(PurchaseOrder.class.getName(), purchaseOrder);
        } else {
            purchaseOrder.setPurchaseOrderAddress(address);
            purchaseOrder.setReceiverName(name);
            purchaseOrder.setReceiverPhone(phone);
            baseManager.saveOrUpdate(PurchaseOrder.class.getName(), purchaseOrder);
        }
    }

    @RequestMapping("/refund.do")
    @ResponseBody
    public void refund(HttpServletRequest request) throws Exception {
        String purchaseOrderId = request.getParameter("id");
        String refundWay = request.getParameter("refundWay");
        String refundMoney = request.getParameter("refundMoney");

        PurchaseOrder purchaseOrder = (PurchaseOrder) baseManager.getObject(PurchaseOrder.class.getName(), purchaseOrderId);
        purchaseOrder.setOrderStatus("15");
        baseManager.saveOrUpdate(PurchaseOrder.class.getName(), purchaseOrder);

        PurchaseOrderPayment purchaseOrderPayment = new PurchaseOrderPayment();
        purchaseOrderPayment.setPaymentAmount(new BigDecimal(refundMoney));
        purchaseOrderPayment.setPayWay(refundWay);
        purchaseOrderPayment.setSerial(autoSerialManager.nextSerial("systemAutoSerial"));
        purchaseOrderPayment.setStatus("4");
        purchaseOrderPayment.setPurchaseOrder(purchaseOrder);
        purchaseOrderPayment.setCreateDateTime(new Date());

        baseManager.saveOrUpdate(PurchaseOrderPayment.class.getName(), purchaseOrderPayment);


    }

    @RequestMapping("/autoReceive.do")
    @ResponseBody
    public void autoReceive(HttpServletRequest request) {
        String innerPurchaseOrderId = request.getParameter("innerPurchaseOrderId");
        String type = request.getParameter("purchaseOrderType");
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
        if ("1".equals(type)) {//如果传进来的是父订单
            PurchaseOrder purchaseOrderTemp = (PurchaseOrder) baseManager.getObject(PurchaseOrder.class.getName(), innerPurchaseOrderId);
            String orderStatus = purchaseOrderTemp.getOrderStatus();
            if ("7".equals(orderStatus)) {
                purchaseOrderTemp.setOrderStatus("9");
                baseManager.saveOrUpdate(PurchaseOrder.class.getName(), purchaseOrderTemp);
            }
            List<PurchaseOrder> subPurchaseOrderList = purchaseOrderTemp.getSubPurchaseOrder();
            if (null != subPurchaseOrderList && subPurchaseOrderList.size() > 0) {
                PurchaseOrder p1 = null;
                for (int i = 0; i < subPurchaseOrderList.size(); i++) {
                    p1 = subPurchaseOrderList.get(i);
                    if ("7".equals(p1.getOrderStatus())) {
                        p1.setOrderStatus("9");
                        baseManager.saveOrUpdate(PurchaseOrder.class.getName(), p1);
                    }
                }
            }
            this.smsCheckManager.send(purchaseOrderTemp.getUser().getUsername(), "#deliverydate#=" + sdf.format(new Date()), "1125609", PConst.TIANYI);

        } else if ("2".equals(type)) {//如果传进来的是子订单
            System.out.print("子订单");
            PurchaseOrder purchaseOrderTemp = (PurchaseOrder) baseManager.getObject(PurchaseOrder.class.getName(), innerPurchaseOrderId);
            String orderStatus = purchaseOrderTemp.getOrderStatus();
            if ("7".equals(orderStatus)) {
                purchaseOrderTemp.setOrderStatus("9");
                baseManager.saveOrUpdate(PurchaseOrder.class.getName(), purchaseOrderTemp);
                PurchaseOrder fPurchaseOrder = purchaseOrderTemp.getFatherPurchaseOrder();
                List<PurchaseOrder> subPurchaseOrderList = fPurchaseOrder.getSubPurchaseOrder();
                for (int k = 0; k < subPurchaseOrderList.size(); k++) {
                    PurchaseOrder itPurchaseOrder = subPurchaseOrderList.get(k);
                    if (k == 0 && itPurchaseOrder.getId().equals(purchaseOrderTemp.getId())) {//列表的第一个是自己
                        continue;
                    } else if (k == subPurchaseOrderList.size() - 1 && itPurchaseOrder.getId().equals(purchaseOrderTemp.getId())) {//列表中最后一个是自己
                        fPurchaseOrder.setOrderStatus("9");
                        baseManager.saveOrUpdate(PurchaseOrder.class.getName(), fPurchaseOrder);
                    } else if (itPurchaseOrder.getId().equals(purchaseOrderTemp.getId())) {
                        continue;
                    } else {
                        if ("7".equals(itPurchaseOrder.getOrderStatus()) || "5".equals(itPurchaseOrder.getOrderStatus())) {
                            break;
                        }
                        if ("9".equals(itPurchaseOrder.getOrderStatus()) && k == subPurchaseOrderList.size() - 1) {
                            fPurchaseOrder.setOrderStatus("9");
                            baseManager.saveOrUpdate(PurchaseOrder.class.getName(), fPurchaseOrder);
                        }
                    }
                }

                this.smsCheckManager.send(purchaseOrderTemp.getUser().getUsername(), "#deliverydate#=" + sdf.format(new Date()), "1125609", PConst.TIANYI);
            }
        }
    }


    @RequestMapping("/edingyue.do")
    @ResponseBody
    public void eDingYue(HttpServletRequest request, HttpServletResponse response) {
        String param = request.getParameter("param");
        JSONObject jsonObject = JSONObject.fromObject(param);
        JSONObject jsonObject1 = jsonObject.getJSONObject("lastResult");
        String purchaseOrderSerial = jsonObject1.getString("nu");
        if ("1".equals(jsonObject1.getString("ischeck"))) {
            String hql = "from PurchaseOrderDelivery c where c.serial=:serial ";
            LinkedHashMap<String, Object> hm = new LinkedHashMap<>();
            hm.put("serial", purchaseOrderSerial);
            PurchaseOrderDelivery purchaseOrderDelivery = (PurchaseOrderDelivery) baseManager.listObject(hql, hm).get(0);
            PurchaseOrder purchaseOrder = purchaseOrderDelivery.getPurchaseOrder();
            if ("7".equals(purchaseOrder.getOrderStatus())) {
                purchaseOrder.setOrderStatus("9");
                baseManager.saveOrUpdate(PurchaseOrder.class.getName(), purchaseOrder);

            }
        }
        JSONObject result = new JSONObject();
        result.put("result", "true");
        result.put("returnCode", "200");
        result.put("message", "成功");
        try {
            response.getWriter().print(result);
        } catch (IOException e) {
            e.printStackTrace();
        }

    }


    @RequestMapping("/downloadOrders.do")
    @ResponseBody
    public  ResponseEntity<byte[]> downloadOrders() throws Exception {
        String[] homes ={"订单号","支付方式","订单总价","订单状态","订单原价","收货人地址","收货人姓名","收货人联系方式","下单时间","商品名称","商品编号","下单人","优惠券","优惠券编号","优惠券名称","优惠价格","优惠条件","店铺"};

        String path = this.getClass().getResource("/").getPath().toString() + "com/efeiyi/ec/system/download";

        String fileName = purchaseOrderManager.outExcel(path,homes);

        File downloadFile = new File(path+"//"+fileName);
        HttpHeaders headers = new HttpHeaders();

        headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
        headers.setContentDispositionFormData("attachment", new String(fileName.getBytes("UTF-8"),"iso-8859-1"));
        byte[] bytes = FileUtils.readFileToByteArray(downloadFile);
        return new ResponseEntity<byte[]>(bytes,headers, HttpStatus.OK);

    }

}
