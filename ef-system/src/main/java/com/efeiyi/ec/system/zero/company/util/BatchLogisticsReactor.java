package com.efeiyi.ec.system.zero.company.util;

import com.efeiyi.ec.purchase.model.PurchaseOrder;
import com.efeiyi.ec.purchase.model.PurchaseOrderDelivery;
import com.efeiyi.ec.purchase.model.PurchaseOrderGift;
import com.efeiyi.ec.purchase.model.PurchaseOrderProduct;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.util.ApplicationContextUtil;
import com.ming800.core.util.JsonUtil;
import org.apache.commons.codec.binary.Base64;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.params.CoreConnectionPNames;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.context.ApplicationContext;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.security.MessageDigest;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.atomic.AtomicInteger;

/**
 * Created by Administrator on 2015/12/14.
 */
public class BatchLogisticsReactor implements Runnable {
    private SessionFactory sessionFactory = ((SessionFactory) ApplicationContextUtil.getApplicationContext().getBean("scheduleSessionFactory"));
    private List<PurchaseOrderProduct> purchaseOrderProductList;
    private Session session;
    public static AtomicInteger runningFlag = new AtomicInteger(0);
    public static final int idle = 0;
    public static final int busy = 1;
    private ApplicationContext applicationContext;
    private BaseManager baseManager;

    public BatchLogisticsReactor(List<PurchaseOrderProduct> purchaseOrderProductList,ApplicationContext applicationContext) {
        this.applicationContext = applicationContext;
        this.purchaseOrderProductList = purchaseOrderProductList;
    }

    @Override
    public void run() {
        try {
            session = sessionFactory.openSession();
            baseManager = (BaseManager)applicationContext.getBean("baseManagerImpl");
            post2Deppon();
//            post2Deppon2();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            session.close();
            BatchLogisticsReactor.runningFlag.compareAndSet(idle,busy);
        }
    }

    private void post2Deppon2() {
        HttpClient httpClient = new DefaultHttpClient();
        httpClient.getParams().setParameter(CoreConnectionPNames.SO_TIMEOUT, 30000);
        String url = "http://58.40.17.67/dop/order/ewaybillNewSyncSieveOrder.action";
        HttpPost httppost = new HttpPost(url);
        Map jsonMap = new HashMap();
        jsonMap.put("backSignBill", "0");
        jsonMap.put("customerCode", "F2015120966058945");
        jsonMap.put("customerID", "EWBHUAYUNN");
        jsonMap.put("deliveryType", "3");
        jsonMap.put("logisticCompanyID", "DEPPON");
        jsonMap.put("orderSource", "EWBHUAYUNN");
        jsonMap.put("serviceType", "2");
        jsonMap.put("payType", "2");
        jsonMap.put("sieveOrder", "Y");
        jsonMap.put("transportType", "QC_JZKH");
        jsonMap.put("vistReceive", "N");
        jsonMap.put("isOut", "Y");
        jsonMap.put("smsNotify", true);
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
        for (PurchaseOrderProduct purchaseOrderProduct : purchaseOrderProductList) {
            try {
                purchaseOrderProduct = (PurchaseOrderProduct) baseManager.getObject(PurchaseOrderProduct.class.getName(), purchaseOrderProduct.getId());
                jsonMap.put("cargoName", purchaseOrderProduct.getProductModel().getProduct().getName() + "[" + purchaseOrderProduct.getProductModel().getName() + "]");
                jsonMap.put("logisticID", "EWHY" + purchaseOrderProduct.getPurchaseOrder().getSerial());
                jsonMap.put("gmtCommit", dateFormat.format(purchaseOrderProduct.getPurchaseOrder().getCreateDatetime()));

                Map senderMap = new HashMap();
                senderMap.put("name", "e飞蚁-中国非遗电商平台");
                senderMap.put("phone", "4008768766");
                senderMap.put("province", "北京");
                senderMap.put("city", "北京");
                senderMap.put("county", "朝阳区");
                senderMap.put("address", "北京市朝阳区酒仙桥东路9号电子城A2西侧6层");
                jsonMap.put("sender", senderMap);

                Map receiverMap = new HashMap();
                PurchaseOrderDelivery purchaseOrderDelivery = purchaseOrderProduct.getPurchaseOrder().getPurchaseOrderDeliveryList().get(0);
                receiverMap.put("name", purchaseOrderProduct.getPurchaseOrder().getReceiverName());
                receiverMap.put("mobile", purchaseOrderProduct.getPurchaseOrder().getReceiverPhone());
                receiverMap.put("province", purchaseOrderDelivery.getConsumerAddress().getProvince());
                receiverMap.put("city", purchaseOrderDelivery.getConsumerAddress().getCity());
                receiverMap.put("county", purchaseOrderDelivery.getConsumerAddress().getDistrict());
                receiverMap.put("address", purchaseOrderDelivery.getConsumerAddress().getDetails());
                jsonMap.put("receiver", receiverMap);

                String jsonString = JsonUtil.getJsonString(jsonMap);
                String apiKey = "deppontest";
                long timestamp = System.currentTimeMillis();
                String digest = jsonString + apiKey + timestamp;
                digest = md5(digest);
                digest = new String(Base64.encodeBase64(digest.getBytes()));
                StringEntity stringEntity = new StringEntity("companyCode=EWBHUAYUNN&params=" + jsonString + "&digest=" + digest + "&timestamp=" + timestamp, "utf-8");
                stringEntity.setContentType("application/x-www-form-urlencoded");
                httppost.setEntity(stringEntity);
                byte[] b = new byte[(int) stringEntity.getContentLength()];
                stringEntity.getContent().read(b);
                HttpResponse response = null;
                response = httpClient.execute(httppost);

                HttpEntity entity = response.getEntity();
                BufferedReader reader = new BufferedReader(new InputStreamReader(
                        entity.getContent(), "UTF-8"));
                StringBuilder result = new StringBuilder();
                String line = "";
                while ((line = reader.readLine()) != null) {
                    result.append(line);
                }
                Map map = JsonUtil.parseJsonStringToMap(result.toString());
                if ("1000".equals(map.get("resultCode"))) {

                    purchaseOrderProduct.getPurchaseOrder().setOrderStatus(PurchaseOrder.ORDER_STATUS_POSTED);//efeiyi已发货
                    purchaseOrderDelivery.setStatus("2");//物流未发货
                    purchaseOrderDelivery.setSerial((String) map.get("mailNo"));
                    purchaseOrderDelivery.setLogisticsCompany("DEPPON");

                    baseManager.saveOrUpdate(purchaseOrderDelivery.getClass().getName(),purchaseOrderDelivery);
                    baseManager.saveOrUpdate(purchaseOrderProduct.getPurchaseOrder().getClass().getName(),purchaseOrderProduct.getPurchaseOrder());
                }
                System.out.println(purchaseOrderDelivery.getSerial());
            } catch (Exception e) {
                continue;
            }
        }
    }

