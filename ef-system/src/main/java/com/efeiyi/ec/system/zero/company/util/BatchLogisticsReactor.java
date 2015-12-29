package com.efeiyi.ec.system.zero.company.util;

import com.efeiyi.ec.purchase.model.PurchaseOrder;
import com.efeiyi.ec.purchase.model.PurchaseOrderDelivery;
import com.efeiyi.ec.purchase.model.PurchaseOrderProduct;
import com.efeiyi.ec.system.purchaseOrder.service.SmsCheckManager;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.p.PConst;
import com.ming800.core.p.service.CommonManager;
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
    private CommonManager commonManager = ((CommonManager) ApplicationContextUtil.getApplicationContext().getBean("commonManager"));
    private SmsCheckManager smsCheckManager = ((SmsCheckManager) ApplicationContextUtil.getApplicationContext().getBean("smsCheckManager"));

    public BatchLogisticsReactor(List<PurchaseOrderProduct> purchaseOrderProductList, ApplicationContext applicationContext) {
        this.applicationContext = applicationContext;
        this.purchaseOrderProductList = purchaseOrderProductList;
    }

    @Override
    public void run() {
        try {
            session = sessionFactory.openSession();
            baseManager = (BaseManager) applicationContext.getBean("baseManagerImpl");
            post2Deppon();
//            post2Deppon2();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            session.close();
            BatchLogisticsReactor.runningFlag.compareAndSet(busy, idle);
        }
    }

