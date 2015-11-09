package com.efeiyi.util;

import com.ming800.core.util.JsonUtil;
import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpMethod;
import org.apache.commons.httpclient.methods.GetMethod;

import java.net.URLEncoder;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2015/11/5.
 */
public class SearchClient implements Runnable {

    public static List<String> searchList = new LinkedList<String>();
    public static Map resultMap = new LinkedHashMap<>();
    private static HttpClient httpclient = new HttpClient();

    public void run() {
        while (true) {
            if (SearchClient.searchList.isEmpty()) {
                synchronized (SearchClient.searchList) {
                    if (SearchClient.searchList.isEmpty()) {
                        try {
                            SearchClient.searchList.wait();
                        } catch (InterruptedException e) {
                            Thread.currentThread().interrupt();
                            e.printStackTrace();
                        }
                    }
                }
            }

            String query = SearchClient.searchList.remove(0);
            try {
                Map result = postQuery2Solr(query);
                SearchClient.resultMap.put(query, result);

            }catch (Exception e){
                e.printStackTrace();
            }finally {
                synchronized (query){
                    query.notifyAll();
                }
            }
        }
    }

    private Map postQuery2Solr(String query) throws Exception {
        String url = PalConst.getInstance().solrUrl + query;
        HttpMethod method = new GetMethod(url);
        httpclient.executeMethod(method);
        String json = method.getResponseBodyAsString();
        System.out.println(method.getResponseBodyAsString());
        method.releaseConnection();
        Map<?, ?> map = JsonUtil.parseJsonStringToMap(json);
        return map;
    }

    public static void main (String[]args){
        SearchClient client = new SearchClient();
        try {
            System.out.println(URLEncoder.encode("<font color='red'>","utf-8"));
            client.postQuery2Solr("%E7%89%9B");
        }catch (Exception e){
            e.printStackTrace();
        }
    }

}