    private void post2Deppon() throws Exception {

        HttpClient httpClient = new DefaultHttpClient();
//            httpClient.getParams().setParameter(CoreConnectionPNames.CONNECTION_TIMEOUT, 5000);
        httpClient.getParams().setParameter(CoreConnectionPNames.SO_TIMEOUT, 30000);
        String url = "http://58.40.17.67/dop/order/ewaybillNewSyncSieveOrder.action";
        HttpPost httppost = new HttpPost(url);
        Map jsonMap = new HashMap();
        jsonMap.put("backSignBill", "0");
        jsonMap.put("customerCode", "F2015120966058945");
        jsonMap.put("customerID", "EWBHUAYUNN");
        jsonMap.put("deliveryType", "3");
        jsonMap.put("logisticCompanyID", "DEPPON");
        jsonMap.put("orderSource", "EWBHUAYUNN");
        jsonMap.put("serviceType", "2");
        jsonMap.put("payType", "2");
        jsonMap.put("sieveOrder", "Y");
        jsonMap.put("transportType", "QC_JZKH");
        jsonMap.put("vistReceive", "N");
        jsonMap.put("isOut", "Y");
        jsonMap.put("smsNotify", true);
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
        for (PurchaseOrderProduct purchaseOrderProduct : purchaseOrderProductList) {
            try {
                purchaseOrderProduct = (PurchaseOrderProduct) session.get(PurchaseOrderProduct.class.getName(), purchaseOrderProduct.getId());
                jsonMap.put("cargoName", purchaseOrderProduct.getProductModel().getProduct().getName() + "[" + purchaseOrderProduct.getProductModel().getName() + "]");
                jsonMap.put("logisticID", "EWHY" + purchaseOrderProduct.getPurchaseOrder().getSerial());
                jsonMap.put("gmtCommit", dateFormat.format(purchaseOrderProduct.getPurchaseOrder().getCreateDatetime()));

                Map senderMap = new HashMap();
                senderMap.put("name", "e飞蚁-中国非遗电商平台");
                senderMap.put("phone", "4008768766");
                senderMap.put("province", "北京");
                senderMap.put("city", "北京");
                senderMap.put("county", "朝阳区");
                senderMap.put("address", "北京市朝阳区酒仙桥东路9号电子城A2西侧6层");
                jsonMap.put("sender", senderMap);

                Map receiverMap = new HashMap();
                receiverMap.put("name", purchaseOrderProduct.getPurchaseOrder().getReceiverName());
                receiverMap.put("mobile", purchaseOrderProduct.getPurchaseOrder().getReceiverPhone());
                receiverMap.put("province", purchaseOrderProduct.getPurchaseOrder().getConsumerAddress().getProvince().getName());
                receiverMap.put("city", purchaseOrderProduct.getPurchaseOrder().getConsumerAddress().getCity().getName());
                receiverMap.put("address", purchaseOrderProduct.getPurchaseOrder().getPurchaseOrderAddress());
                jsonMap.put("receiver", receiverMap);

                String jsonString = JsonUtil.getJsonString(jsonMap);
//        System.out.println("明文：" + jsonString);
                String apiKey = "deppontest";
                long timestamp = System.currentTimeMillis();
                String digest = jsonString + apiKey + timestamp;
//        System.out.println("param+apikey+timestamp:  " + digest);
                digest = md5(digest);
//        System.out.println("MD5(param+apikey+timestamp):  " + digest);
                digest = new String(Base64.encodeBase64(digest.getBytes()));
//        System.out.println("base64(MD5(param+apikey+timestamp)):  " + digest);
                StringEntity stringEntity = new StringEntity("companyCode=EWBHUAYUNN&params=" + jsonString + "&digest=" + digest + "&timestamp=" + timestamp, "utf-8");
                stringEntity.setContentType("application/x-www-form-urlencoded");
                httppost.setEntity(stringEntity);
//        System.out.println("url:  " + url);
                byte[] b = new byte[(int) stringEntity.getContentLength()];
                stringEntity.getContent().read(b);
//        System.out.println("报文:" + new String(b, "utf-8"));
                HttpResponse response = null;
                response = httpClient.execute(httppost);


                HttpEntity entity = response.getEntity();
                BufferedReader reader = new BufferedReader(new InputStreamReader(
                        entity.getContent(), "UTF-8"));
                StringBuilder result = new StringBuilder();
                String line = "";
                while ((line = reader.readLine()) != null) {
                    result.append(line);
                }
                Map map = JsonUtil.parseJsonStringToMap(result.toString());

                //返回成功的
                if ("1000".equals(map.get("resultCode"))) {
                    purchaseOrderProduct.getPurchaseOrder().setOrderStatus(PurchaseOrder.ORDER_STATUS_POSTED);//efeiyi已发货
                    PurchaseOrderDelivery purchaseOrderDelivery = new PurchaseOrderDelivery();
                    purchaseOrderDelivery.setPurchaseOrder(purchaseOrderProduct.getPurchaseOrder());
                    purchaseOrderDelivery.setConsumerAddress(purchaseOrderProduct.getPurchaseOrder().getConsumerAddress());
                    purchaseOrderDelivery.setCreateDateTime(new Date(timestamp));
                    purchaseOrderDelivery.setSerial((String) map.get("mailNo"));//运单号
                    purchaseOrderDelivery.setStatus("1");//物流已发货
//            purchaseOrderDelivery.setSerial("1234");
                    purchaseOrderDelivery.setLogisticsCompany("DEPPON");
                    session.saveOrUpdate(purchaseOrderDelivery);
                    session.saveOrUpdate(purchaseOrderProduct.getPurchaseOrder());
                    session.flush();
                    System.out.println(purchaseOrderDelivery.getSerial());
                }
            } catch (Exception e) {
                continue;
            }
        }
    }

    private static String md5(String s) throws Exception {
        MessageDigest md5 = MessageDigest.getInstance("MD5");
        byte[] md5Bytes = md5.digest(s.getBytes("utf-8"));
        StringBuffer hexValue = new StringBuffer();
        for (int i = 0; i < md5Bytes.length; i++) {
            int val = ((int) md5Bytes[i]) & 0xff;
            if (val < 16) {
                hexValue.append("0");
            }
            hexValue.append(Integer.toHexString(val));
        }
        return hexValue.toString();
    }
}


