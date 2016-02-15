package com.efeiyi.ec.website.order.controller;

import com.efeiyi.ec.website.base.authentication.ContextUtils;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONException;
import com.alibaba.fastjson.JSONObject;
import com.efeiyi.ec.website.order.model.DepponProduct;
import com.efeiyi.ec.website.order.model.FreightConstant;
import org.apache.commons.codec.binary.Base64;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.DefaultHttpClient;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.io.*;
import java.math.BigDecimal;
import java.net.URL;
import java.net.URLEncoder;
import java.nio.charset.Charset;
import java.security.MessageDigest;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.Map.Entry;

/**
 * Created by Administrator on 2015/12/15.
 */
@Controller
@RequestMapping("/freight")
public class SearchFreightFromDepponController {

    @RequestMapping(value = "/searchPrice.do")//, method = RequestMethod.POST)
    @ResponseBody
    public String submit2Deppon(HttpServletRequest request) throws Exception {

        String productCode = ((DepponProduct) ContextUtils.getBean("depponProduct")).getProductCode();
        String cost = "";
        JSONObject jsonObj = (JSONObject) JSONObject.parse(request.getParameter("json").toString());
        String jsonString = jsonObj.toJSONString();
        String weight = request.getParameter("weight");
        if (jsonString == null && "".equals(jsonString)) {
            return "the args is necessary";
        }
        String apiKey = "301695b57488025761a85027704c22b5";
        long timestamp = System.currentTimeMillis();
        String digest = jsonString + apiKey + timestamp;
        digest = md5(digest);
        digest = new String(Base64.encodeBase64(digest.getBytes()));

        HttpClient httpClient = new DefaultHttpClient();
        String url = "http://api.deppon.com/dop/order/queryPrice.action";
        HttpPost httppost = new HttpPost(url);
        StringEntity stringEntity = new StringEntity("companyCode=EWBHUAYUNN&params=" + jsonString + "&digest=" + digest + "&timestamp=" + timestamp, "utf-8");
        stringEntity.setContentType("application/x-www-form-urlencoded");
        httppost.setEntity(stringEntity);
        byte[] b = new byte[(int) stringEntity.getContentLength()];
        stringEntity.getContent().read(b);

        HttpResponse response = httpClient.execute(httppost);
        HttpEntity entity = response.getEntity();
        BufferedReader reader = new BufferedReader(new InputStreamReader(
                entity.getContent(), "UTF-8"));

        String line;
        StringBuilder stringBuilder = new StringBuilder();
        while ((line = reader.readLine()) != null) {
            stringBuilder.append(line);
        }
        JSONObject jasonObject = (JSONObject) JSONObject.parse(stringBuilder.toString());
        JSONObject jasonObject2 = jasonObject.getJSONObject("responseParam");
        JSONArray jsonArray = jasonObject2.getJSONArray("priceInfo");

        if (!jsonArray.isEmpty()) {
            for (int i = 0; i < jsonArray.size(); i++) {
                if (productCode.equals(jsonArray.getJSONObject(i).getString("productCode"))) {
                    cost = calculateFreight(jsonArray.getJSONObject(i), weight);
                    break;

                }

            }
        }

        return cost;


    }