//    private void post2Deppon2() {
//        HttpClient httpClient = new DefaultHttpClient();
//        httpClient.getParams().setParameter(CoreConnectionPNames.SO_TIMEOUT, 30000);
//        String url = "http://58.40.17.67/dop/order/ewaybillNewSyncSieveOrder.action";
//        HttpPost httppost = new HttpPost(url);
//        Map jsonMap = new HashMap();
//        jsonMap.put("backSignBill", "0");
//        jsonMap.put("customerCode", "F2015120966058945");
//        jsonMap.put("customerID", "EWBHUAYUNN");
//        jsonMap.put("deliveryType", "3");
//        jsonMap.put("logisticCompanyID", "DEPPON");
//        jsonMap.put("orderSource", "EWBHUAYUNN");
//        jsonMap.put("serviceType", "2");
//        jsonMap.put("payType", "2");
//        jsonMap.put("sieveOrder", "Y");
//        jsonMap.put("transportType", "QC_JZKH");
//        jsonMap.put("vistReceive", "N");
//        jsonMap.put("isOut", "Y");
//        jsonMap.put("smsNotify", true);
//        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
//        for (PurchaseOrderProduct purchaseOrderProduct : purchaseOrderProductList) {
//            try {
//                purchaseOrderProduct = (PurchaseOrderProduct) baseManager.getObject(PurchaseOrderProduct.class.getName(), purchaseOrderProduct.getId());
//                jsonMap.put("cargoName", purchaseOrderProduct.getProductModel().getProduct().getName() + "[" + purchaseOrderProduct.getProductModel().getName() + "]");
//                jsonMap.put("logisticID", "EWHY" + purchaseOrderProduct.getPurchaseOrder().getSerial());
//                jsonMap.put("gmtCommit", dateFormat.format(purchaseOrderProduct.getPurchaseOrder().getCreateDatetime()));
//
//                Map senderMap = new HashMap();
//                senderMap.put("name", commonManager.getCompanyAddresses().get("efeiyi").get("name"));
//                senderMap.put("phone", commonManager.getCompanyAddresses().get("efeiyi").get("phone"));
//                senderMap.put("province", commonManager.getCompanyAddresses().get("efeiyi").get("province"));
//                senderMap.put("city", commonManager.getCompanyAddresses().get("efeiyi").get("city"));
//                senderMap.put("country", commonManager.getCompanyAddresses().get("efeiyi").get("country"));
//                senderMap.put("address", commonManager.getCompanyAddresses().get("efeiyi").get("address"));
//                jsonMap.put("sender", senderMap);
//
//                Map receiverMap = new HashMap();
//                PurchaseOrderDelivery purchaseOrderDelivery = purchaseOrderProduct.getPurchaseOrder().getPurchaseOrderDeliveryList().get(0);
//                receiverMap.put("name", purchaseOrderProduct.getPurchaseOrder().getReceiverName());
//                receiverMap.put("mobile", purchaseOrderProduct.getPurchaseOrder().getReceiverPhone());
//                receiverMap.put("province", purchaseOrderDelivery.getConsumerAddress().getProvince());
//                receiverMap.put("city", purchaseOrderDelivery.getConsumerAddress().getCity());
//                receiverMap.put("county", purchaseOrderDelivery.getConsumerAddress().getDistrict());
//                receiverMap.put("address", purchaseOrderDelivery.getConsumerAddress().getDetails());
//                jsonMap.put("receiver", receiverMap);
//
//                String jsonString = JsonUtil.getJsonString(jsonMap);
//                String apiKey = "deppontest";
//                long timestamp = System.currentTimeMillis();
//                String digest = jsonString + apiKey + timestamp;
//                digest = md5(digest);
//                digest = new String(Base64.encodeBase64(digest.getBytes()));
//                StringEntity stringEntity = new StringEntity("companyCode=EWBHUAYUNN&params=" + jsonString + "&digest=" + digest + "&timestamp=" + timestamp, "utf-8");
//                stringEntity.setContentType("application/x-www-form-urlencoded");
//                httppost.setEntity(stringEntity);
//                byte[] b = new byte[(int) stringEntity.getContentLength()];
//                stringEntity.getContent().read(b);
//                HttpResponse response = null;
//                response = httpClient.execute(httppost);
//
//                HttpEntity entity = response.getEntity();
//                BufferedReader reader = new BufferedReader(new InputStreamReader(
//                        entity.getContent(), "UTF-8"));
//                StringBuilder result = new StringBuilder();
//                String line = "";
//                while ((line = reader.readLine()) != null) {
//                    result.append(line);
//                }
//                Map map = JsonUtil.parseJsonStringToMap(result.toString());
//                if ("1000".equals(map.get("resultCode"))) {
//
//                    purchaseOrderProduct.getPurchaseOrder().setOrderStatus(PurchaseOrder.ORDER_STATUS_POSTED);//efeiyi已发货
//                    purchaseOrderDelivery.setStatus("2");//物流未发货
//                    purchaseOrderDelivery.setSerial((String) map.get("mailNo"));
//                    purchaseOrderDelivery.setLogisticsCompany("DEPPON");
//                    baseManager.saveOrUpdate(purchaseOrderDelivery.getClass().getName(), purchaseOrderDelivery);
//
//                } else {
//                    purchaseOrderProduct.getPurchaseOrder().setOrderStatus(PurchaseOrder.ORDER_STATUS_FAILED);//发货失败
//                }
//                baseManager.saveOrUpdate(purchaseOrderProduct.getPurchaseOrder().getClass().getName(), purchaseOrderProduct.getPurchaseOrder());
//                System.out.println(purchaseOrderDelivery.getSerial());
//            } catch (Exception e) {
//                continue;
//            }
//        }
//    }

    private void post2Deppon() throws Exception {

        HttpClient httpClient = new DefaultHttpClient();
//            httpClient.getParams().setParameter(CoreConnectionPNames.CONNECTION_TIMEOUT, 5000);
        httpClient.getParams().setParameter(CoreConnectionPNames.SO_TIMEOUT, 30000);
//        String url = "http://58.40.17.67/dop/order/ewaybillNewSyncSieveOrder.action";
        String url = "http://api.deppon.com/dop/order/ewaybillNewSyncSieveOrder.action";
        HttpPost httppost = new HttpPost(url);
        Map jsonMap = new HashMap();
        jsonMap.put("backSignBill", "0");//0:无需返单 2:客户签收单传真返回 4: 运单到达联传真返回
        jsonMap.put("customerCode", "F2015120966058945");
        jsonMap.put("customerID", "EWBHUAYUNN");
        jsonMap.put("deliveryType", "3");//0:自提 1:送货（不含上楼）2:机场自提 3:送货上楼
        jsonMap.put("logisticCompanyID", "DEPPON");
        jsonMap.put("orderSource", "EWBHUAYUNN");
        jsonMap.put("serviceType", "2");//2．快递在线下单 3、快递线下订单
        jsonMap.put("payType", "2");//0:发货人付款（现付）1:收货人付款（到付）
//        jsonMap.put("sieveOrder", "Y");//筛单的不用
        jsonMap.put("transportType", "EPEP");//HK_JZKY:精准空运 QC_JZKH:精准卡航 QC_JZQYC:精准汽运（长） QC_JZQYD:精准汽运（短） QC_JZCY:精准城运;PACKAGE：标准快递;RCP :360特惠件;EPEP:电商尊享;

        jsonMap.put("vistReceive", "N");//是:Y 否：N；如为空，系统默认值为否。快递客户如需上门接货请传“Y”；
        jsonMap.put("isOut", "Y");//是否外发 Y：需要 N: 不需要
        jsonMap.put("smsNotify", true);//短信通知 Y：需要 N: 不需要
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
        for (PurchaseOrderProduct purchaseOrderProduct : purchaseOrderProductList) {
            try {
                purchaseOrderProduct = (PurchaseOrderProduct) session.get(PurchaseOrderProduct.class.getName(), purchaseOrderProduct.getId());
                jsonMap.put("cargoName", purchaseOrderProduct.getProductModel().getProduct().getName() + "[" + purchaseOrderProduct.getProductModel().getName() + "]");
                jsonMap.put("logisticID", "EWHY" + purchaseOrderProduct.getPurchaseOrder().getSerial());
                jsonMap.put("gmtCommit", dateFormat.format(purchaseOrderProduct.getPurchaseOrder().getCreateDatetime()));
                jsonMap.put("totalNumber",purchaseOrderProduct.getPurchaseAmount());

                Map senderMap = new HashMap();
                Map<String, String> detailAddressMap = commonManager.getCompanyAddresses().get("efeiyi");
                senderMap.put("name", detailAddressMap.get("name"));
                senderMap.put("phone", detailAddressMap.get("phone"));
                senderMap.put("province", detailAddressMap.get("province"));
                senderMap.put("city", detailAddressMap.get("city"));
                senderMap.put("county", detailAddressMap.get("county"));
                senderMap.put("address", detailAddressMap.get("address"));
                jsonMap.put("sender", senderMap);

                Map receiverMap = new HashMap();
                receiverMap.put("name", purchaseOrderProduct.getPurchaseOrder().getReceiverName());
                receiverMap.put("mobile", purchaseOrderProduct.getPurchaseOrder().getReceiverPhone());
                receiverMap.put("province", purchaseOrderProduct.getPurchaseOrder().getConsumerAddress().getProvince().getName());
                receiverMap.put("city", purchaseOrderProduct.getPurchaseOrder().getConsumerAddress().getCity().getName());
                receiverMap.put("address", purchaseOrderProduct.getPurchaseOrder().getPurchaseOrderAddress());
//                receiverMap.put("county",detailAddressMap.get("county"));
                jsonMap.put("receiver", receiverMap);

                String jsonString = JsonUtil.getJsonString(jsonMap);
//                jsonString = "{\"backSignBill\": \"0\"," +
//                        "\"businessNetworkNo\": \"W011302020515\"," +
//                        "\"cargoName\": \"干果\"," +
//                        "\"customerCode\": \"219402\"," +
//                        "\"customerID\": \"chanelUserA\"," +
//                        "\"deliveryType\": \"0\"," +
//                        "\"insuranceValue\": 3000," +
//                        "\"logisticCompanyID\": \"DEPPON\"," +
//                        "\"orderSource\": \"EWBHUAYUNN\"," +
//                        "\"logisticID\": \"EWHY20101109002852156\"," +
//                        "\"serviceType\": \"1\"," +
//                        "\"payType\": \"0\"," +
//                        "\"gmtCommit\": \" 2012-11-27 18:44:19\"," +
//                        "\"sieveOrder\": \"Y\"," +
//                        "\"sender\": {\"name\": \"郭诗园\"," +
//                        "\"mobile\":\"234321223121\"," +
//                        "\"province\": \"上海\"," +
//                        "\"city\": \"上海\"," +
//                        "\"county\": \"青浦区\"," +
//                        "\"address\": \"明珠路\"}," +
//                        "\"receiver\": {\"name\": \"上帝发誓\"," +
//                        "\"phone\": \"234234324\"," +
//                        "\"province\": \"北京\"," +
//                        "\"city\": \"北京\"," +
//                        "\"county\": \"朝阳区\"," +
//                        "\"address\": \"三里屯街道\"}," +
//                        "\"smsNotify\": true," +
//                        "\"toNetworkNo\": \"W01061502\"," +
//                        "\"totalNumber\": 500," +
//                        "\"totalVolume\": 0.1," +
//                        "\"totalWeight\": 300," +
//                        "\"transportType\": \"QC_JZKH\"," +
//                        "\"vistReceive\": \"Y\"," +
//                        "\"isOut\": \"Y\"}";

//        System.out.println("明文：" + jsonString);
                String apiKey = "301695b57488025761a85027704c22b5";
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
                System.out.println("报文:" + new String(b, "utf-8"));
                HttpResponse response = httpClient.execute(httppost);


                HttpEntity entity = response.getEntity();
                BufferedReader reader = new BufferedReader(new InputStreamReader(
                        entity.getContent(), "UTF-8"));
                StringBuilder result = new StringBuilder();
                String line = "";
                while ((line = reader.readLine()) != null) {
                    result.append(line.trim());
                }
                System.out.println(result);
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
                    // 发短信
                    if("3".equals(purchaseOrderProduct.getPurchaseOrder().getOrderType())){
                        this.smsCheckManager.send(purchaseOrderProduct.getPurchaseOrder().getReceiverPhone(), "#LogisticsCompany#=debangwuliu&#serial#=" + purchaseOrderDelivery.getSerial(), "1184993", PConst.TIANYI);

                    }else{
                        this.smsCheckManager.send(purchaseOrderProduct.getPurchaseOrder().getUser().getUsername(), "#purchaseOrderSerial#=" + purchaseOrderProduct.getPurchaseOrder().getSerial() + "&#LogisticsCompany#=debangwuliu&#serial#=" + purchaseOrderDelivery.getSerial(), "1035759", PConst.TIANYI);
                    }
                    System.out.println(purchaseOrderDelivery.getSerial());
                } else {
//                    purchaseOrderProduct.getPurchaseOrder().setOrderStatus(PurchaseOrder.ORDER_STATUS_FAILED);//发货失败
                    purchaseOrderProduct.getPurchaseOrder().setMessage("DEPPON：" + dateFormat.format(new Date()) + "原因：" + result);
                    //发货失败，自动修改订单号
                    String [] serials = purchaseOrderProduct.getPurchaseOrder().getSerial().split("-");
                    if(serials.length == 1){
                        purchaseOrderProduct.getPurchaseOrder().setSerial(serials[0] + "-1");
                    }else {
                        purchaseOrderProduct.getPurchaseOrder().setSerial(serials[0] + "-" + Integer.parseInt(serials[1]) + 1);
                    }
                }
                session.saveOrUpdate(purchaseOrderProduct.getPurchaseOrder());
                session.flush();
            } catch (Exception e) {
                e.printStackTrace();
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


