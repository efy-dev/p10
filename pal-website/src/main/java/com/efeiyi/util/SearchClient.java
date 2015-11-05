package com.efeiyi.util;

import com.ming800.core.util.JsonUtil;
import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpMethod;
import org.apache.commons.httpclient.methods.GetMethod;

import java.io.IOException;
import java.net.URLEncoder;
import java.security.spec.ECField;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2015/11/5.
 */
public class SearchClient implements Runnable {

    public static List<String> searchList = new LinkedList<String>();
    public static Map<String,List> resultMap = new LinkedHashMap<String,List>();
    private static HttpClient httpclient = new HttpClient();

    public void run() {
        while (true) {
            if (searchList.isEmpty()) {
                synchronized (searchList) {
                    if (searchList.isEmpty()) {
                        try {
                            searchList.wait();
                        } catch (InterruptedException e) {
                            Thread.currentThread().interrupt();
                            e.printStackTrace();
                        }
                    }
                }
            }

            String query = searchList.remove(0);
            try {
                List result = postQuery2Solr(query);
                resultMap.put(query, result);
                synchronized (query){
                    query.notifyAll();
                }
            }catch (Exception e){
                synchronized (query){
                    query.notifyAll();
                }
                e.printStackTrace();
            }
        }
    }

    private List postQuery2Solr(String query) throws Exception {
//                HttpClient httpclient = new HttpClient();
//        query = URLEncoder.encode(query,"utf-8");
        HttpMethod method = new GetMethod(PalConst.getInstance().solrUrl + query);
        httpclient.executeMethod(method);
        String json = method.getResponseBodyAsString();
        System.out.println(method.getResponseBodyAsString());
        method.releaseConnection();
        Map<?, ?> map = JsonUtil.parseJsonStringToMap(json);
        List responseList = (List)((Map)map.get("response")).get("docs");
        return responseList;
    }

    public static void main (String[]args){

        SearchClient client = new SearchClient();
        try {
            client.postQuery2Solr("%E7%89%9B");
        }catch (Exception e){
            e.printStackTrace();
        }
    }

}