    @RequestMapping(value = "/getAddress.do")
    @ResponseBody
    public Map getAddressFromIp(HttpServletRequest request) throws Exception {
        Map map = new LinkedHashMap<String, String>();
        String URI = FreightConstant.SERVER_LOCATION_API_URI;
        String ak = FreightConstant.SERVER_AK;
        JSONObject json = readJsonFromUrl(URI + "?ak=" + ak + "&coor=bd09ll");
        map.put("province", ((JSONObject) ((JSONObject) json.get("content")).get("address_detail")).get("province"));
        map.put("city", ((JSONObject) ((JSONObject) json.get("content")).get("address_detail")).get("city"));
        return map;
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

    private String calculateFreight(JSONObject jsonArray, String weight) throws Exception {
        String freight = "";
        Double wt = new Double(weight);
        BigDecimal groundPrice = new BigDecimal(jsonArray.getString("groundPrice"));
        Double upperGround = jsonArray.getDouble("upperGround");
        Double lowerGround = jsonArray.getDouble("lowerGround");

        BigDecimal rateOfStage1 = new BigDecimal(jsonArray.getInteger("rateOfStage1"));
        Double lowerOfStage1 = jsonArray.getDouble("lowerOfStage1");
        Double upperOfStage1 = jsonArray.getDouble("upperOfStage1");

        BigDecimal rateOfStage2 = new BigDecimal(jsonArray.getInteger("rateOfStage2"));
        Double lowerOfStage2 = jsonArray.getDouble("lowerOfStage2");
        Double upperOfStage2 = jsonArray.getDouble("upperOfStage2");

        if (lowerGround <= wt && wt <= upperGround) {
            freight = groundPrice.toString();
        } else if (lowerOfStage1 < wt && wt <= upperOfStage1) {
            freight = groundPrice.add(rateOfStage1.multiply(new BigDecimal(wt - lowerOfStage1))).toString();
        } else if (lowerOfStage2 < wt && wt <= upperOfStage2) {
            freight = groundPrice.add(
                    rateOfStage1.multiply(new BigDecimal(upperOfStage1 - lowerOfStage1))
                            .add(rateOfStage2.multiply(new BigDecimal(wt - lowerOfStage2)))).toString();
        }

        return freight;
    }


    private static String readAll(Reader rd) throws IOException {
        StringBuilder sb = new StringBuilder();
        int cp;
        while ((cp = rd.read()) != -1) {
            sb.append((char) cp);
        }
        return sb.toString();
    }

    public static JSONObject readJsonFromUrl(String url) throws IOException, JSONException {
        InputStream is = new URL(url).openStream();
        try {
            BufferedReader rd = new BufferedReader(new InputStreamReader(is, Charset.forName("UTF-8")));
            String jsonText = readAll(rd);
            JSONObject json = JSONObject.parseObject(jsonText);
            return json;
        } finally {
            is.close();
        }
    }


    private static String getSignature() throws Exception {
        Map paramsMap = new LinkedHashMap<String, String>();
        paramsMap.put("ak", FreightConstant.SERVER_AK);
        String paramsStr = toQueryString(paramsMap);
        String wholeStr = new String("/location/ip/?" + paramsStr + FreightConstant.SERVER_AK);
        String tempStr = URLEncoder.encode(wholeStr, "UTF-8");

        // 调用下面的MD5方法得到最后的sn签名7de5a22212ffaa9e326444c75a58f9a0
        System.out.println(MD5(tempStr));
        return MD5(tempStr);
    }

    // 来自stackoverflow的MD5计算方法，调用了MessageDigest库函数，并把byte数组结果转换成16进制
    private static String MD5(String md5) {
        try {
            MessageDigest md = MessageDigest
                    .getInstance("MD5");
            byte[] array = md.digest(md5.getBytes());
            StringBuffer sb = new StringBuffer();
            for (int i = 0; i < array.length; ++i) {
                sb.append(Integer.toHexString((array[i] & 0xFF) | 0x100)
                        .substring(1, 3));
            }
            return sb.toString();
        } catch (java.security.NoSuchAlgorithmException e) {
        }
        return null;
    }

    // 对Map内所有value作utf8编码，拼接返回结果
    private static String toQueryString(Map<?, ?> data)
            throws UnsupportedEncodingException {
        StringBuffer queryString = new StringBuffer();
        for (Entry<?, ?> pair : data.entrySet()) {
            queryString.append(pair.getKey() + "=");
            queryString.append(URLEncoder.encode((String) pair.getValue(),
                    "UTF-8") + "&");
        }
        if (queryString.length() > 0) {
            queryString.deleteCharAt(queryString.length() - 1);
        }
        return queryString.toString();
    }
}
